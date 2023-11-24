# GIO
# https://github.com/gioui

# https://github.com/gioui/gio-cmd

### OS
# go itself ( from os.mk )
GIO_GO_BIN_NAME=$(OS_GO_BIN_NAME)

GIO_GO_OS=$(shell $(GIO_GO_BIN_NAME) env GOOS)
GIO_GO_ARCH=$(shell $(GIO_GO_BIN_NAME) env GOARCH)
GIO_GO_TOOLDIR=$(shell $(GIO_GO_BIN_NAME) env GOTOOLDIR)
GIO_GO_PATH=$(shell $(GIO_GO_BIN_NAME) env GOPATH)


### BINS
GIO_BIN=gogio
GIO_BIN_VERSION=latest
GIO_BIN_WHICH=$(shell which $(GIO_BIN))
GIO_BIN_WHICH_GO_VERSION=$(shell $(GIO_GO_BIN_NAME) version $(GIO_BIN_WHICH))

GIO_GARBLE_BIN_NAME=garble
GIO_GARBLE_BIN_VERSION=latest
GIO_GARBLE_BIN_WHICH=$(shell which $(GIO_GARBLE_BIN_NAME))
GIO_GARBLE_BIN_WHICH_VERSION=$(shell $(GIO_GARBLE_BIN_NAME) version)
GIO_GARBLE_BIN_WHICH_GO_VERSION=$(shell $(GIO_GO_BIN_NAME) version $(GIO_GARBLE_BIN_WHICH))

# https://github.com/a8m/tree
GIO_TREE_BIN_NAME=tree
GIO_TREE_BIN_VERSION=latest
GIO_TREE_BIN_WHICH=$(shell which $(GIO_TREE_BIN_NAME))
GIO_TREE_BIN_WHICH_VERSION=$(shell $(GIO_TREE_BIN_NAME) version)
GIO_TREE_BIN_WHICH_GO_VERSION=$(shell $(GIO_GO_BIN_NAME) version $(GIO_TREE_BIN_WHICH))


### VARIABLES

# where to put the standard templates. Might want them elsewhere.
GIO_SRC_TEMPLATES_FSPATH=

## OVERRIDE variables
# where to look for gio golang soure code to build from.
GIO_SRC_FSPATH=$(PWD)
GIO_SRC_NAME=ex
GIO_SRC_GO_BIN_NAME=go
# or GIO_SRC_GO_BIN_NAME=gotip

### VARIABLES

# COMPUTED variables

GIO_SRC=$(GIO_SRC_FSPATH)/$(GIO_SRC_NAME)

# build paths
GIO_BUILD_FSPATH=$(GIO_SRC_FSPATH)/.bin/giobuild
GIO_BUILD_RELEASE_FSPATH=$(GIO_SRC_FSPATH)/.bin/giobuild-release

# templates
_GIO_SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
_GIO_TEMPLATES_SOURCE=$(_GIO_SELF_DIR)templates/gio
_GIO_TEMPLATES_TARGET=$(PWD)/.templates/gio


## path to builds for easy running.
GIO_RUN_FSPATH=?

ifeq ($(GO_OS),windows)
	GIO_RUN_FSPATH=$(GIO_BUILD_WINDOWS_AMD64_PACK)
endif

ifeq ($(GO_OS),darwin)
	GIO_RUN_FSPATH=$(GIO_BUILD_DARWIN_AMD64_PACK)
endif

ifeq ($(GO_OS),linux)
	GIO_RUN_FSPATH=$(GIO_BUILD_LINUX_AMD64_PACK)
endif 

GIO_RUN_RELEASE_FSPATH=?


ifeq ($(GO_OS),windows)
	GIO_RUN_RELEASE_FSPATH=$(GIO_BUILD_WINDOWS_RELEASE_AMD64_PACK)
endif

ifeq ($(GO_OS),darwin)
	GIO_RUN_RELEASE_FSPATH=$(GIO_BUILD_DARWIN_RELEASE_AMD64_PACK)
endif

ifeq ($(GO_OS),linux)
	GIO_RUN_RELEASE_FSPATH=$(GIO_BUILD_LINUX_RELEASE_AMD64_PACK)
endif 


## Prints the variables used.
gio-print: gio-print-src gio-print-dep

gio-print-src:
	@echo ""
	@echo --- SRC ---
	@echo ""
	@echo "- Override variables"
	@echo "GIO_SRC_FSPATH:                       $(GIO_SRC_FSPATH)"
	@echo "GIO_SRC_NAME:                         $(GIO_SRC_NAME)"
	@echo "GIO_SRC_GO_BIN_NAME:                  $(GIO_SRC_GO_BIN_NAME)"
	@echo ""

gio-print-dep:

	@echo ""
	@echo "--- BINS ---"
	
	@echo ""
	@echo "GIO_BIN:                              $(GIO_BIN)"
	@echo "GIO_BIN_WHICH:                        $(GIO_BIN_WHICH)"
	@echo "GIO_BIN_WHICH_GO_VERSION:             $(GIO_BIN_WHICH_GO_VERSION)"
	
	@echo ""
	@echo "GIO_GARBLE_BIN_NAME:                  $(GIO_GARBLE_BIN_NAME)"
	@echo "GIO_GARBLE_BIN_VERSION                $(GIO_GARBLE_BIN_VERSION)"
	@echo "GIO_GARBLE_BIN_WHICH                  $(GIO_GARBLE_BIN_WHICH)"
	@echo "GIO_GARBLE_BIN_WHICH_VERSION          $(GIO_GARBLE_BIN_WHICH_VERSION)"
	@echo "GIO_GARBLE_BIN_WHICH_GO_VERSION       $(GIO_GARBLE_BIN_WHICH_GO_VERSION)"

	@echo ""
	@echo "GIO_TREE_BIN_NAME:                    $(GIO_TREE_BIN_NAME)"
	@echo "GIO_TREE_BIN_VERSION                  $(GIO_TREE_BIN_VERSION)"
	@echo "GIO_TREE_BIN_WHICH                    $(GIO_TREE_BIN_WHICH)"
	@echo "GIO_TREE_BIN_WHICH_VERSION            $(GIO_TREE_BIN_WHICH_VERSION)"
	@echo "GIO_TREE_BIN_WHICH_GO_VERSION         $(GIO_TREE_BIN_WHICH_GO_VERSION)"
	


	
	@echo ""
	@echo "Computed variables"
	
	@echo ""
	@echo "- build paths"
	@echo "GIO_BUILD_FSPATH:                    $(GIO_BUILD_FSPATH)"
	@echo "GIO_BUILD_RELEASE_FSPATH:            $(GIO_BUILD_RELEASE_FSPATH)"

	@echo ""
	@echo "- run paths"
	@echo "GIO_RUN_FSPATH:                     $(GIO_RUN_FSPATH)"
	@echo "GIO_RUN_RELEASE_FSPATH:             $(GIO_RUN_RELEASE_FSPATH)"

	@echo ""

gio-print-build:
	
	@echo ""
	@echo "-- ALL BUILD variables:"
	@echo ""

	$(MAKE) gio-web-print

	$(MAKE) gio-desk-windows-print

	$(MAKE) gio-desk-darwin-print

	$(MAKE) gio-ios-print

	$(MAKE) gio-android-print



## Installs all tools
gio-dep:
	@echo ""
	@echo "-- Installing gogio tool into go bin --"
	$(GIO_GO_BIN_NAME) install gioui.org/cmd/gogio@$(GIO_BIN_VERSION)
	@echo installed gogio [ $(GIO_BIN_VERSION) ] at : $(GIO_BIN_WHICH)

	@echo
	@echo "-- Installing garble"
	$(GIO_GO_BIN_NAME) install mvdan.cc/garble@$(GIO_GARBLE_BIN_VERSION)
	@echo "garble installed at : $(GIO_GARBLE_BIN_WHICH)"

	@echo
	@echo "-- Installing tree"
	$(GIO_GO_BIN_NAME) install github.com/a8m/tree/cmd/tree@$(GIO_TREE_BIN_VERSION)
	@echo "tree installed at : $(GIO_TREE_BIN_WHICH)"

gio-dep-git:
	# my fork 
	rm -rf gio-cmd
	git clone git@github.com:gedw99/gio-cmd.git -b main
	cd gio-cmd && git remote add upstream git@github.com:gioui/gio-cmd.git 
	cd gio-cmd/gogio && $(GIO_GO_BIN_NAME) build -o $(GIO_GO_BIN_FSPATH)/gogio .

	@echo installed gogio [ $(GIO_BIN_VERSION) ] at : $(GIO_BIN_WHICH)

gio-dep-git-sync:
	# for getting back upstream ...
	cd gio-cmd && git remote -v
	cd gio-cmd && git git remote add upstream git@github.com:gioui/gio-cmd.git 
	cd gio-cmd && git fetch upstream
	cd gio-cmd && git reset --hard upstream/main
	cd gio-cmd && git push origin main --force



## prints the templates 
gio-templates-print:
	@echo ""
	@echo "- templates:"
	@echo "_GIO_SELF_DIR:                      $(_GIO_SELF_DIR)"
	@echo "_GIO_TEMPLATES_SOURCE:              $(_GIO_TEMPLATES_SOURCE)"
	@echo "_GIO_TEMPLATES_TARGET:              $(_GIO_TEMPLATES_TARGET)"

## installs the standard templates
gio-templates-dep:
	@echo ""
	@echo "-- Installing GIO templates into your project --"
	mkdir -p $(_GIO_TEMPLATES_TARGET)
	cp -r $(_GIO_TEMPLATES_SOURCE) $(_GIO_TEMPLATES_TARGET)
	@echo installed gio templates  at : $(_GIO_TEMPLATES_TARGET)

gio-build-all:
	# Always do Web so we know its never broken. Its pretty fast
	$(MAKE) gio-web-build
	# These  builders fail 
	#$(MAKE) gio-wasmtiny-build
	#$(MAKE) gio-wasm-build


	$(MAKE) gio-desk-windows-build

	$(MAKE) gio-desk-darwin-build

	$(MAKE) gio-desk-linux-build

## Builds the code for Web and Desktop as a convenience
gio-build:
	# only build for OS i am on.

ifeq ($(GIO_GO_OS),windows)
	$(MAKE) gio-desk-windows-build
endif

ifeq ($(GIO_GO_OS),darwin)
	$(MAKE) gio-desk-darwin-build
endif

ifeq ($(GIO_GO_OS),linux)
	$(MAKE) gio-desk-linux-build
endif 

gio-run:

ifeq ($(GIO_GO_OS),windows)
	$(MAKE) gio-desk-windows-run
endif

ifeq ($(GIO_GO_OS),darwin)
	$(MAKE) gio-desk-darwin-run
endif

ifeq ($(GIO_GO_OS),linux)
	$(MAKE) gio-desk-linux-run
endif 
	
gio-runpack:

ifeq ($(GIO_GO_OS),windows)
	$(MAKE) gio-desk-windows-runpack
endif

ifeq ($(GIO_GO_OS),darwin)
	$(MAKE) gio-desk-darwin-runpack
endif

ifeq ($(GIO_GO_OS),linux)
	$(MAKE) gio-desk-linux-runpack
endif 

gio-web-run:
	# uses caddy, so dep it first.
	echo http://localhost
	cd $(GIO_BUILD_WEB_PATH) && caddy file-server
	

# Deletes the gio build folder
gio-build-delete:
	rm -rf $(GIO_BUILD_FSPATH)
gio-build-release-delete:
	rm -rf $(GIO_BUILD_RELEASE_FSPATH)


### WEB

GIO_BUILD_WEB_PATH=$(GIO_BUILD_FSPATH)/web_wasm/$(GIO_SRC_NAME).web
GIO_BUILD_TINYWASM_PATH=$(GIO_BUILD_FSPATH)/web_tinywasm/$(GIO_SRC_NAME).web
GIO_BUILD_WASM_PATH=$(GIO_BUILD_FSPATH)/web_wasm/$(GIO_SRC_NAME).web

gio-web-print:
	@echo "GIO_BUILD_WEB_PATH:                 $(GIO_BUILD_WEB_PATH)"
	@echo "GIO_BUILD_TINYWASM_PATH:            $(GIO_BUILD_TINYWASM_PATH)"
	@echo "GIO_BUILD_WASM_PATH:                $(GIO_BUILD_WASM_PATH)"
	
gio-web-build:
	@echo ""
	@echo "$(GIO_SRC_NAME): js wasm ( using gio cmd )"

	@echo ""
	@echo ""
	@echo ""
	@echo "web - js"
	@echo ""

	cd $(GIO_SRC_FSPATH) && $(GIO_GO_BIN_NAME) generate -v ./...
	
	## TODO <title>foobar</title> is not changed in index.html despite setting the -appid
	cd $(GIO_SRC_FSPATH) && $(GIO_BIN) -target js -appid $(GIO_SRC_NAME) -icon appicon.png -o $(GIO_BUILD_WEB_PATH) .
	
gio-wasmtiny-build:
	@echo ""
	@echo ""
	@echo ""
	@echo "$(GIO_SRC_NAME): wasip1 wasm ( using tinygo )"
	cd $(GIO_SRC_FSPATH) && $(GIO_GO_BIN_NAME) generate -v ./...
	# also try "-scheduler=none" as it removed goroutine and speeds up build.
	cd $(GIO_SRC_FSPATH) && tinygo build -o $(GIO_BUILD_TINYWASM_PATH) -target wasm .


gio-wasm-build:
	@echo ""
	@echo ""
	@echo ""
	@echo "$(GIO_SRC_NAME): wasip1 wasm  ( using gotip )"

	@echo ""
	@echo "web - wasip1"
	@echo ""
	cd $(GIO_SRC_FSPATH) && $(GIO_GO_BIN_NAME) generate -v ./...
	
	cd $(GIO_SRC_FSPATH) && GOOS=wasip1 GOARCH=wasm $(GIO_GO_BIN_NAME) build -tags $(GIO_SRC_TAG) -o $(GIO_BUILD_WASM_PATH) .

	# tinygo not needed now
	#cd $(GIO_SRC_FSPATH) && tinygo build -o $(GIO_BUILD_TINYWASM_PATH) -target wasm .

### DESK

### DESK - MACOS

# debug

GIO_BUILD_DARWIN_PACK=$(GIO_BUILD_FSPATH)/darwin_amd64/$(GIO_SRC_NAME).app
GIO_BUILD_DARWIN_BIN=$(GIO_BUILD_FSPATH)/darwin_amd64/$(GIO_SRC_NAME).app//Contents/MacOS/$(GIO_SRC_NAME)

GIO_BUILD_DARWIN_AMD64_PACK=$(GIO_BUILD_FSPATH)/darwin_amd64/$(GIO_SRC_NAME).app
GIO_BUILD_DARWIN_ARM64_PACK=$(GIO_BUILD_FSPATH)/darwin_arm64/$(GIO_SRC_NAME).app
GIO_BUILD_DARWIN_AMD64_BIN=$(GIO_BUILD_DARWIN_AMD64_PACK)/Contents/MacOS/$(GIO_SRC_NAME)
GIO_BUILD_DARWIN_ARM64_BIN=$(GIO_BUILD_DARWIN_ARM64_PACK)/Contents/MacOS/$(GIO_SRC_NAME)

# release

GIO_BUILD_DARWIN_RELEASE_PACK=$(GIO_BUILD_RELEASE_FSPATH)/darwin_amd64/$(GIO_SRC_NAME).app
GIO_BUILD_DARWIN_RELEASE_BIN=$(GIO_BUILD_RELEASE_FSPATH)/darwin_amd64/$(GIO_SRC_NAME).app//Contents/MacOS/$(GIO_SRC_NAME)

GIO_BUILD_DARWIN_RELEASE_AMD64_PACK=$(GIO_BUILD_RELEASE_FSPATH)/darwin_amd64/$(GIO_SRC_NAME).app
GIO_BUILD_DARWIN_RELEASE_ARM64_PACK=$(GIO_BUILD_RELEASE_FSPATH)/darwin_arm64/$(GIO_SRC_NAME).app
GIO_BUILD_DARWIN_RELEASE_AMD64_BIN=$(GIO_BUILD_DARWIN_RELEASE_AMD64_PACK)/Contents/MacOS/$(GIO_SRC_NAME)
GIO_BUILD_DARWIN_RELEASE_ARM64_BIN=$(GIO_BUILD_DARWIN_RELEASE_ARM64_PACK)/Contents/MacOS/$(GIO_SRC_NAME)


gio-desk-darwin-print:
	@echo ""
	@echo "- gio-desk-darwin-print:"
	@echo "GIO_BUILD_DARWIN_AMD64_PACK:        $(GIO_BUILD_DARWIN_AMD64_PACK)"
	@echo "GIO_BUILD_DARWIN_ARM64_PACK:        $(GIO_BUILD_DARWIN_ARM64_PACK)"
	@echo "GIO_BUILD_DARWIN_AMD64_BIN:         $(GIO_BUILD_DARWIN_AMD64_BIN)"
	@echo "GIO_BUILD_DARWIN_ARM64_BIN:         $(GIO_BUILD_DARWIN_ARM64_BIN)"
	@echo ""
	@echo "-run:"
	@echo "GIO_BUILD_DARWIN_PACK:              $(GIO_BUILD_DARWIN_PACK)"
	@echo "GIO_BUILD_DARWIN_BIN:               $(GIO_BUILD_DARWIN_BIN)"

	# release
	
	@echo ""
	@echo "- gio-desk-darwin-release-print:"
	@echo "GIO_BUILD_DARWIN_RELEASE_AMD64_PACK:        $(GIO_BUILD_DARWIN_RELEASE_AMD64_PACK)"
	@echo "GIO_BUILD_DARWIN_RELEASE_ARM64_PACK:        $(GIO_BUILD_DARWIN_RELEASE_ARM64_PACK)"
	@echo "GIO_BUILD_DARWIN_RELEASE_AMD64_BIN:         $(GIO_BUILD_DARWIN_RELEASE_AMD64_BIN)"
	@echo "GIO_BUILD_DARWIN_RELEASE_ARM64_BIN:         $(GIO_BUILD_DARWIN_RELEASE_ARM64_BIN)"
	@echo ""
	@echo "- run:"
	@echo "GIO_BUILD_DARWIN_RELEASE_PACK:              $(GIO_BUILD_DARWIN_RELEASE_PACK)"
	@echo "GIO_BUILD_DARWIN_RELEASE_BIN:               $(GIO_BUILD_DARWIN_RELEASE_BIN)"

gio-desk-darwin-build: 

	@echo ""
	@echo ""
	@echo ""
	@echo "-- gio-desk-darwin-build --"
	@echo ""
	@echo "GIO_BUILD_DARWIN_AMD64_PACK:       $(GIO_BUILD_DARWIN_AMD64_PACK)"
	@echo "GIO_BUILD_DARWIN_BIN:              $(GIO_BUILD_DARWIN_AMD64_PACK)"
	@echo ""

	# this packages it automatically as a .app
	cd $(GIO_SRC_FSPATH) && $(GIO_GO_BIN_NAME) generate -v ./...
	# the new way.
	# appid does change the plist Bundle identifier, and binary name inside the packaging.
	@echo ""
	@echo "darwin - packed"
	@echo ""

	@echo ""
	@echo "-- amd64"
	@echo ""
	cd $(GIO_SRC_FSPATH) && $(GIO_BIN) -target macos -arch amd64 -appid $(GIO_SRC_NAME) -icon appicon.png -o $(GIO_BUILD_DARWIN_AMD64_PACK) .
	codesign -s - $(GIO_BUILD_DARWIN_AMD64_PACK)

	@echo ""
	@echo "-- arm64"
	@echo ""
	cd $(GIO_SRC_FSPATH) && $(GIO_BIN) -target macos -arch arm64 -appid $(GIO_SRC_NAME) -icon appicon.png -o $(GIO_BUILD_DARWIN_ARM64_PACK) .
	codesign -s - $(GIO_BUILD_DARWIN_AMD64_PACK)
	
	# also need without packing
	@echo ""
	@echo "darwin - binary"
	@echo ""

	@echo ""
	@echo "-- amd64"
	@echo ""
	cp $(GIO_BUILD_DARWIN_AMD64_BIN) $(GIO_BUILD_FSPATH)/darwin_amd64/$(GIO_SRC_NAME)

	@echo ""
	@echo "-- arm64"
	@echo ""
	cp $(GIO_BUILD_DARWIN_ARM64_BIN) $(GIO_BUILD_FSPATH)/darwin_arm64/$(GIO_SRC_NAME)


gio-desk-darwin-run:
	open $(GIO_BUILD_DARWIN_BIN)
gio-desk-darwin-runpack:
	open $(GIO_BUILD_DARWIN_PACK)

# release

gio-desk-darwin-release-build:
	
	@echo ""
	@echo ""
	@echo ""
	@echo "darwin - binary release"
	@echo ""

	#cd $(GIO_SRC_FSPATH) && $(GIO_GO_BIN_NAME) generate -v ./...

	# CURRENTLY garble messes it up.
	
	# first build binary inside the pack scaffold.
	#  -debugdir=out
	mkdir -p $(GIO_BUILD_DARWIN_RELEASE_AMD64_BIN)_out
	cd $(GIO_SRC_FSPATH) && GOOS=darwin GOARCH=amd64 $(GIO_GARBLE_BIN_NAME) -debugdir=$(GIO_BUILD_DARWIN_RELEASE_AMD64_BIN)_out -tiny build .
	
	# need to copy go.mod etc in.
	cp $(GIO_SRC_FSPATH)/go.mod $(GIO_BUILD_DARWIN_RELEASE_AMD64_BIN)_out/$(GIO_SRC_NAME)
	cp $(GIO_SRC_FSPATH)/go.sum $(GIO_BUILD_DARWIN_RELEASE_AMD64_BIN)_out/$(GIO_SRC_NAME)

	@echo ""
	@echo "-- amd64"
	@echo ""
	cd $(GIO_BUILD_DARWIN_RELEASE_AMD64_BIN)_out/$(GIO_SRC_NAME) && $(GIO_BIN) -target macos -arch amd64 -appid $(GIO_SRC_NAME) -icon appicon.png -o $(GIO_BUILD_DARWIN_RELEASE_AMD64_PACK) .
	
	@echo ""
	@echo "-- amd64: NOP"
	@echo ""
	#cd $(GIO_SRC_FSPATH) && $(GIO_BIN) -target macos -arch arm64 -appid $(GIO_SRC_NAME) -icon appicon.png -o $(GIO_BUILD_DARWIN_RELEASE_ARM64_PACK) .
gio-desk-darwin-release-run:
	open $(GIO_BUILD_DARWIN_RELEASE_BIN)

gio-desk-darwin-sign-notorise:
	# still to do...
gio-desk-darwin-sign:
	# https://github.com/gioui/gio-cmd/blob/main/gogio/darwinosbuild.go
	# this inserts the signing into the built .app.
	codesign -s - $(GIO_BUILD_DARWIN_AMD64_PACK)
	codesign -s - $(GIO_BUILD_DARWIN_ARM64_PACK)
gio-desk-darwin-sign-check:
	# https://osxdaily.com/2016/03/14/verify-code-sign-apps-darwin-os-x/
	# Look at Authority values !!
	codesign -dv --verbose=4 $(GIO_BUILD_DARWIN_AMD64_PACK)
	codesign -dv --verbose=4 $(GIO_BUILD_DARWIN_ARM64_PACK)
	@echo ""
	@echo "terminal app, just to compare for now..."
	codesign -dv --verbose=4 /System/Applications/Utilities/Terminal.app
	

### DESK - WINDOWS

GIO_BUILD_WINDOWS_AMD64_PATH=$(GIO_BUILD_FSPATH)/windows_amd64/$(GIO_SRC_NAME).exe
GIO_BUILD_WINDOWS_ARM64_PATH=$(GIO_BUILD_FSPATH)/windows_arm64/$(GIO_SRC_NAME).exe
GIO_BUILD_WINDOWS_PATH=$(GIO_BUILD_FSPATH)/windows_amd64/$(GIO_SRC_NAME).exe

GIO_BUILD_WINDOWS_RELEASE_AMD64_PATH=$(GIO_BUILD_RELEASE_FSPATH)/windows_amd64/$(GIO_SRC_NAME).exe
GIO_BUILD_WINDOWS_RELEASE_ARM64_PATH=$(GIO_BUILD_RELEASE_FSPATH)/windows_arm64/$(GIO_SRC_NAME).exe
GIO_BUILD_WINDOWS_RELEASE_PATH=$(GIO_BUILD_RELEASE_FSPATH)/windows_amd64/$(GIO_SRC_NAME).exe

# NOT finished
gio-desk-windows-print:
	@echo ""
	@echo "- gio-desk-windows-print:"
	@echo "GIO_BUILD_WINDOWS_AMD64_PATH:             $(GIO_BUILD_WINDOWS_AMD64_PATH)"
	@echo "GIO_BUILD_WINDOWS_ARM64_PATH:             $(GIO_BUILD_WINDOWS_ARM64_PATH)"
	@echo "GIO_BUILD_WINDOWS_PATH:                   $(GIO_BUILD_WINDOWS_PATH)"
	@echo ""
	@echo "- gio-desk-windows-release-print:"
	@echo "GIO_BUILD_WINDOWS_RELEASE_AMD64_PATH:     $(GIO_BUILD_WINDOWS_RELEASE_AMD64_PATH)"
	@echo "GIO_BUILD_WINDOWS_RELEASE_ARM64_PATH:     $(GIO_BUILD_WINDOWS_RELEASE_ARM64_PATH)"
	@echo "GIO_BUILD_WINDOWS_RELEASE_PATH:           $(GIO_BUILD_WINDOWS_RELEASE_PATH)"

	
gio-desk-windows-pack-init:
	# TODO: 
gio-desk-windows-build:
	@echo ""
	@echo ""
	@echo ""
	@echo "windows - binary"
	@echo ""
	# this does not packaging. Its just .exe for now.

	@echo ""
	@echo "-- amd64"
	@echo ""
	cd $(GIO_SRC_FSPATH) && $(GIO_BIN) -target windows -arch amd64 -appid $(GIO_SRC_NAME) -icon appicon.png -o $(GIO_BUILD_WINDOWS_AMD64_PATH) .
	
	@echo ""
	@echo "-- arm64"
	@echo ""
	cd $(GIO_SRC_FSPATH) && $(GIO_BIN) -target windows -arch arm64 -appid $(GIO_SRC_NAME) -icon appicon.png -o $(GIO_BUILD_WINDOWS_ARM64_PATH) .

gio-desk-windows-release-build:
	@echo ""
	@echo ""
	@echo ""
	@echo "windows - binary release"
	@echo ""
	# this does not packaging. Its just .exe for now.

	@echo ""
	@echo "-- amd64"
	@echo ""
	cd $(GIO_SRC_FSPATH) && $(GIO_BIN) -target windows -arch amd64 -appid $(GIO_SRC_NAME) -icon appicon.png -o $(GIO_BUILD_WINDOWS_RELEASE_AMD64_PATH) .
	
	@echo ""
	@echo "-- arm64"
	@echo ""
	cd $(GIO_SRC_FSPATH) && $(GIO_BIN) -target windows -arch arm64 -appid $(GIO_SRC_NAME) -icon appicon.png -o $(GIO_BUILD_WINDOWS_RELEASE_ARM64_PATH) .

gio-desk-windows-run:
	open $(GIO_BUILD_WINDOWS_PATH)
gio-desk-windows-release-run:
	open $(GIO_BUILD_WINDOWS_RELEASE_PATH)


### DESK - LINUX

GIO_BUILD_LINUX_AMD64_PATH=$(GIO_BUILD_FSPATH)/linux_amd64/$(GIO_SRC_NAME)
GIO_BUILD_LINUX_ARM64_PATH=$(GIO_BUILD_FSPATH)/linux_arm64/$(GIO_SRC_NAME)
GIO_BUILD_LINUX_PATH=$(GIO_BUILD_FSPATH)/linux_amd64/$(GIO_SRC_NAME)

GIO_BUILD_LINUX_RELEASE_AMD64_PATH=$(GIO_BUILD_RELEASE_FSPATH)/linux_amd64/$(GIO_SRC_NAME)
GIO_BUILD_LINUX_RELEASE_ARM64_PATH=$(GIO_BUILD_RELEASE_FSPATH)/linux_arm64/$(GIO_SRC_NAME)
GIO_BUILD_LINUX_RELEASE_PATH=$(GIO_BUILD_RELEASE_FSPATH)/linux_amd64/$(GIO_SRC_NAME)

# NOT finished
gio-desk-linux-print:
	@echo ""
	@echo "- gio-desk-linux-print:"
	@echo "GIO_BUILD_LINUX_AMD64_PATH:             $(GIO_BUILD_LINUX_AMD64_PATH)"
	@echo "GIO_BUILD_LINUX_ARM64_PATH:             $(GIO_BUILD_LINUX_ARM64_PATH)"
	@echo "GIO_BUILD_LINUX_PATH:                   $(GIO_BUILD_LINUX_PATH)"
	@echo ""
	@echo "- gio-desk-linux-release-print:"
	@echo "GIO_BUILD_LINUX_RELEASE_AMD64_PATH:     $(GIO_BUILD_LINUX_RELEASE_AMD64_PATH)"
	@echo "GIO_BUILD_LINUX_RELEASE_ARM64_PATH:     $(GIO_BUILD_LINUX_RELEASE_ARM64_PATH)"
	@echo "GIO_BUILD_LINUX_RELEASE_PATH:           $(GIO_BUILD_LINUX_RELEASE_PATH)"

	
gio-desk-linux-pack-init:
	# TODO: create scaffold maually and go build and insert bin into scaffold for now.
gio-desk-linux-build:
	@echo ""
	@echo ""
	@echo ""
	@echo "Linux - binary"
	@echo ""

	@echo ""
	@echo "-- amd64"
	@echo ""
	cd $(GIO_SRC_FSPATH) && GOOS=linux GOARCH=amd64 && $(GIO_GO_BIN_NAME) build -o $(GIO_BUILD_LINUX_AMD64_PATH) .
	
	@echo ""
	@echo "-- arm64"
	@echo ""
	cd $(GIO_SRC_FSPATH) && GOOS=linux GOARCH=arm64 && $(GIO_GO_BIN_NAME) build -o $(GIO_BUILD_LINUX_ARM64_PATH) .

	# gogio seems to not support linux desktop builds..
	#cd $(GIO_SRC_FSPATH) && $(GIO_BIN) -target linux -arch amd64 -appid $(GIO_SRC_NAME) -icon appicon.png -o $(GIO_BUILD_LINUX_AMD64_PATH) .
	#cd $(GIO_SRC_FSPATH) && $(GIO_BIN) -target linux -arch arm64 -appid $(GIO_SRC_NAME) -icon appicon.png -o $(GIO_BUILD_LINUX_ARM64_PATH) .
gio-desk-linux-release-build:
	@echo ""
	@echo ""
	@echo ""
	@echo "Linux - binary release"
	@echo ""

	@echo ""
	@echo "-- amd64"
	@echo ""
	cd $(GIO_SRC_FSPATH) && GOOS=linux GOARCH=amd64 && $(GIO_GO_BIN_NAME) build -o $(GIO_BUILD_LINUX_RELEASE_AMD64_PATH) .
	@echo ""
	@echo "-- arm64"
	@echo ""
	cd $(GIO_SRC_FSPATH) && GOOS=linux GOARCH=arm64 && $(GIO_GO_BIN_NAME) build -o $(GIO_BUILD_LINUX_RELEASE_ARM64_PATH) .
gio-desk-linux-run:
	open $(GIO_BUILD_LINUX_PATH)
gio-desk-linux-release-run:
	open $(GIO_BUILD_LINUX_RELEASE_PATH)






### IOS

GIO_BUILD_IOS_PATH=$(GIO_BUILD_FSPATH)/ios/$(GIO_SRC_NAME).ipa
GIO_BUILD_IOS_SIM_PATH=$(GIO_BUILD_FSPATH)/ios-sim/$(GIO_SRC_NAME).app
GIO_BUILD_IOS_BUNDLE_ID=gedw99.$(GIO_SRC_NAME)
# from: xcrun simctl list
# TOOO: make this an ENV variable or SRC variable.
GIO_BUILD_IOS_SIM_DEVICE_ID=B19F5A2A-817F-4DAE-89E5-7353B8EA7DDE



gio-ios-print:
	@echo ""
	@echo "-- IOS --"
	@echo "GIO_BUILD_IOS_PATH:                 $(GIO_BUILD_IOS_PATH)"
	@echo "GIO_BUILD_IOS_SIM_PATH:             $(GIO_BUILD_IOS_SIM_PATH)"
	@echo "GIO_BUILD_IOS_BUNDLE_ID:            $(GIO_BUILD_IOS_BUNDLE_ID)"	
	@echo ""
	@echo "-- IOS SIM --"
	@echo "GIO_BUILD_IOS_SIM_DEVICE_ID:        $(GIO_BUILD_IOS_SIM_DEVICE_ID)"
	@echo ""
gio-ios-dep:
	@echo ""
	@echo "install ios tooling ..."

	# 1. xcode
	#xcode-select --install
	
	# 2. Set Commandline tools to work. Yeah its weird but its what everyone does.
	#sudo xcode-select -s /Applications/Xcode.app
	
	# 3. IOS Simulator takes 7 GB
	# https://developer.apple.com/documentation/xcode/installing-additional-simulator-runtimes
	xcodebuild -downloadPlatform iOS 
	# DOnt bother as its huge..
	#xcodebuild -downloadAllPlatforms

	# 4. List devices and pick one
	xcrun simctl list devices
	@echo "PICK ON and update GIO_BUILD_IOS_SIM_DEVICE_ID var ..."


gio-ios-build:
	@echo ""
	@echo "building ios app ..."
	# -work IF you want to see the xcode generated.

	# make build dir
	mkdir -p $(GIO_BUILD_FSPATH)/ios
	
	# FAILS: nope - needs a provioning profile.
	cd $(GIO_SRC_FSPATH) && $(GIO_BIN) -work -appid $(GIO_BUILD_IOS_BUNDLE_ID) -buildmode exe -o $(GIO_BUILD_IOS_PATH) -target ios .
gio-ios-install:
	@echo ""
	@echo "installing ios app to device ..."
	# see: https://www.systutorials.com/docs/lin/man/1-ideviceinstaller/
	# idevice_id -l
	cd $(GIO_SRC_FSPATH) && ideviceinstaller -i $(GIO_BUILD_IOS_PATH) --udid bdf90dc799709a013a25d0fc2df80e441df026f3

gio-ios-sim-build:
	@echo ""
	@echo "buildong ios app for simulator ..."
	#exe and archive
	# -work IF you want to see the xcode generated.

	# make build dir
	mkdir -p $(GIO_BUILD_FSPATH)/ios-sim/

	cd $(GIO_SRC_FSPATH) && $(GIO_BIN) -work -appid $(GIO_BUILD_IOS_BUNDLE_ID) -buildmode exe -o $(GIO_BUILD_IOS_SIM_PATH) -target ios .

gio-ios-sim-install:
	@echo ""
	@echo "installing ios app to simulator ..."

	# 1. boot that device
	# TODO: check which to run..
	#xcrun simctl shutdown $(GIO_BUILD_IOS_SIM_DEVICE_ID)
	#xcrun simctl boot $(GIO_BUILD_IOS_SIM_DEVICE_ID)

	# 2. install the app on that booted device.
	xcrun simctl install booted $(GIO_BUILD_IOS_SIM_PATH)

gio-ios-sim-install-del:
	@echo ""
	@echo "uninstalling ios app from simulator ..."
	xcrun simctl uninstall booted $(GIO_BUILD_IOS_BUNDLE_ID)


gio-ios-sim-run:
	@echo ""
	@echo "opens the ios app on the simulator ..."
	# 1. Open the actual GUI
	open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/

	# 2. Launch the App
	#xcrun simctl launch <device> <bundle> <arguments>
	xcrun simctl launch $(GIO_BUILD_IOS_SIM_DEVICE_ID) $(GIO_BUILD_IOS_BUNDLE_ID) .
	#xcrun simctl launch --console-pty $(GIO_BUILD_IOS_SIM_DEVICE_ID) $(GIO_BUILD_IOS_BUNDLE_ID) .



gio-ios-sim-bootstrap:
	@echo ""
	@echo "Images, resources, permisions setup that are typical.."

	# 1. add Images
	xcrun simctl addmedia
gio-ios-sim-notify-touch:
	@echo ""
	@echo "Pushing a notifications ..."

	# 1. Create the File that describes the notification
	touch ./example-push.apns
	cat > ./example-push.apns << EOF
	This is an input stream literal
	EOF
gio-ios-sim-notify:
	# 2. Push it.
	xcrun simctl push booted $(GIO_BUILD_IOS_BUNDLE_ID) ./example-push.apns
	

### ANDROID



GIO_BUILD_ANDROID_PATH=$(GIO_BUILD_FSPATH)/android/$(GIO_SRC_NAME).apk

gio-android-print:
	@echo "GIO_BUILD_ANDROID_PATH:             $(GIO_BUILD_ANDROID_PATH)"

gio-android-build:
	# todo: adjust buil path to be in .bin ....
	mkdir -p $(GIO_BUILD_FSPATH)/android/
	cd $(GIO_SRC_FSPATH) && $(GIO_BIN) -o $(GIO_BUILD_ANDROID_PATH) -target android .
gio-android-device-start:
	# Blocks in Terminal.
	# start emulator ( .zshrc )
	emulator @testdevice 
gio-android-install:
	# copy apk across to emulator
	cd $(GIO_SRC_FSPATH) && adb install $(GIO_BUILD_ANDROID_PATH)
gio-android-install-del:
	adb uninstall org.gioui.component