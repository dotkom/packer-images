source "amazon-ebs" "base" {
  ami_name                    = "dotkom/images/hvm-ssd/ubuntu-focal-20.04-consul-server-${local.timestamp}"
  spot_instance_types         = ["t3.small"]
  spot_price                  = "auto"
  region                      = var.aws_region
  associate_public_ip_address = "true"
  ssh_interface               = "public_ip"
  skip_create_ami             = var.skip_create_image

  source_ami_filter {
    filters = {
      name             = "dotkom/images/hvm-ssd/ubuntu-focal-20.04-base-*"
      "tag:Production" = "true"
    }

    owners      = ["891459268445"]
    most_recent = true
  }

  ssh_username = "ubuntu"

  tags = merge({
    Packer = true
    Source = "{{ .SourceAMI }}"
    Name   = "Consul server"
  }, var.aws_ami_tags)

  fleet_tags = merge({
    Packer = true
    Source = "{{ .SourceAMI }}"
    Name   = "Consul server"
  }, var.aws_ami_tags)

}
