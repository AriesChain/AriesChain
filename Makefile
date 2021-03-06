# This Makefile is meant to be used by people that do not usually work
# with Go source code. If you know what GOPATH is then you probably
# don't need to bother with make.

.PHONY: ariesChain android ios ariesChain-cross swarm evm all test clean
.PHONY: ariesChain-linux ariesChain-linux-386 ariesChain-linux-amd64 ariesChain-linux-mips64 ariesChain-linux-mips64le
.PHONY: ariesChain-linux-arm ariesChain-linux-arm-5 ariesChain-linux-arm-6 ariesChain-linux-arm-7 ariesChain-linux-arm64
.PHONY: ariesChain-darwin ariesChain-darwin-386 ariesChain-darwin-amd64
.PHONY: ariesChain-windows ariesChain-windows-386 ariesChain-windows-amd64

GOBIN = $(shell pwd)/build/bin
GO ?= latest

ariesChain:
	build/env.sh go run build/ci.go install ./cmd/ariesChain
	@echo "Done building."
	@echo "Run \"$(GOBIN)/ariesChain\" to launch ariesChain."

swarm:
	build/env.sh go run build/ci.go install ./cmd/swarm
	@echo "Done building."
	@echo "Run \"$(GOBIN)/swarm\" to launch swarm."

all:
	build/env.sh go run build/ci.go install

android:
	build/env.sh go run build/ci.go aar --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/ariesChain.aar\" to use the library."

ios:
	build/env.sh go run build/ci.go xcode --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/Geth.framework\" to use the library."

test: all
	build/env.sh go run build/ci.go test

lint: ## Run linters.
	build/env.sh go run build/ci.go lint

clean:
	rm -fr build/_workspace/pkg/ $(GOBIN)/*

# The devtools target installs tools required for 'go generate'.
# You need to put $GOBIN (or $GOPATH/bin) in your PATH to use 'go generate'.

devtools:
	env GOBIN= go get -u golang.org/x/tools/cmd/stringer
	env GOBIN= go get -u github.com/kevinburke/go-bindata/go-bindata
	env GOBIN= go get -u github.com/fjl/gencodec
	env GOBIN= go get -u github.com/golang/protobuf/protoc-gen-go
	env GOBIN= go install ./cmd/abigen
	@type "npm" 2> /dev/null || echo 'Please install node.js and npm'
	@type "solc" 2> /dev/null || echo 'Please install solc'
	@type "protoc" 2> /dev/null || echo 'Please install protoc'

# Cross Compilation Targets (xgo)

ariesChain-cross: ariesChain-linux ariesChain-darwin ariesChain-windows ariesChain-android ariesChain-ios
	@echo "Full cross compilation done:"
	@ls -ld $(GOBIN)/ariesChain-*

ariesChain-linux: ariesChain-linux-386 ariesChain-linux-amd64 ariesChain-linux-arm ariesChain-linux-mips64 ariesChain-linux-mips64le
	@echo "Linux cross compilation done:"
	@ls -ld $(GOBIN)/ariesChain-linux-*

ariesChain-linux-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/386 -v ./cmd/ariesChain
	@echo "Linux 386 cross compilation done:"
	@ls -ld $(GOBIN)/ariesChain-linux-* | grep 386

ariesChain-linux-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/amd64 -v ./cmd/ariesChain
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/ariesChain-linux-* | grep amd64

ariesChain-linux-arm: ariesChain-linux-arm-5 ariesChain-linux-arm-6 ariesChain-linux-arm-7 ariesChain-linux-arm64
	@echo "Linux ARM cross compilation done:"
	@ls -ld $(GOBIN)/ariesChain-linux-* | grep arm

ariesChain-linux-arm-5:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-5 -v ./cmd/ariesChain
	@echo "Linux ARMv5 cross compilation done:"
	@ls -ld $(GOBIN)/ariesChain-linux-* | grep arm-5

ariesChain-linux-arm-6:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-6 -v ./cmd/ariesChain
	@echo "Linux ARMv6 cross compilation done:"
	@ls -ld $(GOBIN)/ariesChain-linux-* | grep arm-6

ariesChain-linux-arm-7:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-7 -v ./cmd/ariesChain
	@echo "Linux ARMv7 cross compilation done:"
	@ls -ld $(GOBIN)/ariesChain-linux-* | grep arm-7

ariesChain-linux-arm64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm64 -v ./cmd/ariesChain
	@echo "Linux ARM64 cross compilation done:"
	@ls -ld $(GOBIN)/ariesChain-linux-* | grep arm64

ariesChain-linux-mips:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips --ldflags '-extldflags "-static"' -v ./cmd/ariesChain
	@echo "Linux MIPS cross compilation done:"
	@ls -ld $(GOBIN)/ariesChain-linux-* | grep mips

ariesChain-linux-mipsle:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mipsle --ldflags '-extldflags "-static"' -v ./cmd/ariesChain
	@echo "Linux MIPSle cross compilation done:"
	@ls -ld $(GOBIN)/ariesChain-linux-* | grep mipsle

ariesChain-linux-mips64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64 --ldflags '-extldflags "-static"' -v ./cmd/ariesChain
	@echo "Linux MIPS64 cross compilation done:"
	@ls -ld $(GOBIN)/ariesChain-linux-* | grep mips64

ariesChain-linux-mips64le:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64le --ldflags '-extldflags "-static"' -v ./cmd/ariesChain
	@echo "Linux MIPS64le cross compilation done:"
	@ls -ld $(GOBIN)/ariesChain-linux-* | grep mips64le

ariesChain-darwin: ariesChain-darwin-386 ariesChain-darwin-amd64
	@echo "Darwin cross compilation done:"
	@ls -ld $(GOBIN)/ariesChain-darwin-*

ariesChain-darwin-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/386 -v ./cmd/ariesChain
	@echo "Darwin 386 cross compilation done:"
	@ls -ld $(GOBIN)/ariesChain-darwin-* | grep 386

ariesChain-darwin-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/amd64 -v ./cmd/ariesChain
	@echo "Darwin amd64 cross compilation done:"
	@ls -ld $(GOBIN)/ariesChain-darwin-* | grep amd64

ariesChain-windows: ariesChain-windows-386 ariesChain-windows-amd64
	@echo "Windows cross compilation done:"
	@ls -ld $(GOBIN)/ariesChain-windows-*

ariesChain-windows-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/386 -v ./cmd/ariesChain
	@echo "Windows 386 cross compilation done:"
	@ls -ld $(GOBIN)/ariesChain-windows-* | grep 386

ariesChain-windows-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/amd64 -v ./cmd/ariesChain
	@echo "Windows amd64 cross compilation done:"
	@ls -ld $(GOBIN)/ariesChain-windows-* | grep amd64
