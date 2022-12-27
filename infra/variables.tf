variable "region" {
  type        = string
  description = "The default AWS region for the resource provisioning"
}

variable "site_bucket_name" {
  description = "Name of the S3 bucket for demo site.  Randomized if left blank.  Must be unique in S3."
  type        = string
  default     = ""
}

variable "github_repo" {
  description = "GitHub repository for OIDC"
  type        = string
  default     = "mkdocs-demo"
}

variable "github_org" {
  description = "GitHub organization for OIDC"
  type        = string
  default     = "ntno"
}