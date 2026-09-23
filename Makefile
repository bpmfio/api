BUF ?= buf

.PHONY: build lint format breaking check

build:
	$(BUF) build

lint:
	$(BUF) lint

format:
	$(BUF) format -w

breaking:
	$(BUF) breaking --against '.git#branch=main'

# Convenience target: build, lint, and format check in one go.
check: build lint
	$(BUF) format --diff
