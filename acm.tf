resource "aws_acm_certificate" "cert" {
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_record" "acm" {
  depends_on = [aws_acm_certificate.cert]
  zone_id    = var.cloudflare_zone_id
  name = element(tolist(aws_acm_certificate.cert.domain_validation_options), 0).resource_record_name
  type = element(tolist(aws_acm_certificate.cert.domain_validation_options), 0).resource_record_type
  value = element(tolist(aws_acm_certificate.cert.domain_validation_options), 0).resource_record_value
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "aws_acm_certificate_validation" "cert" {
  depends_on = [aws_acm_certificate.cert]

  certificate_arn = aws_acm_certificate.cert.arn
}

resource "cloudflare_record" "cname" {
  depends_on = [aws_cloudfront_distribution.s3_distribution]
  zone_id = var.cloudflare_zone_id
  name    = var.domain_name
  value   = aws_cloudfront_distribution.s3_distribution.domain_name
  type    = "CNAME"
}

resource "cloudflare_record" "www" {
  depends_on = [aws_cloudfront_distribution.s3_distribution]
  zone_id    = var.cloudflare_zone_id
  name       = "www"
  value      = aws_cloudfront_distribution.s3_distribution.domain_name
  type       = "CNAME"
}