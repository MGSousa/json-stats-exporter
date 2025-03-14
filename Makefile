BINARY = json-stats-exporter
ACT_URL = https://raw.githubusercontent.com/nektos/act/master/install.sh

ACT := $(shell command -v act)

.PHONY: test act test_sec test_ci docker_build goreleaser_build

test: test_sec test_ci

act:
	@curl --proto '=https' --tlsv1.2 -sSf $(ACT_URL) | bash

test_ci: act
	@act push --rm -j "test"

test_sec: act
	@act push --rm -j "security"

benchmark:
	@go test -v ./... -bench=^BenchmarkBuild

docker_build:
	@docker build --no-cache -t $(BINARY) .

goreleaser_build:
	@goreleaser build --single-target --clean --auto-snapshot
