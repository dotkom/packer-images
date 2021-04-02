
build {
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    inline = [
      "sleep 10",
      "sudo apt-get update",
      "sudo apt-get --yes install software-properties-common",
      "sudo apt-add-repository --yes --update ppa:ansible/ansible",
      "sudo apt-get --yes install ansible",
      "sudo touch /etc/ssh/trusted-user-ca-keys.pem",
      "sudo sh -c  \"echo '${local.ssh_trusted_user_ca}' > /etc/ssh/trusted-user-ca-keys.pem\"",
    ]
  }

  provisioner "ansible-local" {
    playbook_file = "${path.root}/playbook.yml"
    playbook_dir  = "${path.root}/../../ansible"
    extra_arguments = [
      "-e cloud_provider=${local.cloud_provider_map[source.type]}",
      "-e consul_datacenter=${var.aws_consul_datacenter}",
      "-e ansible_python_interpreter=/usr/bin/python3",
      "-u dotkom"
    ]
  }

  provisioner "file" {
    source      = "${path.root}/../../inspec"
    destination = "/tmp/inspec"
  }

  provisioner "shell" {
    inline = [
      "sudo inspec exec --chef-license=accept /tmp/inspec/base",
      "sudo inspec exec --chef-license=accept /tmp/inspec/consul",
    ]
  }

}
