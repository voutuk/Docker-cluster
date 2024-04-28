// terraform apply -var-file=secrets.tfvars -auto-approve
// terraform destroy -var-file=secrets.tfvars -auto-approve
// terraform init -var-file=secrets.tfvars
variable "aws_acces" {} //key
variable "aws_secret" {} //key


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
resource "aws_instance" "AWS-0" {
  availability_zone = "eu-north-1a"
  ami = "ami-0014ce3e52359afbd"
  instance_type = "t3.micro"
  key_name = "Stepik1"
  vpc_security_group_ids = [aws_security_group.AWS-1.id]
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 10
    volume_type = "standard"
    tags = {device_name = "Terraform"}
  }
  tags = { 
    Name = "MasterHost"
  }
  provisioner "file" {                               # OFF SLOW OFF key error
    source      = "${path.module}/master.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo bash /tmp/script.sh",
    ]
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    password    = ""
    private_key = file("${path.module}/Stepik1.pem")
    host        = self.public_ip
  }
}

// Node1
resource "aws_instance" "AWS-1" {
  availability_zone = "eu-north-1a"
  ami = "ami-0014ce3e52359afbd"
  instance_type = "t3.micro"
  key_name = "Stepik1"
  vpc_security_group_ids = [aws_security_group.AWS-1.id]
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 10
    volume_type = "standard"
    tags = {device_name = "Terraform"}
  }
  tags = { 
    Name = "Node-1"
  }
  provisioner "file" {                               # OFF SLOW OFF key error
    source      = "${path.module}/node.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo bash /tmp/script.sh",
    ]
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    password    = ""
    private_key = file("${path.module}/Stepik1.pem")
    host        = self.public_ip
  }
}

// Node2
resource "aws_instance" "AWS-2" {
  availability_zone = "eu-north-1a"
  ami = "ami-0014ce3e52359afbd"
  instance_type = "t3.micro"
  key_name = "Stepik1"
  vpc_security_group_ids = [aws_security_group.AWS-1.id]
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 10
    volume_type = "standard"
    tags = {device_name = "Terraform"}
  }
  tags = { 
    Name = "Node-2"
  }
  provisioner "file" {                               # OFF SLOW OFF key error
    source      = "${path.module}/node.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo bash /tmp/script.sh",
    ]
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    password    = ""
    private_key = file("${path.module}/Stepik1.pem")
    host        = self.public_ip
  }
}

// Node3
resource "aws_instance" "AWS-3" {
  availability_zone = "eu-north-1a"
  ami = "ami-0014ce3e52359afbd"
  instance_type = "t3.micro"
  key_name = "Stepik1"
  vpc_security_group_ids = [aws_security_group.AWS-1.id]
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 10
    volume_type = "standard"
    tags = {device_name = "Terraform"}
  }
  tags = { 
    Name = "Node-3"
  }
  provisioner "file" {                               # OFF SLOW OFF key error
    source      = "${path.module}/node.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo bash /tmp/script.sh",
    ]
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    password    = ""
    private_key = file("${path.module}/Stepik1.pem")
    host        = self.public_ip
  }
}

resource "aws_security_group" "AWS-0" {
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
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port = 7946
    to_port = 7946
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port = 7946
    to_port = 7946
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port = 4789
    to_port = 4789
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "AWS-1" {
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
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port = 7946
    to_port = 7946
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port = 7946
    to_port = 7946
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port = 4789
    to_port = 4789
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "AWS-2" {
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
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port = 7946
    to_port = 7946
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port = 7946
    to_port = 7946
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port = 4789
    to_port = 4789
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "AWS-3" {
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
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port = 7946
    to_port = 7946
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port = 7946
    to_port = 7946
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port = 4789
    to_port = 4789
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "AWS-0" {
    value = aws_instance.AWS-0.public_ip
}
output "AWS-1" {
    value = aws_instance.AWS-1.public_ip
}
output "AWS-2" {
    value = aws_instance.AWS-2.public_ip
}
output "AWS-3" {
    value = aws_instance.AWS-3.public_ip
}