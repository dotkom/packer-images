locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

variable "environment" {
  type =  string
  default = "testing"
}

variable "consul_version" {
  type =  string
  default = "1.9.3"
}

variable "vault_version" {
  type =  string
  default = "1.6.2"
}

variable "vault_url" {
  type =  string
  default = "https://vault.online.ntnu.no:8200"
}

variable "vault_ssh_client_signer_path" {
  type =  string
  default = "ssh-client-signer"
}

variable "vault_ssh_host_signer_path" {
  type =  string
  default = "ssh-host-signer"
}

locals {
  cloud_provider_map = {
    amazon-ebs = "aws"
    vagrant = "aws"
  }

  user_map = {
    amazon-ebs = "dotkom"
    vagrant = "ubntu"
  }
}

source "amazon-ebs" "default" {
    ami_name      = "dotkom/images/${var.environment}/hvm-ssd/ubuntu-focal-20.04-baseline-${local.timestamp}"
    instance_type = "t3a.nano"
    region        = "eu-west-1"
    source_ami    = "ami-08bac620dc84221eb"
    ssh_username  = "dotkom"
    tags = {
      environment = var.environment
    }

    user_data = <<EOF
#cloud-config
system_info:
  default_user:
    name: dotkom
EOF
}

source "vagrant" "testing" {
  communicator = "ssh"
  source_path = "ubuntu/focal64"
  provider = "virtualbox"
}

build {
    sources = ["source.amazon-ebs.default", "vagrant.testing"]

    provisioner "shell" {
      inline = [
        "sudo apt-get update",
        "sudo apt-get install software-properties-common",
        "sudo apt-add-repository --yes --update ppa:ansible/ansible",
        "sudo apt-get install ansible -y"
      ]
    }

    provisioner "ansible-local" {
      playbook_file = "./ansible/main.yml"
      playbook_dir = "./ansible"
      extra_arguments = [
      "-e consul_version=${var.consul_version}",
      "-e vault_version=${var.vault_version}",
      "-e vault_url=${var.vault_url}",
      "-e vault_ssh_client_signer_path=${var.vault_ssh_client_signer_path}",
      "-e vault_ssh_host_signer_path=${var.vault_ssh_host_signer_path}",
      "-e cloud_provider=${local.cloud_provider_map[source.type]}",
      "-e ansible_python_interpreter=/usr/bin/python3", 
      "-u ${local.user_map[source.type]}"
      ]
    }

    provisioner "file"{
      source = "./inspec"
      destination = "/tmp/inspec"
    }

    provisioner "shell" {
      inline = [
        "curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec",
        "sudo inspec exec --chef-license=accept /tmp/inspec",
        "sudo apt-get remove inspec -y"
      ]
    }

}