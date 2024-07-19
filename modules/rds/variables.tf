variable "vpc_id" {
  description = "The ID of the VPC where the RDS instances will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "The IDs of the subnets where the RDS instances will be deployed"
  type        = list(string)
}
