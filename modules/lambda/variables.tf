
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "The IDs of the subnets"
  type        = list(string)
}

variable "dynamodb_arn" {
  description = "The ARN of the DynamoDB table"
  type        = string
}
