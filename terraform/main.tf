// terraform apply -var-file=secrets.tfvars -auto-approve
// terraform destroy -var-file=secrets.tfvars -auto-approve
// terraform init -var-file=secrets.tfvars
variable "aws_acces" {} //key
variable "aws_secret" {} //key
variable "cloudflare_api" {} //key

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  access_key = var.aws_acces  //key
  secret_key = var.aws_secret //key
  region = "eu-north-1"
}

// MasterHost
resource "aws_instance" "master_host" {
  availability_zone       = "eu-north-1a"
  ami                     = "ami-0014ce3e52359afbd"
  instance_type           = "t3.micro"
  key_name                = "Stepik1"
  vpc_security_group_ids  = [aws_security_group.master_host.id]
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 10
    volume_type = "standard"
    tags        = { device_name = "Terraform" }
  }
  tags = { 
    Name = "MasterHost"
  }
}

resource "aws_instance" "node" {
  depends_on = [aws_instance.master_host]
  count                   = 2
  availability_zone       = "eu-north-1a"
  ami                     = "ami-0014ce3e52359afbd"
  instance_type           = "t3.micro"
  key_name                = "Stepik1"
  vpc_security_group_ids  = [aws_security_group.nodes.id]
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 10
    volume_type = "standard"
    tags        = { device_name = "Terraform" }
  }
  tags = { 
    Name = "Node-${count.index + 1}"
  }
}


resource "aws_security_group" "master_host" {
  name = "Terraform-master-host"
  ingress{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port = 2377
    to_port = 2377
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] //fix
  }
  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "nodes" {
  name = "Terraform-nodes"
  ingress{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "null_resource" "ansible_inventory" {
  depends_on = [aws_instance.node]
  triggers = {
    master_host_ips = join(",", aws_instance.master_host.*.public_ip)
    node_ips        = join(",", aws_instance.node.*.public_ip)
  }

  provisioner "local-exec" {
    command = <<EOT
cat > ./inventory/hosts <<EOF
[master]
${join("\n", aws_instance.master_host.*.public_ip)}

[nodes]
${join("\n", aws_instance.node.*.public_ip)}
EOF
EOT
  }
  provisioner "local-exec" {
    command = "sleep 60 && ansible-playbook -u ubuntu -i ./inventory/hosts --private-key Stepik1.pem --ssh-common-args='-o StrictHostKeyChecking=accept-new' playbook.yml"
  }
  
}