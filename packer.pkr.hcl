variable "ami_tags" {
  type    = map(string)
  default = {}
}

locals {
  cloud_provider_map = {
    amazon-ebs = "aws"
  }
  timestamp           = regex_replace(timestamp(), "[- TZ:]", "")
  ssh_trusted_user_ca = vault("/ssh-client-signer/config/ca", "public_key")
}

source "amazon-ebs" "default" {
  ami_name      = "dotkom/images/hvm-ssd/ubuntu-focal-20.04-baseline-${local.timestamp}"
  instance_type = "t3a.nano"
  region        = "eu-west-1"

  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
    }

    owners      = ["099720109477"]
    most_recent = true
  }

  ssh_username = "dotkom"

  tags = merge({
    packer = true
    source = "{{ .SourceAMI }}"
    Name   = "Packer baseline"
  }, var.ami_tags)

  user_data_file = "./cloud-config.yml"
}

build {
  sources = ["source.amazon-ebs.default"]

  provisioner "shell" {
    inline = [
      "sudo touch /etc/ssh/trusted-user-ca-keys.pem",
      "sudo sh -c  \"echo '${local.ssh_trusted_user_ca}' > /etc/ssh/trusted-user-ca-keys.pem\"",
      "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done"
    ]
  }

  provisioner "ansible-local" {
    playbook_file = "./ansible/playbook.yml"
    playbook_dir  = "./ansible"
    extra_arguments = [
      "-e cloud_provider=${local.cloud_provider_map[source.type]}",
      "-e ansible_python_interpreter=/usr/bin/python3",
      "-u dotkom"
    ]
  }

  provisioner "file" {
    source      = "./inspec"
    destination = "/tmp/inspec"
  }

  provisioner "shell" {
    inline = [
      "curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec",
      "sudo inspec exec --chef-license=accept /tmp/inspec",
      "sudo apt-get remove inspec ansible -y",
    ]
  }

}
