resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket = aws_s3_bucket.site_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_versioning" "site_bucket_versioning" {
  bucket = aws_s3_bucket.site_bucket.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "site_bucket_server_side_encryption" {
  bucket = aws_s3_bucket.site_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_website_configuration" "site_bucket_website_configuration" {
  bucket = aws_s3_bucket.site_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}

resource "aws_s3_bucket" "site_bucket" {
  bucket = var.bucket_name
  tags   = var.tags

  force_destroy = true
}

resource "aws_s3_bucket_policy" "site_bucket_policy" {
  bucket = aws_s3_bucket.site_bucket.id
  policy = templatefile("${path.module}/templates/policy.tpl",
    {
      bucket-name = var.bucket_name
    }
  )
}
