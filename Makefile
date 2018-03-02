NAME=readthedocs
VERSION=$(shell git rev-parse HEAD)
REPO=quay.io/babylonhealth

build:
	docker build -t $(REPO)/$(NAME):$(VERSION) .

tag-master: build
	docker tag $(REPO)/$(NAME):$(VERSION) $(REPO)/$(NAME):master
	docker push $(REPO)/$(NAME):master

install: build
	docker push $(REPO)/$(NAME):$(VERSION)

deploy:
	kubectl delete pods -l=app=readthedocs
