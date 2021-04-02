locals {
  cloud_provider_map = {
    amazon-ebs = "aws"
  }
  timestamp           = regex_replace(timestamp(), "[- TZ:]", "")
  ssh_trusted_user_ca = vault("/ssh-client-signer/config/ca", "public_key")
}