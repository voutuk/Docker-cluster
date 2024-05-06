* This repository creates EC2 instances using Terraform and sets up a Docker Swarm cluster using Ansible.
* In the `terraform` directory, Terraform is used to create EC2 instances and configure networking.
* Ansible is then used to provision the instances and set up the Docker Swarm cluster.
* Finally, a website is deployed on the Docker Swarm cluster.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Installation

1. Install Terraform by following the official installation guide.

2. Create a file named `secrets.tfvars` with the following information:

    ```tfvars
    aws_acces = "YOUR_AWS_ACCESS_KEY"
    aws_secret = "YOUR_AWS_SECRET_KEY"
    cloudflare_api = "YOUR_CLOUADFLARE_API_KEY"
    ```

3. Install Ansible by running the following command:

    ```bash
    wget -qO- https://raw.githubusercontent.com/voutuk/file/main/an.sh | sudo bash
    ```

    [:octocat:Github](https://github.com/voutuk/Scripts)

> [!NOTE]  
> Please note that you need to replace `YOUR_AWS_ACCESS_KEY`, `YOUR_AWS_SECRET_KEY`, and `YOUR_CLOUADFLARE_API_KEY` with your actual AWS access key, secret key, and Cloudflare API key. The Cloudflare API key should have the necessary permissions to edit zone DNS records.

## Usage

To use, follow these steps:

1. Run the following commands to apply the Terraform configuration:

    ```bash
    terraform init
    terraform apply -var-file="secrets.tfvars" -auto-approve
    ```

2. To destroy the infrastructure created by Terraform, run the following command:

    ```bash
    terraform destroy -var-file="secrets.tfvars" -auto-approve
    ```

## License

This project is licensed under the [Creative Commons Zero v1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/) license, which grants full rights for editing and usage purposes to everyone.
