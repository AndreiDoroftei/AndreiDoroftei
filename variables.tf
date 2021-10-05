variable "bucket_name" {
  type        = string
  description = "Bucket"
}
variable "region" {
  type        = string
  description = "The region to be used"
}

variable "domain_name" {
  description = "This is the domain name you want to use to point your website. (eg. example.com, www.example.com etc)"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "The DNS zone ID in which add the record. You can get this from the domain view in the cloudflare dashboard."
  type        = string
}

data "aws_ssm_parameter" "cloudflare_email" {
  name = "cloudflare_email"
}

data "aws_ssm_parameter" "cloudflare_api_key" {
  name = "cloudflare_api_key"
}