BUF ?= buf

.PHONY: build generate lint format breaking check

build:
	$(BUF) build

# Regenerates the committed Go code from the protos. Run this after every
# .proto change and commit the regenerated files together with it.
generate:
	$(BUF) generate

lint:
	$(BUF) lint

format:
	$(BUF) format -w

breaking:
	$(BUF) breaking --against '.git#branch=main'

# Convenience target: build, lint, and format check in one go.
check: build lint
	$(BUF) format --diff
