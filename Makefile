SHELL:=/bin/bash
artifact-bucket:=s3://factually-settled-boxer-artifacts
artifact-prefix:=/docs-bundle/

ifeq ($(DRY_RUN),1)
   DRY_RUN_FLAG = --dryrun
endif

ifeq ($(QUIET),1)
   QUIET_FLAG = --quiet
endif

ifeq ($(SIZE_ONLY_SYNC),1)
   SIZE_ONLY_FLAG = --size-only
endif

################################################
## run from machine with docker installed
## requires GNU Make
################################################
ubuntu: 
	docker compose run --rm ubuntu 

open-local: 
	open http://localhost:5000

stop: 
	docker compose down --remove-orphans

serve: check-env check-region
	docker compose run --entrypoint "/bin/bash" --service-ports local_development_server -c "make serve-mkdocs env=$(env) region=$(region)"

build: check-env check-region
	docker compose run --entrypoint "/bin/bash" ubuntu -c "make build-mkdocs env=$(env) region=$(region)"

deploy: check-env check-region check-bucket-name
	docker compose run --entrypoint "/bin/bash" ubuntu -c "make deploy-mkdocs env=$(env) region=$(region) bucket-name=$(bucket-name)"

#########################################################
## run from machine or container with required software
## awscli, python, pip, buildenv, GNU Make, etc.
#########################################################
setup-mkdocs: check-env check-region check-download-directory
	curl https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/robots.txt/robots.txt --output $(download-directory)robots.txt
	mv $(download-directory)robots.txt ./docs/robots.txt

build-mkdocs: check-env check-region clean install-requirements
	eval "$$(buildenv -e $(env) -d $(region))" && \
	mkdocs build

archive-mkdocs: check-env check-region check-version
	tar \
		--dereference --hard-dereference \
		--directory ./site/ \
		-cvf ./docs-site.tar \
		. > ./manifest.txt
	aws s3 cp $(DRY_RUN_FLAG) $(QUIET_FLAG) --no-progress --sse AES256 ./docs-site.tar $(artifact-bucket)$(artifact-prefix)$(version)/
	aws s3 cp $(DRY_RUN_FLAG) $(QUIET_FLAG) --no-progress --sse AES256 ./manifest.txt $(artifact-bucket)$(artifact-prefix)$(version)/

get-mkdocs-archive: check-env check-region check-version clean check-download-directory
	mkdir -p site
	aws s3 cp $(DRY_RUN_FLAG) $(QUIET_FLAG) --no-progress $(artifact-bucket)$(artifact-prefix)$(version)/docs-site.tar $(download-directory)
	tar \
		--directory ./site/ \
		-xf $(download-directory)docs-site.tar 

deploy-mkdocs: check-env check-region check-bucket-name 
	aws s3 sync $(DRY_RUN_FLAG) $(QUIET_FLAG) $(SIZE_ONLY_FLAG) --no-progress --sse AES256 ./site/ s3://$(bucket-name)/

serve-mkdocs: check-env check-region clean install-requirements
	eval "$$(buildenv -e $(env) -d $(region))" && \
	mkdocs serve -v --dev-addr=0.0.0.0:5000

install-requirements:
	pip install -r ./requirements.txt

clean: clean-site clean-archive-files

clean-site:
	rm -rf ./site/

clean-archive-files:
	rm -rf ./docs-site.tar
	rm -rf ./manifest.txt

check-env:
ifndef env
	$(error env is not defined)
endif

check-region:
ifndef region
	$(error region is not defined)
endif

check-download-directory:
ifndef download-directory
	$(error download-directory is not defined)
endif

check-version:
ifndef version
	$(error version is not defined)
endif

check-bucket-name:
ifndef bucket-name
	$(error bucket-name is not defined)
endif