# api

API definitions for bpmf products. Contracts are maintained Protocol
Buffers-first: this repository contains definitions only, implementations
live in the service repositories.

## Layout

| Path | API |
| --- | --- |
| `bpmf/lead/v1` | `LeadService.SubmitLead` — public sales-lead collection, the entry point of the sales funnel MVP |

Conventions: the package `bpmf.<domain>.v1` mirrors the file directory, and
`go_package` mirrors the directory under this repository's module path
(`github.com/bpmfio/api`). Run `buf dep update` after adding a dependency in
`buf.yaml`, and commit the generated `buf.lock` together with it.

## Checks

Install [buf](https://buf.build), then:

```sh
make build     # buf build: resolve deps and compile all protos
make lint      # buf lint: STANDARD rule set, zero warnings expected
make format    # buf format -w: canonical formatting
make breaking  # buf breaking --against '.git#branch=main'
make check     # build + lint + format check in one go
```

CI (GitHub Actions) runs build, lint, and format checks on pushes and pull
requests, and breaking-change detection against the PR base. To land an
intentional breaking change, add the `buf skip breaking` label to the PR.

## Consuming

With buf, point `buf generate` at this repository using your own
`buf.gen.yaml` template:

```sh
git clone https://github.com/bpmfio/api.git
cd api
buf dep update
buf generate --template <path-to-your>/buf.gen.yaml
```

With protoc, put this repository, [googleapis](https://github.com/googleapis/googleapis),
and the protobuf well-known types on the include path:

```sh
protoc -I . -I <path-to-googleapis> --go_out=out bpmf/lead/v1/lead.proto
```

## Adding a new API

Create `bpmf/<domain>/v1/<domain>.proto` with package `bpmf.<domain>.v1`,
document every message, field, enum, and RPC (lint enforces comments), and
run `make check` before committing.
