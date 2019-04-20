GOLANG_VERSION ?= 1.12
GCLOUD_PROJECT ?= kubeflow-images-public
IMG ?= gcr.io/$(GCLOUD_PROJECT)/mutating-webhook
TAG ?= $(eval TAG := $(shell git describe --tags --long))$(TAG)

build:
	docker build --no-cache --build-arg GOLANG_VERSION=$(GOLANG_VERSION) -t $(IMG):$(TAG) .
	
minikube: minikubecontext build

minikubecontext:
	eval $(minikube docker-env)
push:
	docker push ${IMG}:${TAG}
