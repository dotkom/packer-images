source "amazon-ebs" "ubuntu" {
  skip_create_ami             = var.skip_create_image
  ami_name                    = "dotkom/images/hvm-ssd/ubuntu-focal-20.04-base-${local.timestamp}"
  ami_description             = "Base image to use for other builds. Can also be used on it's own for one off tasks"
  spot_instance_types         = ["t3.small"]
  spot_price                  = "auto"
  region                      = var.aws_region
  associate_public_ip_address = "true"
  ssh_interface               = "public_ip"

  vault_aws_engine {
    name = "packer-builder"
  }

  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
    }

    owners      = ["099720109477"]
    most_recent = true
  }

  ssh_username = "ubuntu"
  tags = merge({
    Packer = true
    Source = "{{ .SourceAMI }}"
    Name   = "Dotkom ubuntu 20.04"
  }, var.aws_ami_tags)

  fleet_tags = merge({
    Packer = true
    Source = "{{ .SourceAMI }}"
    Name   = "Dotkom ubuntu 20.04"
  }, var.aws_ami_tags)

}
