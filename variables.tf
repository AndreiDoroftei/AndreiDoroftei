variable "bucket_prefix" {
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

variable "cloudflare_email" {
  type = string
}

variable "cloudflare_api_key" {
  type = string
}