resource "aws_cloudfront_distribution" "main" {
  origin {
    domain_name = var.origin_domain_name
    origin_id   = "api-gateway-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  enabled = true

  default_cache_behavior {
    target_origin_id       = "api-gateway-origin"
    viewer_protocol_policy = "allow-all"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

output "cloudfront_distribution_domain_name" {
  value = aws_cloudfront_distribution.main.domain_name
}

output "cloudfront_distribution_zone_id" {
  value = aws_cloudfront_distribution.main.hosted_zone_id
}
