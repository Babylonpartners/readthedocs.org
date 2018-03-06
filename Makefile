NAME=readthedocs
VERSION=$(shell git rev-parse HEAD)
SEMVER_VERSION=$(shell cat VERSION)
REPO=quay.io/babylonhealth

build:
	docker build -t $(REPO)/$(NAME):$(VERSION) .

tag-master: build
	docker tag $(REPO)/$(NAME):$(VERSION) $(REPO)/$(NAME):master
	docker push $(REPO)/$(NAME):master

tag-develop: build
	docker tag $(REPO)/$(NAME):$(VERSION) $(REPO)/$(NAME):develop
	docker push $(REPO)/$(NAME):develop

install: build
	docker push $(REPO)/$(NAME):$(VERSION)
