variable "region" {
  type        = string
  description = "The default AWS region for the resource provisioning"
}

variable "site_bucket_name" {
  description = "Name of the S3 bucket for demo site.  Randomized if left blank.  Must be unique in S3."
  type        = string
  default     = ""
}
