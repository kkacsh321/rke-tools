.DEFAULT_GOAL := help
SHA := latest
TAG := latest

build: ## Build the docker container and tag as latest
	docker build -t ${TAG} .
.PHONY: build

shell: build ## Build the docker container and then run in interaction mode
	docker run -it ${TAG} /bin/sh
.PHONY: shell

push: ## Push the docker container to registry
	docker push ${TAG}
.PHONY: push

help: ## show this usage
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
.PHONY: help
