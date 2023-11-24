



# add air: https://github.com/cosmtrek/air
# go install github.com/cosmtrek/air@latest
# ex: https://github.com/veilovv/go-htmx-tailwind-template/blob/main/.air.toml

#include os.mk
### OS mapping to os.mk !
GO_BIN_NAME=$(OS_GO_BIN_NAME)
GO_ARCH=$(OS_GO_ARCH)
GO_OS=$(OS_GO_OS)

### SRC 
GO_SRC_FSPATH=$(PWD)
GO_SRC_BIN_FSPATH=$(GO_SRC_FSPATH)/.bin/gobuild
GO_SRC_NAME=ex
GO_SRC_TAG=.

### BINS

GO_BIN_WHICH=$(shell which $(GO_BIN_NAME))
GO_BIN_WHICH_VERSION=$(shell $(GO_BIN_NAME) version)
GO_BIN_WHICH_GO_VERSION=$(shell $(GO_BIN_NAME) version $(GO_BIN_WHICH))

GO_GOTIP_BIN_NAME=gotip
GO_GOTIP_BIN_VERSION=latest
GO_GOTIP_BIN_WHICH=$(shell which $(GO_GOTIP_BIN_NAME))
GO_GOTIP_BIN_WHICH_VERSION=$(shell $(GO_GOTIP_BIN_NAME) version)
GO_GOTIP_BIN_WHICH_GO_VERSION=$(shell $(GO_BIN_NAME) version $(GO_GOTIP_BIN_WHICH))

# https://github.com/oligot/go-mod-upgrade/releases/tag/v0.9.1
GO_MOD_UPGRADE_BIN_NAME=go-mod-upgrade
GO_MOD_UPGRADE_BIN_VERSION=v0.9.1
GO_MOD_UPGRADE_BIN_WHICH=$(shell which $(GO_MOD_UPGRADE_BIN_NAME))
GO_MOD_UPGRADE_BIN_WHICH_VERSION=$(shell $(GO_MOD_UPGRADE_BIN_NAME) --version)
GO_MOD_UPGRADE_BIN_WHICH_GO_VERSION=$(shell $(GO_BIN_NAME) version $(GO_MOD_UPGRADE_BIN_WHICH))

# https://github.com/burrowers/garble/releases/tag/v0.10.1
GO_GARBLE_BIN_NAME=garble
GO_GARBLE_BIN_VERSION=v0.10.1
GO_GARBLE_BIN_WHICH=$(shell which $(GO_GARBLE_BIN_NAME))
GO_GARBLE_BIN_WHICH_VERSION=$(shell $(GO_GARBLE_BIN_NAME) version)
GO_GARBLE_BIN_WHICH_GO_VERSION=$(shell $(GO_BIN_NAME) version $(GO_GARBLE_BIN_WHICH))

# https://github.com/a8m/tree
GO_TREE_BIN_NAME=tree
GO_TREE_BIN_VERSION=latest
GO_TREE_BIN_WHICH=$(shell which $(GO_TREE_BIN_NAME))
GO_TREE_BIN_WHICH_VERSION=$(shell $(GO_TREE_BIN_NAME) version)
GO_TREE_BIN_WHICH_GO_VERSION=$(shell $(GIO_GO_BIN_NAME) version $(GO_TREE_BIN_WHICH))

# rsc.io/tmp/gonew
# https://github.com/rsc/tmp/tree/master/gonew
# ex: https://github.com/ServiceWeaver/template
GO_NEW_BIN_NAME=gonew
GO_NEW_BIN_VERSION=latest
GO_NEW_BIN_WHICH=$(shell which $(GO_NEW_BIN_NAME))
GO_NEW_BIN_WHICH_VERSION=$(shell $(GO_NEW_BIN_NAME) version)
GO_NEW_BIN_WHICH_GO_VERSION=$(shell $(GO_BIN_NAME) version $(GO_NEW_BIN_WHICH))

# go install github.com/goreleaser/goreleaser@latest
GO_RELEASER_BIN_NAME=goreleaser
GO_RELEASER_BIN_VERSION=latest
GO_RELEASER_BIN_WHICH=$(shell which $(GO_RELEASER_BIN_NAME))
GO_RELEASER_BIN_WHICH_VERSION=$(shell $(GO_RELEASER_BIN_NAME) version)
GO_RELEASER_BIN_WHICH_GO_VERSION=$(shell $(GO_BIN_NAME) version $(GO_RELEASER_BIN_WHICH))


# Computed variables

# user SRC Overrides...
GO_BUILD_FSPATH=$(GO_SRC_BIN_FSPATH)
GO_BUILD_RELEASE_FSPATH=$(GO_SRC_BIN_FSPATH)_release

# windows
GO_BUILD_WINDOWS_AMD64_PATH=$(GO_BUILD_FSPATH)/windows_amd64/$(GO_SRC_NAME).exe
GO_BUILD_WINDOWS_ARM64_PATH=$(GO_BUILD_FSPATH)/windows_arm64/$(GO_SRC_NAME).exe

GO_BUILD_RELEASE_WINDOWS_AMD64_PATH=$(GO_BUILD_RELEASE_FSPATH)/windows_amd64/$(GO_SRC_NAME).exe
GO_BUILD_RELEASE_WINDOWS_ARM64_PATH=$(GO_BUILD_RELEASE_FSPATH)/windows_arm64/$(GO_SRC_NAME).exe

# darwin
GO_BUILD_DARWIN_AMD64_PATH=$(GO_BUILD_FSPATH)/darwin_amd64/$(GO_SRC_NAME)
GO_BUILD_DARWIN_ARM64_PATH=$(GO_BUILD_FSPATH)/darwin_arm64/$(GO_SRC_NAME)

GO_BUILD_RELEASE_DARWIN_AMD64_PATH=$(GO_BUILD_RELEASE_FSPATH)/darwin_amd64/$(GO_SRC_NAME)
GO_BUILD_RELEASE_DARWIN_AMR64_PATH=$(GO_BUILD_RELEASE_FSPATH)/darwin_arm64/$(GO_SRC_NAME)

# linux
GO_BUILD_LINUX_AMD64_PATH=$(GO_BUILD_FSPATH)/linux_amd64/$(GO_SRC_NAME)
GO_BUILD_LINUX_ARM64_PATH=$(GO_BUILD_FSPATH)/linux_arm64/$(GO_SRC_NAME)

GO_BUILD_RELEASE_LINUX_AMD64_PATH=$(GO_BUILD_RELEASE_FSPATH)/linux_amd64/$(GO_SRC_NAME)
GO_BUILD_RELEASE_LINUX_ARM64_PATH=$(GO_BUILD_RELEASE_FSPATH)/linux_arm64/$(GO_SRC_NAME)

# wasm
GO_BUILD_JS_WASM_PATH=$(GO_BUILD_FSPATH)/js_wasm/$(GO_SRC_NAME).wasm
GO_BUILD_RELEASE_JS_WASM_PATH=$(GO_BUILD_RELEASE_FSPATH)/js-wasm/$(GO_SRC_NAME).wasm

# wasi
GO_BUILD_WASIP1_WASM_PATH=$(GO_BUILD_FSPATH)/wasip1_wasm/$(GO_SRC_NAME).wasm
GO_BUILD_RELEASE_WASIP1_WASM_PATH=$(GO_BUILD_RELEASE_FSPATH)/wasip1_wasm/$(GO_SRC_NAME).wasm

## path to builds for easy running.
GO_RUN_FSPATH=?

ifeq ($(GO_OS),windows)
	GO_RUN_FSPATH=$(GO_BUILD_WINDOWS_AMD64_PATH)
endif

ifeq ($(GO_OS),darwin)
	GO_RUN_FSPATH=$(GO_BUILD_DARWIN_AMD64_PATH)
endif

ifeq ($(GO_OS),linux)
	GO_RUN_FSPATH=$(GO_BUILD_LINUX_AMD64_PATH)
endif 

GO_RUN_RELEASE_FSPATH=?

ifeq ($(GO_OS),windows)
	GO_RUN_RELEASE_FSPATH=$(GO_BUILD_RELEASE_WINDOWS_AMD64_PATH)
endif

ifeq ($(GO_OS),darwin)
	ifeq ($(GO_ARCH),amd64)
		GO_RUN_RELEASE_FSPATH=$(GO_BUILD_RELEASE_DARWIN_AMD64_PATH)
	endif
	ifeq ($(GO_ARCH),arm64)
		GO_RUN_RELEASE_FSPATH=$(GO_BUILD_RELEASE_DARWIN_AMR64_PATH)
	endif
endif

ifeq ($(GO_OS),linux)
	GO_RUN_RELEASE_FSPATH=$(GO_BUILD_RELEASE_LINUX_AMD64_PATH)
endif 


## Prints the variables used.
go-print:
	@echo ""
	@echo "--- GO ---"
	@echo ""
	@echo "--- src ---"
	@echo "GO_SRC_FSPATH:                      $(GO_SRC_FSPATH)"
	@echo "GO_SRC_BIN_FSPATH:                  $(GO_SRC_BIN_FSPATH)"
	@echo "GO_SRC_NAME:                        $(GO_SRC_NAME)"
	@echo "GO_SRC_TAG:                         $(GO_SRC_TAG)"
	@echo ""
	@echo "--- vars ---"
	@echo "---- Build paths:"
	@echo "GO_BUILD_FSPATH:                    $(GO_BUILD_FSPATH)"
	@echo "GO_BUILD_RELEASE_FSPATH:            $(GO_BUILD_RELEASE_FSPATH)"
	@echo ""
	@echo "---- Run paths:"
	@echo "GO_RUN_FSPATH:                      $(GO_RUN_FSPATH)"
	@echo "GO_RUN_RELEASE_FSPATH:              $(GO_RUN_RELEASE_FSPATH)"
	@echo ""
	@echo ""
	@echo "--- BINS ---"
	@echo ""
	@echo "GO_BIN_NAME                         $(GO_BIN_NAME)"
	@echo "GO_BIN_WHICH                        $(GO_BIN_WHICH)"
	@echo "GO_BIN_WHICH_VERSION                $(GO_BIN_WHICH_VERSION)"
	@echo "GO_BIN_WHICH_GO_VERSION             $(GO_BIN_WHICH_GO_VERSION)"
	@echo ""

	@echo ""
	@echo "GO_GOTIP_BIN_NAME:                  $(GO_GOTIP_BIN_NAME)"
	@echo "GO_GOTIP_BIN_VERSION                $(GO_GOTIP_BIN_VERSION)"
	@echo "GO_GOTIP_BIN_WHICH                  $(GO_GOTIP_BIN_WHICH)"
	@echo "GO_GOTIP_BIN_WHICH_VERSION          $(GO_GOTIP_BIN_WHICH_VERSION)"
	@echo "GO_GOTIP_BIN_WHICH_GO_VERSION       $(GO_GOTIP_BIN_WHICH_GO_VERSION)"
	@echo ""

	@echo ""
	@echo "GO_MOD_UPGRADE_BIN_NAME:            $(GO_MOD_UPGRADE_BIN_NAME)"
	@echo "GO_MOD_UPGRADE_BIN_VERSION          $(GO_MOD_UPGRADE_BIN_VERSION)"
	@echo "GO_MOD_UPGRADE_BIN_WHICH            $(GO_MOD_UPGRADE_BIN_WHICH)"
	@echo "GO_MOD_UPGRADE_BIN_WHICH_VERSION    $(GO_MOD_UPGRADE_BIN_WHICH_VERSION)"
	@echo "GO_MOD_UPGRADE_BIN_WHICH_GO_VERSION $(GO_MOD_UPGRADE_BIN_WHICH_GO_VERSION)"
	@echo ""

	@echo ""
	@echo "GO_GARBLE_BIN_NAME:                 $(GO_GARBLE_BIN_NAME)"
	@echo "GO_GARBLE_BIN_VERSION               $(GO_GARBLE_BIN_VERSION)"
	@echo "GO_GARBLE_BIN_WHICH                 $(GO_GARBLE_BIN_WHICH)"
	@echo "GO_GARBLE_BIN_WHICH_VERSION         $(GO_GARBLE_BIN_WHICH_VERSION)"
	@echo "GO_GARBLE_BIN_WHICH_GO_VERSION      $(GO_GARBLE_BIN_WHICH_GO_VERSION)"
	@echo ""

	@echo ""
	@echo "GO_TREE_BIN_NAME:                   $(GO_TREE_BIN_NAME)"
	@echo "GO_TREE_BIN_VERSION                 $(GO_TREE_BIN_VERSION)"
	@echo "GO_TREE_BIN_WHICH                   $(GO_TREE_BIN_WHICH)"
	@echo "GO_TREE_BIN_WHICH_VERSION           $(GO_TREE_BIN_WHICH_VERSION)"
	@echo "GO_TREE_BIN_WHICH_GO_VERSION        $(GO_TREE_BIN_WHICH_GO_VERSION)"
	@echo ""

	@echo ""
	@echo "GO_NEW_BIN_NAME:                    $(GO_NEW_BIN_NAME)"
	@echo "GO_NEW_BIN_VERSION                  $(GO_NEW_BIN_VERSION)"
	@echo "GO_NEW_BIN_WHICH                    $(GO_NEW_BIN_WHICH)"
	@echo "GO_NEW_BIN_WHICH_VERSION            $(GO_NEW_BIN_WHICH_VERSION)"
	@echo "GO_NEW_BIN_WHICH_GO_VERSION         $(GO_NEW_BIN_WHICH_GO_VERSION)"
	@echo ""

	@echo ""
	@echo "GO_RELEASER_BIN_NAME:               $(GO_RELEASER_BIN_NAME)"
	@echo "GO_RELEASER_BIN_VERSION             $(GO_RELEASER_BIN_VERSION)"
	@echo "GO_RELEASER_BIN_WHICH               $(GO_RELEASER_BIN_WHICH)"
	@echo "GO_RELEASER_BIN_WHICH_VERSION       $(GO_RELEASER_BIN_WHICH_VERSION)"
	@echo "GO_RELEASER_BIN_WHICH_GO_VERSION    $(GO_RELEASER_BIN_WHICH_GO_VERSION)"
	@echo ""	
	@echo ""
	@echo "-- ALL BUILD variables:"
	@echo ""
	@echo "windows"
	@echo "GO_BUILD_WINDOWS_AMD64_PATH:             $(GO_BUILD_WINDOWS_AMD64_PATH)"
	@echo "GO_BUILD_WINDOWS_ARM64_PATH:             $(GO_BUILD_WINDOWS_ARM64_PATH)"
	@echo "GO_BUILD_RELEASE_WINDOWS_AMD64_PATH:     $(GO_BUILD_RELEASE_WINDOWS_AMD64_PATH)"
	@echo "GO_BUILD_RELEASE_WINDOWS_ARM64_PATH:     $(GO_BUILD_RELEASE_WINDOWS_ARM64_PATH)"
	
	@echo ""
	@echo "darwin"
	@echo "GO_BUILD_DARWIN_AMD64_PATH:              $(GO_BUILD_DARWIN_AMD64_PATH)"
	@echo "GO_BUILD_DARWIN_ARM64_PATH:              $(GO_BUILD_DARWIN_ARM64_PATH)"
	@echo "GO_BUILD_RELEASE_DARWIN_AMD64_PATH:      $(GO_BUILD_RELEASE_DARWIN_AMD64_PATH)"
	@echo "GO_BUILD_RELEASE_DARWIN_AMR64_PATH:      $(GO_BUILD_RELEASE_DARWIN_AMR64_PATH)"

	@echo ""
	@echo "linux"
	@echo "GO_BUILD_LINUX_AMD64_PATH:               $(GO_BUILD_LINUX_AMD64_PATH)"
	@echo "GO_BUILD_LINUX_ARM64_PATH:               $(GO_BUILD_LINUX_ARM64_PATH)"
	@echo "GO_BUILD_RELEASE_LINUX_AMD64_PATH:       $(GO_BUILD_RELEASE_LINUX_AMD64_PATH)"
	@echo "GO_BUILD_RELEASE_LINUX_ARM64_PATH:       $(GO_BUILD_RELEASE_LINUX_ARM64_PATH)"
	@echo 
	
	@echo ""
	@echo "js"
	@echo "GO_BUILD_JS_WASM_PATH:                   $(GO_BUILD_JS_WASM_PATH)"
	@echo "GO_BUILD_RELEASE_JS_WASM_PATH:           $(GO_BUILD_RELEASE_JS_WASM_PATH)"
	@echo 
	

## Installs all go tools
go-dep:
	@echo ""
	@echo "-- Installing go-mod-upgrade"
	$(GO_BIN_NAME) install github.com/oligot/go-mod-upgrade@$(GO_MOD_UPGRADE_BIN_VERSION)
	@echo go-mod-upgrade installed at : $(GO_MOD_UPGRADE_BIN_WHICH)
	@echo ""

	@echo ""
	@echo "-- Installing garble"
	$(GO_BIN_NAME) install mvdan.cc/garble@$(GO_GARBLE_BIN_VERSION)
	@echo "garble installed at : $(GO_GARBLE_BIN_WHICH)"
	@echo ""

	@echo ""
	@echo "-- Installing tree"
	$(GO_BIN_NAME) install github.com/a8m/tree/cmd/tree@$(GO_TREE_BIN_VERSION)
	@echo "tree installed at : $(GO_TREE_BIN_WHICH)"
	@echo ""

	@echo ""
	@echo "-- Installing gonew"
	$(GO_BIN_NAME) install rsc.io/tmp/gonew@$(GO_NEW_BIN_VERSION)
	@echo "gonew installed at : $(GO_NEW_BIN_WHICH)"

	@echo ""
	@echo "-- Installing goreleaser"
	$(GO_BIN_NAME) install github.com/goreleaser/goreleaser@$(GO_RELEASER_BIN_VERSION)
	@echo "goreleaser installed at : $(GO_RELEASER_BIN_WHICH)"



## Finds and lists all .bin folders, at the pwd context
go-clean-bin-ls:
	find . -type d -name .bin

## Finds and deletes all .bin folders, at the pwd context
go-clean-bin-run:
	# deletes all .bin folders, which we use for all builds.
	find . -type d -name .bin -exec rm -rf {} \;


## Finds and lists all .syso files, at the pwd context
go-clean-syso-ls:
	find . -type f -name "*.syso" 

## Finds and deletes all .syso folders, at the pwd context
go-clean-syso-run:
	find . -type f -name "*.syso" -exec rm -f {} \;


## Finds and lists all .data folders, at the pwd context
go-clean-data-ls:
	find . -type d -name .data

## Finds and deletes all .data folders, at the pwd context
go-clean-data-run:
	# deletes all .data folders, which we use for all data.
	find . -type d -name .data -exec rm -rf {} \;


## Finds and lists all git folders, at the pwd context
go-clean-git-ls:
	find . -type d -name .git
go-clean-gitignore-ls:
	find . -type d -name .gitignore

## Finds and deletes all git folders, at the pwd context
go-clean-git-run:
	# deletes all .data folders, which we use for all data.
	find . -type d -name .git -exec rm -rf {} \;

## Reconciles golang packages
go-mod-tidy:
	@echo
	@echo -- Visiting: 		$(GO_SRC_FSPATH)
	cd $(GO_SRC_FSPATH) && $(GO_BIN_NAME) mod tidy
	
## Upgrades golang packages interactively
go-mod-upgrade:
	# See: https://github.com/shanna/entxid-test/blob/master/Makefile#L19
	@echo
	@echo -- Visiting:		$(GO_SRC_FSPATH)
	cd $(GO_SRC_FSPATH) && go-mod-upgrade
	cd $(GO_SRC_FSPATH) && $(GO_BIN_NAME) mod tidy
	cd $(GO_SRC_FSPATH) && $(GO_BIN_NAME) mod verify
	cd $(GO_SRC_FSPATH) && $(GO_BIN_NAME) mod tidy

## Runs the code
go-run:
	cd $(GO_SRC_FSPATH) && $(GO_BIN_NAME) run .

go-run-release:
	$(MAKE) go-build-release
	
ifeq ($(GO_OS),windows)
	open $(GO_BUILD_RELEASE_WINDOWS_AMD64_PATH)
endif

ifeq ($(GO_OS),darwin)
	open $(GO_BUILD_RELEASE_DARWIN_AMD64_PATH)
endif

ifeq ($(GO_OS),linux)
	open $(GO_BUILD_RELEASE_LINUX_AMD64_PATH)
endif 


## Deletes all builds
go-build-clean:
	cd $(GO_SRC_FSPATH) && rm -rf $(GO_BUILD_FSPATH)


## Generates and builds the code
go-build:
	cd $(GO_SRC_FSPATH) && $(GO_BIN_NAME) generate ./...

	# switch for OS
	@echo
	@echo check OS your building on:
	@echo GO_OS: $(GO_OS)

ifeq ($(GO_OS),windows)
	cd $(GO_SRC_FSPATH) && GOOS=windows GOARCH=amd64 $(GO_BIN_NAME) build -tags $(GO_SRC_TAG) -o $(GO_BUILD_WINDOWS_AMD64_PATH) .
endif

ifeq ($(GO_OS),darwin)
	cd $(GO_SRC_FSPATH) && GOOS=darwin GOARCH=amd64 $(GO_BIN_NAME) build -tags $(GO_SRC_TAG) -o $(GO_BUILD_DARWIN_AMD64_PATH) .
endif

ifeq ($(GO_OS),linux)
	cd $(GO_SRC_FSPATH) && GOOS=linux GOARCH=amd64 $(GO_BIN_NAME) build -tags $(GO_SRC_TAG) -o $(GO_BUILD_LINUX_AMD64_PATH) .
endif



## Generates and builds all the code
go-build-all:
	cd $(GO_SRC_FSPATH) && $(GO_BIN_NAME) generate ./...

	@echo ""
	@echo "$(GO_SRC_NAME): windows amd64"
	cd $(GO_SRC_FSPATH) && GOOS=windows GOARCH=amd64 $(GO_BIN_NAME) build -tags $(GO_SRC_TAG) -o $(GO_BUILD_WINDOWS_AMD64_PATH) .
	@echo "$(GO_SRC_NAME): windows arm64"
	cd $(GO_SRC_FSPATH) && GOOS=windows GOARCH=arm64 $(GO_BIN_NAME) build -tags $(GO_SRC_TAG) -o $(GO_BUILD_WINDOWS_ARM64_PATH) .
	
	@echo ""
	@echo "$(GO_SRC_NAME): darwin amd64"
	cd $(GO_SRC_FSPATH) && GOOS=darwin GOARCH=amd64 $(GO_BIN_NAME) build -tags $(GO_SRC_TAG) -o $(GO_BUILD_DARWIN_AMD64_PATH) .
	@echo "$(GO_SRC_NAME): darwin arm64"
	cd $(GO_SRC_FSPATH) && GOOS=darwin GOARCH=arm64 $(GO_BIN_NAME) build -tags $(GO_SRC_TAG) -o $(GO_BUILD_DARWIN_ARM64_PATH) .
	
	@echo ""
	@echo "$(GO_SRC_NAME): linux amd64"
	cd $(GO_SRC_FSPATH) && GOOS=linux GOARCH=amd64 $(GO_BIN_NAME) build -tags $(GO_SRC_TAG) -o $(GO_BUILD_LINUX_AMD64_PATH) .
	@echo "$(GO_SRC_NAME): linux arm64"
	cd $(GO_SRC_FSPATH) && GOOS=linux GOARCH=arm64 $(GO_BIN_NAME) build -tags $(GO_SRC_TAG) -o $(GO_BUILD_LINUX_AMR64_PATH) .


go-build-wasm:

	cd $(GO_SRC_FSPATH) && $(GO_BIN_NAME) generate ./...

	# go-build-wasm:
	@echo ""
	@echo "$(GO_SRC_NAME): js wasm"
	cd $(GO_SRC_FSPATH) && GOOS=js GOARCH=wasm $(GO_BIN_NAME) build -tags $(GO_SRC_TAG) -o $(GO_BUILD_JS_WASM_PATH) .

	# go-build-wasi:
	@echo ""
	@echo "$(GO_SRC_NAME): wasip1 wasm"
	cd $(GO_SRC_FSPATH) && GOOS=wasip1 GOARCH=wasm $(GO_BIN_NAME) build -tags $(GO_SRC_TAG) -o $(GO_BUILD_WASIP1_WASM_PATH) .



go-build-release-clean:
	cd $(GO_SRC_FSPATH) && rm -rf $(GO_BUILD_RELEASE_FSPATH)
	
## Generates and builds the code garbled
## TODO does it support buuld tags ?
go-build-release:
	cd $(GO_SRC_FSPATH) && $(GO_BIN_NAME) generate ./...

	# switch for OS
	@echo
	@echo check OS your building on:
	@echo GO_OS: $(GO_OS)

ifeq ($(GO_OS),windows)
	cd $(GO_SRC_FSPATH)&& GOOS=windows GOARCH=amd64 $(GO_GARBLE_BIN_NAME) -tiny build -tags=$(GO_SRC_TAG) -o $(GO_BUILD_RELEASE_WINDOWS_AMD64_PATH) .
endif

ifeq ($(GO_OS),darwin)
	cd $(GO_SRC_FSPATH) && GOOS=darwin GOARCH=amd64 $(GO_GARBLE_BIN_NAME) -tiny build -tags=$(GO_SRC_TAG) -o $(GO_BUILD_RELEASE_DARWIN_AMD64_PATH) .
endif

ifeq ($(GO_OS),linux)
	cd $(GO_SRC_FSPATH) && GOOS=linux GOARCH=amd64 $(GO_GARBLE_BIN_NAME) -tiny build -tags=$(GO_SRC_TAG) -o $(GO_BUILD_RELEASE_LINUX_AMD64_PATH) .
endif

go-build-release-all:
	cd $(GO_SRC_FSPATH) && $(GO_BIN_NAME) generate ./...

	@echo ""
	@echo "$(GO_SRC_NAME): windows amd64"
	cd $(GO_SRC_FSPATH) && GOOS=windows GOARCH=amd64 $(GO_GARBLE_BIN_NAME) -tiny build -o $(GO_BUILD_RELEASE_WINDOWS_AMD64_PATH) .
	
	@echo ""
	@echo "$(GO_SRC_NAME): darwin amd64"
	cd $(GO_SRC_FSPATH) && GOOS=darwin GOARCH=amd64 $(GO_GARBLE_BIN_NAME) -tiny build -o $(GO_BUILD_RELEASE_DARWIN_AMD64_PATH) .
	
	@echo ""
	@echo "$(GO_SRC_NAME): linux amd64"
	cd $(GO_SRC_FSPATH) && GOOS=linux GOARCH=amd64 $(GO_GARBLE_BIN_NAME) -tiny build -o $(GO_BUILD_RELEASE_LINUX_AMD64_PATH) .
	
	@echo ""
	@echo "$(GO_SRC_NAME): js wasm"
	cd $(GO_SRC_FSPATH) && GOOS=js GOARCH=wasm $(GO_GARBLE_BIN_NAME) build -tags $(GO_SRC_TAG) -o $(GO_BUILD_RELEASE_JS_WASM_PATH) .

	@echo ""
	@echo "$(GO_SRC_NAME): wasip1 wasm"
	cd $(GO_SRC_FSPATH) && GOOS=wasip1 GOARCH=wasm $(GO_GARBLE_BIN_NAME) build -tags $(GO_SRC_TAG) -o $(GO_BUILD_RELEASE_WASIP1_WASM_PATH) .

## Builds and immediately runs the binary
go-buildrun: go-build
	# switch for OS
	@echo
	@echo check OS your running on:
	@echo GO_OS: $(GO_OS)

	# open in a new terminal, so we can run many programs.
ifeq ($(GO_OS),windows)
	start $(GO_BUILD_WINDOWS_AMD64_PATH)
endif

ifeq ($(GO_OS),darwin)
	open $(GO_BUILD_DARWIN_AMD64_PATH)
endif

ifeq ($(GO_OS),linux)
	xdg-open $(GO_BUILD_LINUX_AMD64_PATH)
endif

# github.com/ServiceWeaver/template
GO_NEW_SRC_MOD_SOURCE=
# example.com/foo
GO_NEW_SRC_MOD_TARGET=

go-new-print:
	@echo ""
	@echo "GO_NEW_SRC_MOD_SOURCE:   $(GO_NEW_SRC_MOD_SOURCE)"
	@echo "GO_NEW_SRC_MOD_TARGET:   $(GO_NEW_SRC_MOD_TARGET)"
	@echo ""
go-new-run:
	#ex: gonew github.com/ServiceWeaver/template example.com/foo

	$(GO_NEW_BIN_NAME) $(GO_NEW_SRC_MOD_SOURCE) $(GO_NEW_SRC_MOD_TARGET)