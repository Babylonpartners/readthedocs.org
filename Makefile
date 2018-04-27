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

local-build: 
	docker build -t readthedocs .

local-kube-deploy:
	eval $(minikube docker-env)
	docker build -t readthedocs .
	kubectl apply -f kubeconfigs/
	minikube service $(NAME) --url

local-compose-deploy: local-build
	docker-compose up -d
