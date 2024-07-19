resource "aws_iam_role" "ecs_task_execution" {
  name = "inventory-service-ecs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_policy" "ecs_full_dynamodb" {
  name        = "inventory-service-ecs-full-dynamodb"
  description = "Full access to DynamoDB for ECS tasks"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "dynamodb:*"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_full_dynamodb_attachment" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = aws_iam_policy.ecs_full_dynamodb.arn
}

resource "aws_iam_role" "product_service_role" {
  name = "ProductServiceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "product_read_only_dynamodb" {
  name        = "product-read-only-dynamodb"
  description = "Read-only access to DynamoDB for Product Service"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "dynamodb:GetItem",
          "dynamodb:Scan",
          "dynamodb:Query",
          "dynamodb:DescribeTable",
          "dynamodb:BatchGetItem"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "product_read_only_dynamodb_attachment" {
  role       = aws_iam_role.product_service_role.name
  policy_arn = aws_iam_policy.product_read_only_dynamodb.arn
}

resource "aws_iam_role" "user_service_role" {
  name = "UserServiceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "user_read_only_dynamodb" {
  name        = "user-read-only-dynamodb"
  description = "Read-only access to DynamoDB for User Service"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "dynamodb:GetItem",
          "dynamodb:Scan",
          "dynamodb:Query",
          "dynamodb:DescribeTable",
          "dynamodb:BatchGetItem"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "user_read_only_dynamodb_attachment" {
  role       = aws_iam_role.user_service_role.name
  policy_arn = aws_iam_policy.user_read_only_dynamodb.arn
}

output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution.arn
}

output "product_service_role_arn" {
  value = aws_iam_role.product_service_role.arn
}

output "user_service_role_arn" {
  value = aws_iam_role.user_service_role.arn
}
