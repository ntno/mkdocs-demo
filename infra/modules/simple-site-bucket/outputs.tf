output "site_bucket_info" {
  description = "Map containing the site bucket's arn, id, and website endpoint"
  value = {
    "arn"              = aws_s3_bucket.site_bucket.arn
    "id"               = aws_s3_bucket.site_bucket.id
    "website_endpoint" = aws_s3_bucket_website_configuration.site_bucket_website_configuration.website_endpoint
  }
}