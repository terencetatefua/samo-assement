variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-2"
}
variable "domain_name" {
  description = "The domain name for Route 53"
  type        = string
  default     = "tamispaj.com"
}

