# outputs.tf in the root module

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "subnet_ids" {
  description = "The IDs of the subnets"
  value       = module.vpc.subnet_ids
}

output "ecs_cluster_id" {
  description = "The ID of the ECS cluster"
  value       = module.ecs.ecs_cluster_id
}

output "ecs_task_execution_role_arn" {
  description = "The ARN of the ECS task execution role"
  value       = module.iam.ecs_task_execution_role_arn
}

output "product_service_role_arn" {
  description = "The ARN of the Product Service role"
  value       = module.iam.product_service_role_arn
}

output "user_service_role_arn" {
  description = "The ARN of the User Service role"
  value       = module.iam.user_service_role_arn
}

output "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB table"
  value       = module.dynamodb.table_arn
}

output "rds_user_instance_endpoint" {
  description = "The endpoint of the RDS instance for User Service"
  value       = module.rds.user_instance_endpoint
}

output "rds_product_instance_endpoint" {
  description = "The endpoint of the RDS instance for Product Service"
  value       = module.rds.product_instance_endpoint
}

output "rds_inventory_instance_endpoint" {
  description = "The endpoint of the RDS instance for Inventory Service"
  value       = module.rds.inventory_instance_endpoint
}

output "lambda_arn" {
  description = "The ARN of the Lambda function"
  value       = module.lambda.lambda_arn
}

output "kinesis_stream_arn" {
  description = "The ARN of the Kinesis stream"
  value       = module.kinesis.stream_arn
}

output "api_gateway_url" {
  description = "The URL of the API Gateway"
  value       = module.api_gateway.api_gateway_url
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = module.ecs.alb_dns_name
}

output "alb_arn" {
  description = "The ARN of the ALB"
  value       = module.ecs.alb_arn
}

output "alb_target_group_arn" {
  description = "The ARN of the ALB target group"
  value       = module.ecs.alb_target_group_arn
}
