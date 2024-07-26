variable "vpc_id" {
  description = "The ID of the VPC where the resources will be created"
  type        = string
}

variable "list_of_open_ports" {
  description = "A list of ports to open in the security group"
  type        = list(number)
}
