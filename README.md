## Introduction
## The architecture includes:

API Gateway: To manage API requests. IAM Role for API Gateway to Invoke Lambda: The API Gateway has a permission to invoke the Lambda function.
AWS Lambda: For executing business logic. IAM Policy for Lambda to Access DynamoDB: The Lambda function has a policy to access DynamoDB.
Amazon Cognito: For user authentication.
Amazon CloudFront: For CDN capabilities.
Amazon ECS on Fargate: For running containerized microservices.
Amazon RDS: For microservice databases.
Amazon Kinesis/Kafka: For real-time streaming of order data.
AWS Lambda/Kinesis Data Analytics: For real-time processing and updating inventory.
Amazon DynamoDB: For inventory management.
Application Load Balancer (ALB): For load balancing.
Auto Scaling Groups: For dynamic traffic handling.
IAM Policies and Roles
This setup includes various IAM roles and policies to ensure secure access between different services:

Lambda to DynamoDB: Allows Lambda to access DynamoDB.
API Gateway to Lambda: Allows API Gateway to invoke Lambda.
ECS to RDS: Allows ECS tasks to access RDS databases.
Kinesis to Lambda: Allows Lambda to read from Kinesis streams.
ECS to DynamoDB: Allows ECS tasks to read from DynamoDB.

## Prerequisites

-Terraform and AWS CLI installed.
-Update backend s3 with appropriate names
-create s3 bucket for backend and dynamodb for state lock
-create secret in AWS secret manager. This configuration ensures that existing secrets are used to configure the RDS instances without creating new secrets through Terraform for security purposes
-update username and password in rds module with appropriate aws secret manager details

## Note
-create the necessary IAM policies and roles so that the ECS inventory service has full DynamoDB access, while the product and user services have read-only access.

1. **Clone the repository:**

   ```sh
   git clone https://github.com/terencetatefua/samo-assement.git
   cd samo-assement

## Setup
## Initialize Terraform:
 terraform init
 ## Review and Apply the Terraform Plan:
terraform plan
terraform apply
## cleanup
- terraform destroy

### AWS cert
- https://www.credly.com/badges/6824a2c5-4f33-4b49-8ea7-7f04b5ebf1fa/public_url
- https://www.credly.com/badges/e9c3ecb9-3400-4c3d-b577-f05383532026


| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |


## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api_gateway"></a> [api\_gateway](#module\_api\_gateway) | ./modules/api_gateway | n/a |
| <a name="module_dynamodb"></a> [dynamodb](#module\_dynamodb) | ./modules/dynamodb | n/a |
| <a name="module_ecs"></a> [ecs](#module\_ecs) | ./modules/ecs | n/a |
| <a name="module_iam"></a> [iam](#module\_iam) | ./modules/iam | n/a |
| <a name="module_kinesis"></a> [kinesis](#module\_kinesis) | ./modules/kinesis | n/a |
| <a name="module_lambda"></a> [lambda](#module\_lambda) | ./modules/lambda | n/a |
| <a name="module_rds"></a> [rds](#module\_rds) | ./modules/rds | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | The AWS region to deploy resources in | `string` | `"us-east-2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_gateway_url"></a> [api\_gateway\_url](#output\_api\_gateway\_url) | The URL of the API Gateway |
| <a name="output_dynamodb_table_arn"></a> [dynamodb\_table\_arn](#output\_dynamodb\_table\_arn) | The ARN of the DynamoDB table |
| <a name="output_ecs_cluster_id"></a> [ecs\_cluster\_id](#output\_ecs\_cluster\_id) | The ID of the ECS cluster |
| <a name="output_ecs_task_execution_role_arn"></a> [ecs\_task\_execution\_role\_arn](#output\_ecs\_task\_execution\_role\_arn) | The ARN of the ECS task execution role |
| <a name="output_kinesis_stream_arn"></a> [kinesis\_stream\_arn](#output\_kinesis\_stream\_arn) | The ARN of the Kinesis stream |
| <a name="output_lambda_arn"></a> [lambda\_arn](#output\_lambda\_arn) | The ARN of the Lambda function |
| <a name="output_product_service_role_arn"></a> [product\_service\_role\_arn](#output\_product\_service\_role\_arn) | The ARN of the Product Service role |
| <a name="output_rds_inventory_instance_endpoint"></a> [rds\_inventory\_instance\_endpoint](#output\_rds\_inventory\_instance\_endpoint) | The endpoint of the RDS instance for Inventory Service |
| <a name="output_rds_product_instance_endpoint"></a> [rds\_product\_instance\_endpoint](#output\_rds\_product\_instance\_endpoint) | The endpoint of the RDS instance for Product Service |
| <a name="output_rds_user_instance_endpoint"></a> [rds\_user\_instance\_endpoint](#output\_rds\_user\_instance\_endpoint) | The endpoint of the RDS instance for User Service |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | The IDs of the subnets |
| <a name="output_user_service_role_arn"></a> [user\_service\_role\_arn](#output\_user\_service\_role\_arn) | The ARN of the User Service role |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
