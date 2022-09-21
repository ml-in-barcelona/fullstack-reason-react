project_name = fullstack-react

DUNE = esy dune
MEL = esy mel
# current_hash = $(shell git rev-parse HEAD)

.PHONY: build build-prod dev test test-promote deps format format-check init publish-example

.PHONY: help
help: ## Print this help message
	@echo "List of available make commands";
	@echo "";
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}';
	@echo "";

install:
	esy install

client-bundle:
	$(ESY) esbuild _build/default/client/client.js --bundle --outfile=static/client.js

client-bundle-watch:
	esy esbuild _build/default/client/client.js --bundle --outfile=static/client.js --watch

client-build:
	$(MEL) build

client-watch:
	$(MEL) build --watch

build: ## Build the project, including non installable libraries and executables
	$(DUNE) build @@default

build-prod: ## Build for production (--profile=prod)
	$(DUNE) build --profile=prod @@default

start:
	$(DUNE) exec --root . server/server.exe

dev: ## Build in watch mode
	$(DUNE) build -w @@default

clean: ## Clean artifacts
	$(DUNE) clean

format: ## Format the codebase with ocamlformat
	$(DUNE) build @fmt --auto-promote

format-check: ## Checks if format is correct
	$(DUNE) build @fmt
