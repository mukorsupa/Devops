variable "region" {
  description = "The AWS region to create resources in"
  default     = "us-west-2"
}

variable "ami" {
  description = "The AMI to use for the EC2 instances"
  default     = "ami-0a38c1c38a15fed74"
}

variable "instance_type" {
  description = "The type of EC2 instance to create"
  default     = "t2.micro"
}