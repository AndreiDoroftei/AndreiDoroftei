variable "bucket_prefix" {
  type        = string
  description = "Bucket"
  default     = "doroftei1999-bucket"
}
variable "region" {
  type        = string
  default     = "us-east-1"
  description = "The region to be used"
}

variable "domain_name" {
  description = "This is the domain name you want to use to point your website. (eg. example.com, www.example.com etc)"
  type        = string
  default     = "doroftei.xyz"
}

variable "cloudflare_zone_id" {
  description = "The DNS zone ID in which add the record. You can get this from the domain view in the cloudflare dashboard."
  type        = string
  default     = "ecab00b9e588e3afb2ebbb76567760ec"
}

variable "cloudflare_email" {
  type    = string
  default = "doroftei1999@yahoo.com"
}

variable "cloudflare_api_key" {
  type    = string
  default = "8e622c6069d6827c4d1748d7e2ad6f46eb787"
}