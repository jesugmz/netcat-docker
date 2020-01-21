.ONESHELL:
SHELL := /bin/bash

NETCAT_OPENBSD_VERSION := 1.130-3
NETCAT_TRADITIONAL_VERSION := 1.10-41+b1
NCAT_VERSION := 7.80

all: build push

build: build-nc build-nc-traditional build-ncat

push: push-nc push-nc-traditional push-ncat

build-%:
	$(if $(filter $*,nc),@tag=$(subst +,-,$(NETCAT_OPENBSD_VERSION)),$(if $(filter $*,nc-traditional),@tag=$(subst +,-,$(NETCAT_TRADITIONAL_VERSION)),$(if $(filter $*,ncat),@tag=$(NCAT_VERSION))))

	docker build \
		--build-arg NETCAT_OPENBSD_VERSION=$(NETCAT_OPENBSD_VERSION) \
		--build-arg NETCAT_TRADITIONAL_VERSION=$(NETCAT_TRADITIONAL_VERSION) \
		--build-arg NCAT_VERSION=$(NCAT_VERSION) \
		--target $* \
		-t jesugmz/$*:$$tag .

push-%:
	$(if $(filter $*,nc),@tag=$(subst +,-,$(NETCAT_OPENBSD_VERSION)),$(if $(filter $*,nc-traditional),@tag=$(subst +,-,$(NETCAT_TRADITIONAL_VERSION)),$(if $(filter $*,ncat),@tag=$(NCAT_VERSION))))

	docker push jesugmz/$*:$$tag
	docker tag jesugmz/$*:$$tag jesugmz/$*:latest
	docker push jesugmz/$*:latest

.DEFAULT_GOAL := all
