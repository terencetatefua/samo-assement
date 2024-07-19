module "vpc" {
  source = "./modules/vpc"
}

module "ecs" {
  source     = "./modules/ecs"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
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