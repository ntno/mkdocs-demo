
resource "random_pet" "site_name" {
  length = 3
}

locals {
  ci_prefix            = format("%s-ci-pr", local.site_name)
  ci_role_name         = format("CI-%s", local.site_name)
  cd_role_name         = format("CD-%s", local.site_name)
  artifact_bucket_name = format("%s-artifacts", local.site_name)
}

module "demo_site_ci_cd" {
  source                     = "git::https://github.com/ntno/tf-module-static-site-cicd?ref=update-oidc-permissions"
  site_bucket                = local.site_name
  artifact_bucket_name       = local.artifact_bucket_name
  ci_prefix                  = local.ci_prefix
  ci_role_name               = local.ci_role_name
  cd_role_name               = local.cd_role_name
  github_repo                = "mkdocs-demo"
  github_org                 = "ntno"
  github_cd_environment_name = "prod"
  cloudfront_distribution_id = "" #no cloudfront distribution for demo project
  tags                       = local.global_tags
}
