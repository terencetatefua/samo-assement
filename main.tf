module "vpc" {
  source = "./modules/vpc"
}

module "iam" {
  source = "./modules/iam"
}

module "ecs" {
  source                           = "./modules/ecs"
  vpc_id                           = module.vpc.vpc_id
  subnet_ids                       = module.vpc.subnet_ids
  ecs_task_execution_role_arn      = module.iam.ecs_task_execution_role_arn
  product_service_role_arn         = module.iam.product_service_role_arn
  user_service_role_arn            = module.iam.user_service_role_arn
  ecs_service_ip                   = module.ecs.ecs_service_ip  # Use the output from the ECS module
}

module "dynamodb" {
  source = "./modules/dynamodb"
}

module "rds" {
  source     = "./modules/rds"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
}

module "lambda" {
  source       = "./modules/lambda"
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.subnet_ids
  dynamodb_arn = module.dynamodb.table_arn
}

module "kinesis" {
  source     = "./modules/kinesis"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
}

module "api_gateway" {
  source     = "./modules/api_gateway"
  lambda_arn = module.lambda.lambda_arn
}

module "cloudfront" {
  source             = "./modules/cloudfront"
  origin_domain_name = "api.tamispaj.com"
}

module "route53" {
  source             = "./modules/route53"
  domain_name        = var.domain_name
  alb_dns_name       = module.ecs.alb_dns_name
  alb_hosted_zone_id = module.ecs.alb_hosted_zone_id
}

data "aws_elb_service_account" "main" {}
