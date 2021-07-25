locals {
  cloud_provider_map = {
    amazon-ebs = "aws"
  }
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}