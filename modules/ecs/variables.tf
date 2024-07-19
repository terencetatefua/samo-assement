variable "vpc_id" {
  description = "The ID of the VPC where the ECS cluster will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "The IDs of the subnets where the ECS tasks will be deployed"
  type        = list(string)
}
