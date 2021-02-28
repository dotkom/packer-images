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



source "amazon-ebs" "default" {
    ami_name      = "dotkom/images/${var.environment}/hvm-ssd/ubuntu-focal-20.04-baseline-${local.timestamp}"
    instance_type = "t3a.nano"
    region        = "eu-west-1"
    source_ami    = "ami-08bac620dc84221eb"
    ssh_username  = "dotkom"
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
    sources = ["source.amazon-ebs.default"]

    provisioner "ansible" {
      playbook_file = "./ansible/main.yml"
      extra_arguments = [
      "-e consul_version=${var.consul_version}",
      "-e vault_version=${var.vault_version}",
      "-e vault_url=${var.vault_url}",
      "-e vault_ssh_client_signer_path=${var.vault_ssh_client_signer_path}",
      "-e vault_ssh_host_signer_path=${var.vault_ssh_host_signer_path}",
      "-e vault_login_method=aws",
      "-e sign_host_key=true",
      "-e cloud_provider=aws",
      "-e", "ansible_python_interpreter=/usr/bin/python3", 
      "-u", "dotkom"
      ]
    }

    provisioner "inspec" {
      profile = "./inspec"
    }
}



build {
    sources = ["source.vagrant.testing"]
    provisioner "ansible" {
      playbook_file = "./ansible/main.yml"
      extra_arguments = [
      "-e consul_version=${var.consul_version}",
      "-e vault_version=${var.vault_version}",
      "-e vault_url=${var.vault_url}",
      "-e vault_ssh_client_signer_path=${var.vault_ssh_client_signer_path}",
      "-e vault_ssh_host_signer_path=${var.vault_ssh_host_signer_path}",
      "-e vault_login_method=aws",
      "-e cloud_provider=aws",
      "-e sign_host_key=false",
      "--user", "ubuntu",
      ]
    }

    provisioner "inspec" {
      profile = "./inspec"
    }
}
