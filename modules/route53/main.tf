resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "api" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "api.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

output "route53_zone_id" {
  value = aws_route53_zone.main.zone_id
}

output "route53_record_fqdn" {
  value = aws_route53_record.api.fqdn
}
