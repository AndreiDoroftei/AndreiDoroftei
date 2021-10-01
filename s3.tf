resource "aws_s3_bucket" "website" {
  bucket_prefix = var.bucket_prefix
  acl           = "public-read"
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket" "redirect-website" {
  bucket_prefix            = var.bucket_prefix
  acl                      = "public_read"
  redirect_all_requests_to = aws_s3_bucket.website
}

resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.website.id}/*"
            ]
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_object" "home_page" {
  bucket       = aws_s3_bucket.website.id
  content_type = "text/html"
  key          = "index.html"
  acl          = "public-read"
  source       = "index.html"
}

resource "aws_s3_bucket_object" "photo" {
  count        = 2
  bucket       = aws_s3_bucket.website.id
  content_type = "image/png"
  key          = "orar_grupa_${count.index + 1}.png"
  source       = "orar_grupa_${count.index + 1}.png"
}

resource "aws_s3_bucket_object" "error_page" {
  bucket       = aws_s3_bucket.website.id
  content_type = "text/html"
  key          = "error.html"
  acl          = "public-read"
  source       = "error.html"
}