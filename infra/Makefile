SHELL:=/bin/bash

# note: this is a demo project; dev and prod terraform resources 
# are deployed from the same tf config intentionally.  leave env=dev as default for 
# terraform state backend
env=dev
region=us-east-1

terraform-backend-region=us-east-1
terraform-backend-bucket=tf-state-$(terraform-backend-region)-$(env)
terraform-backend-key=mkdocs-demo.tfstate

init: check-env check-region clean
	terraform init -backend-config="bucket=$(terraform-backend-bucket)" -backend-config="region=$(terraform-backend-region)"

validate: init
	terraform fmt -recursive
	terraform validate

clean:
	rm -rf .terraform
	rm -rf .tfplan

plan: check-env check-region validate
	export "AWS_REGION=$(region)" && \
	export "TF_VAR_region=$(region)" && \
	terraform plan -out=$(env).tfplan -state="$(terraform-backend-key)"

apply: check-env check-region
	export "AWS_REGION=$(region)" && \
	export "TF_VAR_region=$(region)" && \
	terraform apply -state-out="$(terraform-backend-key)" $(env).tfplan 

check-env:
ifndef env
	$(error env is not defined)
endif

check-region:
ifndef region
	$(error region is not defined)
endif
