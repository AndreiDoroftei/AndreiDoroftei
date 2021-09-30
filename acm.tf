resource "aws_acm_certificate" "cert" {
  domain_name = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_record" "acm" {
  depends_on = [aws_acm_certificate.cert]
  for_each = { for cer in aws_acm_certificate.cert.domain_validation_options : cer.domain_name => {
    name   = cer.resource_record_name
    value = cer.resource_record_value
    type   = cer.resource_record_type
    }
  }
  name  = each.value.name
  type  = each.value.type
  value = each.value.value

  zone_id = var.cloudflare_zone_id
  # count = length(aws_acm_certificate.cert.domain_validation_options)
  # name    = aws_acm_certificate.cert[*].domain_validation_options.resource_record_name
  # value   = aws_acm_certificate.cert[*].domain_validation_options.resource_record_value
  # type    = aws_acm_certificate.cert[*].domain_validation_options.resource_record_type
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