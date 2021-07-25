variable "aws_region" {
  type        = string
  default     = "eu-north-1"
  description = "AWS Region to build the ami in."
}

variable "aws_consul_datacenter" {
  type        = string
  default     = "aws-eu-north-1"
  description = "Which consul datacenter should the resulting AMI belong to."
}

variable "aws_nomad_datacenter" {
  type        = string
  default     = "aws-eu-north-1"
  description = "Which nomad datacenter should the resulting AMI belong to."
}

variable "aws_ami_tags" {
  type        = map(string)
  default     = {}
  description = "Tags to attach to the AWS AMI."
}

variable "skip_create_image" {
  type        = bool
  default     = true
  description = "Wheter to create the image or not. Useful to have it set to false in CI pipeline."
}