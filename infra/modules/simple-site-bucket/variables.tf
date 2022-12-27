variable "bucket_name" {
  description = "Name of the S3 bucket for simple website.  Must be unique in S3."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to set"
  type        = map(string)
  default     = {}
}