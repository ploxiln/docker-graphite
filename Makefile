IMAGE = ploxiln/graphite
VERSION = 0.9.15

MAKEFLAGS += -r
DOCKER = docker # do make DOCKER="sudo docker" if it needs sudo

DATE = $(shell date +%Y-%m-%d)
BASE_IMAGE = $(shell awk '/^FROM/ {print $$2}' Dockerfile)

build:
	${DOCKER} pull ${BASE_IMAGE}
	${DOCKER} build --tag=${IMAGE} .

push:
	${DOCKER} tag -f ${IMAGE} ${IMAGE}:${DATE}
	${DOCKER} tag -f ${IMAGE} ${IMAGE}:${VERSION}
	${DOCKER} push ${IMAGE}:${VERSION}
	${DOCKER} push ${IMAGE}:${DATE}
	${DOCKER} push ${IMAGE}:latest

.PHONY: build push
