resource "aws_kinesis_stream" "order_stream" {
  name             = "order-stream"
  shard_count      = 1
  retention_period = 24
}

resource "aws_iam_role" "kinesis_exec" {
  name = "kinesis_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "kinesis_vpc_access" {
  role       = aws_iam_role.kinesis_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_role_policy" "kinesis_policy" {
  name   = "kinesis_policy"
  role   = aws_iam_role.kinesis_exec.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "kinesis:GetRecords",
          "kinesis:GetShardIterator",
          "kinesis:DescribeStream",
          "kinesis:ListStreams"
        ],
        Resource = aws_kinesis_stream.order_stream.arn
      }
    ]
  })
}

data "archive_file" "lambda_function" {
  type        = "zip"
  source_dir  = "${path.root}/lambda_function"
  output_path = "${path.module}/lambda_function.zip"
}

resource "aws_lambda_function" "stream_processor" {
  function_name    = "stream_processor"
  role             = aws_iam_role.kinesis_exec.arn
  handler          = "main.handler"
  runtime          = "python3.8"
  filename         = data.archive_file.lambda_function.output_path
  source_code_hash = data.archive_file.lambda_function.output_base64sha256

  vpc_config {
    security_group_ids = [aws_security_group.lambda.id]
    subnet_ids         = var.subnet_ids
  }
}

resource "aws_lambda_event_source_mapping" "kinesis_event" {
  event_source_arn  = aws_kinesis_stream.order_stream.arn
  function_name     = aws_lambda_function.stream_processor.arn
  starting_position = "LATEST"
}

resource "aws_security_group" "lambda" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "stream_arn" {
  description = "The ARN of the Kinesis stream"
  value       = aws_kinesis_stream.order_stream.arn
}
