# mkdocs-demo
mkdocs demo site  

## live environments
### integration
- temporary environments are created/destroyed with pull request open/close  
- url is posted to the pull request for review
  
### development
url: [http://factually-settled-boxer-development.s3-website-us-east-1.amazonaws.com](http://factually-settled-boxer-development.s3-website-us-east-1.amazonaws.com)  
deployment workflow: (todo)

### production
url: [http://factually-settled-boxer.s3-website-us-east-1.amazonaws.com](http://factually-settled-boxer.s3-website-us-east-1.amazonaws.com)  
deployment workflow: (todo)

## local development

ex: run server with ['dev/local'](variables.yml#L9-L12) site variables  
`make serve env=dev region=local`

ex: run server with ['dev/us-east-1'](variables.yml#L15-L17) site variables  
`make serve env=dev region=us-east-1`    

ex: run server with ['prod/us-east-1'](variables.yml#L21-L25) site variables  
`make serve env=prod region=us-east-1` 

## prerequisites
- install docker and Make (for local development)
- set up OIDC provider in AWS console
   - [Use OpenID Connect within your workflows to authenticate with Amazon Web Services.](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
- create S3 bucket for static website hosting 
- create supporting cicd resources (S3 bucket for site artifacts and IAM roles for GitHub Action workflows to assume)


### infrastructure (onetime setup)

see terraform code in [`infra/`](infra/) for example on how to create required resources.  [`ntno/tf-module-static-site-cicd`](https://github.com/ntno/tf-module-static-site-cicd) is used to create CICD IAM roles and artifact bucket.

```
make ubuntu
cd infra
make plan
make apply
```

- creates development and production site buckets  
- creates IAM roles to support github action workflows
