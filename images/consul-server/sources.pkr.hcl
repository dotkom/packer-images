source "amazon-ebs" "base" {
  ami_name                    = "dotkom/images/hvm-ssd/ubuntu-focal-20.04-consul-server-${local.timestamp}"
  spot_instance_types         = ["t3.small"]
  spot_price                  = "auto"
  region                      = var.aws_region
  associate_public_ip_address = "true"
  ssh_interface               = "public_ip"

  source_ami_filter {
    filters = {
      name             = "dotkom/images/hvm-ssd/ubuntu-focal-20.04-base-*"
      "tag:production" = "true"
    }

    owners      = ["891459268445"]
    most_recent = true
  }

  ssh_username = "ubuntu"

  tags = merge({
    packer            = true
    source            = "{{ .SourceAMI }}"
    Name              = "Consul server"
    consul_datacenter = "${var.aws_consul_datacenter}"
  }, var.aws_ami_tags)

}
