SC=$(PWD)/_make

include $(SC)/os.mk

include $(SC)/caddy.mk
include $(SC)/gio.mk
include $(SC)/go.mk
include $(SC)/nats.mk

# MUST be last
include .env-git
include .env

# all binaries we make go here.
#BIN_ROOT=$(PWD)/.bin
#export $(PATH):=$(PATH):$(BIN_ROOT)

ci-all: print all

ci-test:
	@echo "hi ci "

print: os-print os-git-print env-print
	
all: dep-all dep-print build-all

### CLEAN

clean-os:
	# delete go stuff on OS that build up.
	$(MAKE) go-clean-os
clean-project:
	# delete any .bin folder
	$(MAKE) go-clean-bin-run

	# delete any .bin folder
	$(MAKE) go-clean-data-run
	
### ENV

env-print:
	@echo ""
	@echo "-- ENV --"
	@echo "CADDY_SRC_CONFIG_FSPATH:     $(CADDY_SRC_CONFIG_FSPATH)"
	@echo "GOREMAN_SRC_CONFIG_FSPATH:   $(GOREMAN_SRC_CONFIG_FSPATH)"
	@echo "NATS_SRC_CONFIG_FSPATH:      $(NATS_SRC_CONFIG_FSPATH)"
	@echo ""
	

### DEPS

dep-print:
	$(MAKE) caddy-print
	$(MAKE) gio-print
	$(MAKE) go-print
	$(MAKE) nats-print


dep-all:
	$(MAKE) caddy-dep
	$(MAKE) gio-dep
	$(MAKE) go-dep
	$(MAKE) nats-dep
	
	
start-goreman:
	# DONT USE. Its leaking processes.
	#$(MAKE) goreman-server-run

start-caddy:
	$(MAKE) caddy-server-run
	# https://browse.localhost/
	# https://bin.localhost/

	# Client is here:
	# https://browse.localhost/cmd/client/.bin/giobuild/web_wasm/gio-htmx.web/

start-nats:
	$(MAKE) nats-server-run
	# Listening for websocket clients on wss://0.0.0.0:443
	# Listening for client connections on 0.0.0.0:4222
	

build-all: build-client-all

CLIENT_SRC_FSAPTH=$(PWD)/cmd/client
CLIENT_SRC_NAME=gio-htmx

build-client:
	$(MAKE) GIO_SRC_NAME=$(CLIENT_SRC_NAME) GIO_SRC_FSPATH=$(CLIENT_SRC_FSAPTH) gio-build
	# hack works for now..
	$(MAKE) go-clean-syso-run
build-client-all:
	$(MAKE) GIO_SRC_NAME=$(CLIENT_SRC_NAME) GIO_SRC_FSPATH=$(CLIENT_SRC_FSAPTH) gio-build-all
	# hack works for now..
	$(MAKE) go-clean-syso-run

SERVER_SRC_FSAPTH=$(PWD)/cmd/nerv
SERVER_SRC_NAME=gio-nerv-server

build-server:
	$(MAKE) GO_SRC_NAME=$(SERVER_SRC_NAME) GO_SRC_FSPATH=$(SERVER_SRC_FSAPTH) go-build
build-server-all:
	$(MAKE) GO_SRC_NAME=$(SERVER_SRC_NAME) GO_SRC_FSPATH=$(SERVER_SRC_FSAPTH) go-build-all

run-client:
	open $(CLIENT_SRC_FSAPTH)/.bin/giobuild/darwin_amd64

run-server:
	open $(SERVER_SRC_FSAPTH)/.bin/gobuild/darwin_amd64/$(SERVER_SRC_NAME)

build-docker:
	cd cmd/docker && $(MAKE) go-build-clean
	#cd cmd/docker && $(MAKE) go-build
