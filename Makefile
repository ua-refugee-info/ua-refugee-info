.DEFAULT_GOAL := help

PRE_COMMIT_SKIP := drawio-export

# Conditions for GitHub actions
ifeq ($(CI), true)
SKIP ?= $(PRE_COMMIT_SKIP)
endif

# Conditions for GitHub actions
ifeq ($(CI), true)
SKIP ?= $(PRE_COMMIT_SKIP)
endif

.PHONY: setup
setup: ## Enable pre-commit
	pre-commit install --install-hooks

.PHONY: test
test: ## Run pre-commit against modified files
	SKIP=$(SKIP) pre-commit run --color=always --show-diff-on-failure

.PHONY: test-all
test-all: ## Run pre-commit against all files
	SKIP=$(SKIP) pre-commit run --color=always --show-diff-on-failure --all-files

.PHONY: help
help: ## This help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' | sort

.PHONY: docs
docs: ## Build docs with mkdocs
	mkdocs build

.PHONY: docs-serve
docs-serve: ## Run docs locally
	mkdocs serve

.PHONY: docs-publish
docs-publish: ## Deploy docs to GitHub Pages
	mkdocs gh-deploy --force

.PHONY: docs-setup
docs-setup: ## Install required mkdocs plugins
	pip install -r docs/requirements.txt

%:
	@:
