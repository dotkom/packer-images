variable "aws_region" {
  type        = string
  default     = "eu-north-1"
  description = "AWS Region to build the ami in."
}

variable "aws_ami_tags" {
  type        = map(string)
  default     = {}
  description = "Tags to attach to the AWS AMI."
}

variable "skip_create_image" {
  type        = bool
  default     = false
  description = "Wheter to create the image or not. Useful to have it set to true in CI pipeline."
}