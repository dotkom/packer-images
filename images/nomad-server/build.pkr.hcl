build {
  sources = ["source.amazon-ebs.base"]

  provisioner "ansible-local" {
    playbook_file = "${path.root}/playbook.yml"
    playbook_dir  = "${path.root}/../../ansible"

    extra_arguments = [
      "-e cloud_provider=${local.cloud_provider_map[source.type]}",
      "-e ansible_python_interpreter=/usr/bin/python3",
      "-e consul_datacenter=${var.aws_consul_datacenter}",
      "-e nomad_datacenter=${var.aws_nomad_datacenter}",
      "-u dotkom",
    ]
  }

  provisioner "file" {
    source      = "${path.root}/../../inspec"
    destination = "/tmp/inspec"
  }

}
