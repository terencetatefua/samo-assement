variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "The IDs of the subnets"
  type        = list(string)
}

variable "ecs_task_execution_role_arn" {
  description = "The ARN of the ECS task execution role"
  type        = string
}

variable "product_service_role_arn" {
  description = "The ARN of the Product Service role"
  type        = string
}

variable "user_service_role_arn" {
  description = "The ARN of the User Service role"
  type        = string
}
