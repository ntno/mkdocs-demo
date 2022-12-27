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

ex: load ['dev/local' site variables](variables.yml#L9-L12)  
`make serve env=dev region=local`

ex: load ['dev/us-east-1' site variables](variables.yml#L15-L17)  
`make serve env=dev region=us-east-1`    

ex: load ['prod/us-east-1' site variables](variables.yml#L21-L25)  
`make serve env=prod region=us-east-1` 

## prerequisites
- docker
- set up OIDC provider in AWS console
   - [Use OpenID Connect within your workflows to authenticate with Amazon Web Services.](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
- create site and supporting cicd infrastructure

## infrastructure (one-time set up)
- creates development and production site buckets  
- creates IAM roles to support github action workflows

```
make ubuntu
cd infra
make plan
make apply
```

