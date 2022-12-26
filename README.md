# mkdocs-demo
mkdocs demo site  

[![Release](https://github.com/ntno/mkdocs-demo/actions/workflows/release.yml/badge.svg)](https://github.com/ntno/mkdocs-demo/actions/workflows/release.yml) - deploys to [factually-settled-boxer.s3-website-us-east-1.amazonaws.com](http://factually-settled-boxer.s3-website-us-east-1.amazonaws.com/)

# prerequisites

- set up OIDC provider
   - [Use OpenID Connect within your workflows to authenticate with Amazon Web Services.](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
- create site and supporting cicd infrastructure 

## infrastructure (one-time set up)
```
make ubuntu
cd infra
make plan
make apply
```

# development

`make serve`

