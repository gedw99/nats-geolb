# NATS BOX ( https://github.com/nats-io/nats-box) 
# has many of these tools with correct version matrix


### ENV ###

 # where to place binaries. Default is local .bin !!!
NATS_SRC_BIN_FSPATH=$(PWD)/.bin

# where to look for Nats Config file to use at runtime
NATS_DEFAULT_CONFIG_NAME=Natsfile
NATS_SRC_CONFIG_NAME=Natsfile
NATS_SRC_CONFIG_FSPATH=$(PWD)/.templates/nats/_default
NATS_SRC_CONFIG=$(NATS_SRC_CONFIG_FSPATH)/$(NATS_SRC_CONFIG_NAME)

NATS_DEFAULT_DATA_FSPATH=$(PWD)/.data/nats
NATS_SRC_NSC_DATA_FSPATH=$(NATS_DEFAULT_DATA_FSPATH)/nsc


### DEPS

# NATS-SERVER
# https://github.com/nats-io/nats-server
# https://github.com/nats-io/nats-server/releases/tag/v2.10.0
NATS_SERVER_BIN_NAME=nats-server
NATS_SERVER_BIN_VERSION=v2.10.0
#NATS_SERVER_BIN_VERSION=latest
NATS_SERVER_BIN_WHICH=$(shell which $(NATS_SERVER_BIN_NAME))
NATS_SERVER_BIN_WHICH_VERSION=$(shell $(NATS_SERVER_BIN_WHICH) --version)

# NATS
# https://github.com/nats-io/natscli
# https://github.com/nats-io/natscli/releases/tag/v0.1.1
NATS_CLI_BIN_NAME=nats
NATS_CLI_BIN_VERSION=v0.1.1
#NATS_CLI_BIN_VERSION=latest
NATS_CLI_BIN_WHICH=$(shell which $(NATS_CLI_BIN_NAME))
NATS_CLI_BIN_WHICH_VERSION=$(shell $(NATS_CLI_BIN_WHICH) --version)

# NSC
# # docs: https://docs.nats.io/using-nats/nats-tools/nsc/basics
# https://github.com/nats-io/nsc
# https://github.com/nats-io/nsc/releases/tag/v2.8.1
NATS_NSC_BIN_NAME=nsc
NATS_NSC_BIN_VERSION=v2.8.1
#NATS_NSC_BIN_VERSION=latest
NATS_NSC_BIN_WHICH=$(shell which $(NATS_NSC_BIN_NAME))
NATS_NSC_BIN_WHICH_VERSION=$(shell $(NATS_NSC_BIN_WHICH) --version)

# NK
# https://github.com/nats-io/nkeys
# https://github.com/nats-io/nkeys/releases/tag/v0.4.5
NATS_NK_BIN_NAME=nk
NATS_NK_BIN_VERSION=v0.4.5
#NATS_NK_BIN_VERSION=latest
NATS_NK_BIN_WHICH=$(shell which $(NATS_NK_BIN_NAME))
NATS_NK_BIN_WHICH_VERSION=$(shell $(NATS_NK_BIN_NAME) --version)
# comments out because too much shit back ...
#NATS_NK_BIN_WHICH_VERSION=$(shell $(NATS_NK_BIN_WHICH) --version)

# NATS_TOP
# https://github.com/nats-io/nats-top
# https://github.com/nats-io/nats-top/releases/tag/v0.6.1
NATS_TOP_BIN_NAME=nats-top
NATS_TOP_BIN_VERSION=v0.6.1
NATS_TOP_BIN_VERSION=latest
NATS_TOP_BIN_WHICH=$(shell which $(NATS_TOP_BIN_NAME))
NATS_TOP_BIN_WHICH_VERSION=$(shell $(NATS_TOP_BIN_WHICH) --version)


## nats print, outputs all variables needed to run nats
nats-print:
	@echo ""
	@echo "--- NATS ---"
	@echo ""
	@echo ""
	@echo "---- ENV ----"
	@echo "NATS_SRC_BIN_FSPATH:              $(NATS_SRC_BIN_FSPATH)"
	@echo ""
	@echo "NATS_SRC_CONFIG_NAME:             $(NATS_SRC_CONFIG_NAME)"
	@echo "NATS_SRC_CONFIG_FSPATH:           $(NATS_SRC_CONFIG_FSPATH)"
	@echo "NATS_SRC_CONFIG:                  $(NATS_SRC_CONFIG)"
	@echo ""
	@echo "NATS_SRC_NSC_DATA_FSPATH:         $(NATS_SRC_NSC_DATA_FSPATH)"
	@echo ""
	@echo ""
	@echo "---- BIN ----"
	@echo "NATS_SERVER_BIN_NAME:             $(NATS_SERVER_BIN_NAME)"
	@echo "NATS_SERVER_BIN_VERSION:          $(NATS_SERVER_BIN_VERSION)"
	@echo "NATS_SERVER_BIN_WHICH:            $(NATS_SERVER_BIN_WHICH)"
	@echo "NATS_SERVER_BIN_WHICH_VERSION:    $(NATS_SERVER_BIN_WHICH_VERSION)"
	@echo ""

	@echo ""
	@echo "NATS_CLI_BIN_NAME:                $(NATS_CLI_BIN_NAME)"
	@echo "NATS_CLI_BIN_VERSION:             $(NATS_CLI_BIN_VERSION)"
	@echo "NATS_CLI_BIN_WHICH:               $(NATS_CLI_BIN_WHICH)"
	@echo "NATS_CLI_BIN_WHICH_VERSION:       $(NATS_CLI_BIN_WHICH_VERSION)"
	@echo ""

	@echo ""
	@echo "NATS_NSC_BIN_NAME:                $(NATS_NSC_BIN_NAME)"
	@echo "NATS_NSC_BIN_VERSION:             $(NATS_NSC_BIN_VERSION)"
	@echo "NATS_NSC_BIN_WHICH:               $(NATS_NSC_BIN_WHICH)"
	@echo "NATS_NSC_BIN_WHICH_VERSION:       $(NATS_NSC_BIN_WHICH_VERSION)"
	@echo ""

	@echo ""
	@echo "NATS_NK_BIN_NAME:                 $(NATS_NK_BIN_NAME)"
	@echo "NATS_NK_BIN_VERSION:              $(NATS_NK_BIN_VERSION)"
	@echo "NATS_NK_BIN_WHICH:                $(NATS_NK_BIN_WHICH)"
	@echo "NATS_NK_BIN_WHICH_VERSION:        $(NATS_NK_BIN_WHICH_VERSION)"
	@echo ""

	@echo ""
	@echo "NATS_TOP_BIN_NAME:                $(NATS_TOP_BIN_NAME)"
	@echo "NATS_TOP_BIN_VERSION:             $(NATS_TOP_BIN_VERSION)"
	@echo "NATS_TOP_BIN_WHICH:               $(NATS_TOP_BIN_WHICH)"
	@echo "NATS_TOP_BIN_WHICH_VERSION:       $(NATS_TOP_BIN_WHICH_VERSION)"

	


## installs nats
nats-dep:
	@echo ""
	@echo "installing NATS server"
	go install -ldflags="-X main.version=$(NATS_SERVER_BIN_VERSION)" github.com/nats-io/nats-server/v2@$(NATS_SERVER_BIN_VERSION)
	
	#mv $(GOPATH)/bin/$(NATS_SERVER_BIN_NAME) $(NATS_SRC_BIN_FSPATH)/$(NATS_SERVER_BIN_NAME)

	@echo ""
	@echo "installing NATS cli tool"
	go install -ldflags="-X main.version=$(NATS_CLI_BIN_VERSION)" github.com/nats-io/natscli/nats@$(NATS_CLI_BIN_VERSION)
	
	#mv $(GOPATH)/bin/$(NATS_CLI_BIN_NAME) $(NATS_SRC_BIN_FSPATH)/$(NATS_CLI_BIN_NAME)

	@echo ""
	@echo "installing NATS nsc tool"
	go install -ldflags="-X main.version=$(NATS_NSC_BIN_VERSION)" github.com/nats-io/nsc/v2@$(NATS_NSC_BIN_VERSION)
	
	#mv $(GOPATH)/bin/$(NATS_NSC_BIN_NAME) $(NATS_SRC_BIN_FSPATH)/$(NATS_NSC_BIN_NAME)

	@echo ""
	@echo "installing NATS nk tool"
	go install -ldflags="-X main.version=$(NATS_NK_BIN_VERSION)" github.com/nats-io/nkeys/nk@$(NATS_NK_BIN_VERSION)
	#mv $(GOPATH)/bin/$(NATS_NK_BIN_NAME) $(NATS_SRC_BIN_FSPATH)/$(NATS_NK_BIN_NAME)

	#@echo ""
	#@echo "installing NATS top tool"
	#go install -ldflags="-X main.version=$(NATS_TOP_BIN_VERSION)" github.com/nats-io/nats-top@$(NATS_TOP_BIN_VERSION)
	#mv $(GOPATH)/bin/$(NATS_TOP_BIN_NAME) $(NATS_SRC_BIN_FSPATH)/$(NATS_TOP_BIN_NAME)



### TEMPLATES

_NATS_SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
NATS_SRC_TEMPLATES_FSPATH=$(PWD)/.templates/nats
_NATS_TEMPLATES_SOURCE=$(_NATS_SELF_DIR)/templates/nats
_NATS_TEMPLATES_TARGET=$(NATS_SRC_TEMPLATES_FSPATH)

nats-templates-print:
	@echo ""
	@echo "-- TEMPLATES --"
	@echo "_NATS_SELF_DIR:                   $(_NATS_SELF_DIR)"
	@echo "_NATS_TEMPLATES_SOURCE:           $(_NATS_TEMPLATES_SOURCE)"
	@echo "_NATS_TEMPLATES_TARGET:           $(_NATS_TEMPLATES_TARGET)"
	@echo ""

## installs the nats templates into your project
nats-templates-dep:
	@echo ""
	@echo "installing nats templates to your project...."
	mkdir -p $(_NATS_TEMPLATES_TARGET)
	cp -r $(_NATS_TEMPLATES_SOURCE)/* $(_NATS_TEMPLATES_TARGET)/
	@echo "installed nats templates  at : $(_NATS_TEMPLATES_TARGET)"
nats-templates-dep-del:
	rm -rf $(_NATS_TEMPLATES_TARGET)



### NSC

# --config-dir
# --data-dir
# --keystore-dir

NATS_NSC_CMD=$(NATS_NSC_BIN_NAME) --all-dirs $(NATS_SRC_NSC_DATA_FSPATH) 

## nats mkcert installs the certs for browsers to run localhost


nats-nsc-init:
	$(NATS_NSC_CMD) init
	# sets an operator: i use gedw99
nats-nsc-init-del:
	rm -rf $(NATS_SRC_NSC_DATA_FSPATH) 

nats-nsc-update:
	$(NATS_NSC_CMD) update --interactive

nats-nsc-gen:
	#$(NATS_NSC_CMD) generate activation -h

	# this generates a nats server config.
	#$(NATS_NSC_CMD) generate config --mem-resolver --config-file <path/server.conf>

	#$(NATS_NSC_CMD) generate creds -h

	$(NATS_NSC_CMD) generate diagram --output-file $(PWD)/nats-nsc-dia-component.uml component
	$(NATS_NSC_CMD) generate diagram --output-file $(PWD)/nats.nsc-dia-object.uml object

nats-nsc-list:
	@echo ""
	@echo "-- operators"
	$(NATS_NSC_CMD) list operators

	@echo ""
	@echo "-- accounts"
	$(NATS_NSC_CMD) list accounts

	@echo ""
	@echo "-- keys"
	$(NATS_NSC_CMD) list keys

	@echo ""
	@echo "-- users"
	$(NATS_NSC_CMD) list users

	@echo ""
	@echo "-- users by accunt or operator"
	$(NATS_NSC_CMD) list users --account gedw99
	$(NATS_NSC_CMD) list users --operator gedw99

nats-nsc-add-operator:
	$(NATS_NSC_CMD) add operator MyOperator

NATS_ACCOUNT_NAME=HR

nats-nsc-list-account:
	$(NATS_NSC_CMD) list accounts
nats-nsc-add-account:
	$(NATS_NSC_CMD) add account --name $(NATS_ACCOUNT_NAME)
nats-nsc-edit-account:
	$(NATS_NSC_CMD) edit account --name $(NATS_ACCOUNT_NAME) --js-mem-storage 1G --js-disk-storage 512M  --js-streams 10 --js-consumer 100
nats-nsc-del-account:
	$(NATS_NSC_CMD) delete account --name $(NATS_ACCOUNT_NAME)
nats-nsc-del-account-all:
	$(NATS_NSC_CMD) delete account -h



### SERVER

## nats run runs nats using your nats Config
nats-server-run:
	# https://docs.nats.io/running-a-nats-service/introduction/running#jetstream
	# Use conf
	$(NATS_SERVER_BIN_NAME) --config $(NATS_SRC_CONFIG)

# nats run with no config
nats-server-default:
	# https://docs.nats.io/running-a-nats-service/introduction/flags
	$(NATS_SERVER_BIN_NAME) -js -sd $(NATS_DEFAULT_DATA_FSPATH)

### MONITORING

nats-mon-open:
	open http://localhost:8222/
nats-mon-test:
	curl http://localhost:8222/varz




