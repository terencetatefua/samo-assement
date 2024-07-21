variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "The IDs of the subnets"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security groups allowed to access the RDS instance"
  type        = list(string)
}
