variable "domain_name" {
  description = "The domain name for Route 53"
  type        = string
}

variable "alb_dns_name" {
  description = "The DNS name of the ALB"
  type        = string
}

variable "alb_hosted_zone_id" {
  description = "The Hosted Zone ID of the ALB"
  type        = string
}
