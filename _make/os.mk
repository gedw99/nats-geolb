# os.mk is reused by other *.mk files

### ASSUMPTIONS ###
# golang, git and make is installed locally
# golang, git and make is installed by CI Github actions 

# testing overrides:
#OS_GO_OS=windows



### ENV

# # from zshrc or os-env.mk
# github
OS_GIT_ENV_GITHUB_NAME=$(OS_ENV_GIT_GITHUB_NAME)
OS_ENV_GIT_GITHUB_NAME=gedw99

OS_GIT_ENV_GITHUB_TOKEN=$(OS_ENV_GIT_GITHUB_TOKEN)
OS_GIT_ENV_GITHUB_TOKEN=$(GITHUB_TOKEN)
#GITHUB_TOKEN=github-token-mk

# git
OS_GIT_ORIGIN_USER:=$(OS_ENV_GIT_ORIGIN_USER)
#OS_GIT_ORIGIN_USER:=gedw99

OS_GIT_ORIGIN_EMAIL:=$(OS_ENV_GIT_ORIGIN_EMAIL)
OS_GIT_ORIGIN_EMAIL:=gedw99@gmail.com

OS_GIT_SSH_USER=$(OS_ENV_GIT_SSH_USER)
OS_GIT_SSH_USER:=~/.ssh/gedw99_github.com.pub

#export GIT_USER_NAME=gedw99
#export GIT_USER_EMAIL=gedw99@gmail.com
#export GIT_USER_SSH_PUB=~/.ssh/gedw99_github.com.pub

# bin
OS_BIN_POLICY=$(OS_ENV_BIN_POLICY)
OS_ENV_BIN_POLICY=local

ifeq ($(OS_BIN_POLICY),global)
	OS_BIN=$(OS_GO_BIN)
endif
ifeq ($(OS_BIN_POLICY),local)
	OS_BIN=$(PWD)/.bin
endif

# TODO
# OS folders such as:
# System level configuration folder
# User level configuration folder
# User wide cache folder
# These are needed to that i place binaries or data in the right locations for all OS's
# github.com/shibukawa/configdir is old but still correct and heavily ued.
# https://github.com/a57772803/GPassword/blob/master/utils/appPath/appPath.go is a decent example
# Its getting to the point that i need this os.mk to be a golang / mage binary tool, that i pull locally and in github CI.




# docker
OS_DOCKER_ENV_REGISTRY=$(OS_ENV_DOCKER_REGISTRY)
OS_ENV_DOCKER_REGISTRY=ghcr.io

OS_DOCKER_ENV_USERNAME=$(OS_ENV_DOCKER_USERNAME)
OS_ENV_DOCKER_USERNAME=gedw99

OS_DOCKER_ENV_APPLICATION_NAME=$(OS_ENV_DOCKER_APPLICATION_NAME)
OS_ENV_DOCKER_APPLICATION_NAME=hello-world

# MUST be below the overrides above.
-include os.env
export PATH:=$(PATH):$(OS_BIN)


### MAKE

OS_MAKE_BIN_NAME=make
ifeq ($(OS_GO_OS),windows)
	OS_MAKE_BIN_NAME=make.exe
endif
OS_MAKE_BIN_WHICH=$(shell which $(OS_MAKE_BIN_NAME))
OS_MAKE_BIN_WHICH_VERSION=$(MAKE_VERSION)

# GIT
OS_GIT_BIN_NAME=git
ifeq ($(OS_GO_OS),windows)
	OS_GIT_BIN_NAME=git.exe
endif
# assumes git is installed
OS_GIT_BIN_WHICH=$(shell which $(OS_GIT_BIN_NAME))
OS_GIT_BIN_WHICH_VERSION=$(shell $(OS_GIT_BIN_NAME) -v)
# assumes ypu have this on your shell...

OS_GIT_HASH ?= $(shell $(OS_GIT_BIN_NAME) log --format="%h" -n 1)

# GO
OS_GO_BIN_NAME=go
#OS_GO_BIN_NAME=gotip
ifeq ($(OS_GO_OS),windows)
	OS_GO_BIN_NAME=go.exe
endif

OS_GO_OS=$(shell $(OS_GO_BIN_NAME) env GOOS)
OS_GO_VERSION=$(shell $(OS_GO_BIN_NAME) env GOVERSION)
OS_GO_ARCH=$(shell $(OS_GO_BIN_NAME) env GOARCH)
OS_GO_PATH=$(shell $(OS_GO_BIN_NAME) env GOPATH)
OS_GO_TOOLDIR=$(shell $(OS_GO_BIN_NAME) env GOTOOLDIR)
OS_GO_BIN=$(OS_GO_PATH)/bin
ifeq ($(OS_GO_OS),windows)
	OS_GO_BIN=$(OS_GO_PATH)\bin
endif

# DOCKER
OS_DOCKER_BIN_NAME=docker
ifeq ($(OS_GO_OS),windows)
	OS_DOCKER_BIN_NAME=docker.exe
endif
OS_DOCKER_SRC_FSPATH=$(PWD)
OS_DOCKER_SRC_DOCKERFILE="$(OS_DOCKER_SRC_FSPATH)/Dockerfile"

# computed vars for docker from the src passed in.
OS_DOCKER_VAR_CONTAINER_NAME=$(OS_DOCKER_ENV_USERNAME)__$(OS_DOCKER_ENV_APPLICATION_NAME)
OS_DOCKER_VAR_IMAGE_NAME=$(OS_DOCKER_ENV_USERNAME)/$(OS_DOCKER_ENV_APPLICATION_NAME)
OS_DOCKER_VAR_IMAGE_NAME_TAGGED=$(OS_DOCKER_VAR_IMAGE_NAME):$(OS_GIT_HASH)


# GO-GETTER
# https://github.com/hashicorp/go-getter
# we use this to download from anywhere we need to for booting up bins.
# for example, we might need certain things from github, s3 or anywhere.
OS_GETTER_BIN_NAME=go-getter
ifeq ($(OS_GO_OS),windows)
	OS_GETTER_BIN_NAME=go-getter.exe
endif
OS_GETTER_BIN_VERSION=v1.7.3
OS_GETTER_BIN_WHICH=$(shell which $(OS_GETTER_BIN_NAME))
#OS_GETTER_BIN_WHICH_VERSION=$(shell $(OS_GETTER_BIN_NAME) version)



os-print:
	@echo ""
	@echo "-- OS --"
	@echo ""
	@echo "--- MAKE ---"
	@echo "OS_MAKE_BIN_NAME:                     $(OS_MAKE_BIN_NAME)"
	@echo "OS_MAKE_BIN_WHICH:                    $(OS_MAKE_BIN_WHICH)"
	@echo "OS_MAKE_BIN_WHICH_VERSION:            $(OS_MAKE_BIN_WHICH_VERSION)"
	@echo ""
	@echo ""
	@echo "--- GIT ---"
	@echo "OS_GIT_BIN_NAME:                      $(OS_GIT_BIN_NAME)"
	@echo "OS_GIT_BIN_WHICH:                     $(OS_GIT_BIN_WHICH)"
	@echo "OS_GIT_BIN_WHICH_VERSION:             $(OS_GIT_BIN_WHICH_VERSION)"
	@echo ""
	@echo "---- env ----"
	@echo "OS_GIT_ENV_GITHUB_NAME:               $(OS_GIT_ENV_GITHUB_NAME)"
	@echo "OS_GIT_ENV_GITHUB_TOKEN:              $(OS_GIT_ENV_GITHUB_TOKEN)"
	@echo ""
	@echo "---- vars ----"
	@echo "OS_GIT_HASH:                          $(OS_GIT_HASH)"
	@echo ""
	@echo ""
	@echo "--- GO ---"
	@echo "OS_GO_BIN_NAME:                       $(OS_GO_BIN_NAME)"
	@echo "OS_GO_VERSION:                        $(OS_GO_VERSION)"
	@echo "OS_GO_OS:                             $(OS_GO_OS)"
	@echo "OS_GO_ARCH:                           $(OS_GO_ARCH)"
	@echo "OS_GO_PATH:                           $(OS_GO_PATH)"
	@echo "OS_GO_TOOLDIR:                        $(OS_GO_TOOLDIR)"
	@echo "OS_GO_BIN:                            $(OS_GO_BIN)"
	@echo ""
	@echo ""
	@echo "--- DOCKER ---"
	@echo "OS_DOCKER_BIN_NAME:                   $(OS_DOCKER_BIN_NAME)"
	@echo "OS_DOCKER_SRC_FSPATH:                 $(OS_DOCKER_SRC_FSPATH)"
	@echo "OS_DOCKER_SRC_DOCKERFILE:             $(OS_DOCKER_SRC_DOCKERFILE)"
	@echo ""
	@echo "---- env ----"
	@echo "OS_DOCKER_ENV_REGISTRY:               $(OS_DOCKER_ENV_REGISTRY)"
	@echo "OS_DOCKER_ENV_USERNAME:               $(OS_DOCKER_ENV_USERNAME)"
	@echo "OS_DOCKER_ENV_APPLICATION_NAME:       $(OS_DOCKER_ENV_APPLICATION_NAME)"
	@echo ""
	@echo "---- vars ----"
	@echo "OS_DOCKER_VAR_CONTAINER_NAME:         $(OS_DOCKER_VAR_CONTAINER_NAME)"
	@echo "OS_DOCKER_VAR_IMAGE_NAME:             $(OS_DOCKER_VAR_IMAGE_NAME)"
	@echo "OS_DOCKER_VAR_IMAGE_NAME_TAGGED:      $(OS_DOCKER_VAR_IMAGE_NAME_TAGGED)"
	@echo ""
	@echo "--- ENV ---"
	@echo "OS_BIN_POLICY:                        $(OS_BIN_POLICY)"
	@echo "OS_BIN:                               $(OS_BIN)"
	@echo ""
	@echo "---- GETTER ----"
	@echo "OS_GETTER_BIN_NAME:                   $(OS_GETTER_BIN_NAME)"
	@echo "OS_GETTER_BIN_VERSION:                $(OS_GETTER_BIN_VERSION)"
	@echo "OS_GETTER_BIN_WHICH:                  $(OS_GETTER_BIN_WHICH)"
	#@echo "OS_GETTER_BIN_WHICH_VERSION:         $(OS_GETTER_BIN_WHICH_VERSION)"
	@echo ""



os-bin:
	mkdir -p $(OS_BIN)
os-bin-del:
	# kill all the junk
	rm -rf $(OS_BIN)
	# make the path again just in case.
	mkdir -p $(OS_BIN)
os-dep: os-bin
	# go-getter
	go install github.com/hashicorp/go-getter/cmd/go-getter@$(OS_GETTER_BIN_VERSION)
	mv $(OS_GO_BIN)/$(OS_GETTER_BIN_NAME) $(OS_BIN)/$(OS_GETTER_BIN_NAME)
os-dep-del:
	rm -f $(OS_BIN)/$(OS_GETTER_BIN_NAME)


### CLEAN OS 
os-clean: os-clean-go

os-clean-go:
	# clear out go modules, caches, etc 
	$(OS_GO_BIN_NAME) clean -x -modcache
	$(OS_GO_BIN_NAME) clean -x -testcache
	$(OS_GO_BIN_NAME) clean -x -cache
	$(OS_GO_BIN_NAME) clean -x -fuzzcache
os-clean-go-ls:

# Installs binaries using go-getter. Used for dev time to get any dependencies we have
os-get:
	@echo ""
	@echo "todo: wrap go-getter "
	$(OS_GETTER_BIN_NAME) 

	# go-getter -progress -mode=file $(MINIO_DOWNLOAD_SERVER_URL_PREFIX)/windows-amd64/minio.exe $(MINIO_BIN_WINDOWS)/minio.exe
	# go-getter -progress -mode=file $(MINIO_DOWNLOAD_CLIENT_URL_PREFIX)/windows-amd64/mc.exe $(MINIO_BIN_WINDOWS)/mc.exe

### DOCKER 

# Installs binaries into side docker, to make it easy with fly.
os-docker-inject:
	@echo ""
	@echo "Copying binary into docker ..."
	# pull out of runnign docker compose ...
	# push binary into docker ...
	@echo ""

# https://earthly.dev/blog/docker-and-makefiles/

os-docker-clean:
	# clear out all docker images and containers
	@echo ""
	@echo "1: deleting docker containers ... "
	$(OS_DOCKER_BIN_NAME) rmi -f $(shell $(OS_DOCKER_BIN_NAME) images -qa)

	@echo ""
	@echo "2. deleting docker images ... "
	$(OS_DOCKER_BIN_NAME) rm -f $(shell $(OS_DOCKER_BIN_NAME) ps -qa)

	@echo ""
	@echo "3. deleting docker volumes ... "
	$(OS_DOCKER_BIN_NAME) volume rm $(docker volume ls -qf dangling=true)
	
os-docker-clean-system:
	# system level. saves lots of space
	@echo ""
	@echo "1: removing unused docker containers, networks, everything ... "
	docker system prune -f


os-docker-clean-ls:
	@echo ""
	@echo "1. docker images ... "
	$(OS_DOCKER_BIN_NAME) images
	@echo ""
	@echo "2. docker containers ... "
	$(OS_DOCKER_BIN_NAME) ps
	@echo ""
	@echo "3. docker volumes ... "
	$(OS_DOCKER_BIN_NAME) volume ls

os-docker-login:
	# docker login ghcr.io -u <Your-GitHub-username> --password-stdin
	# these ENV variables are in $HOME/.zshrc
	@echo ""
	@echo "Login to GitHub Container Registry ..."
	docker login --username gedw99 --password $(OS_GIT_ENV_GITHUB_TOKEN) $(OS_DOCKER_ENV_REGISTRY)
os-docker-login-actions:
	# Github actions need the same token for it to login too..
	# setup github to build and publish the docker package too.
	# 1. Make a github secret at: https://github.com/gedw99/gio-htmx/settings/secrets/actions
	# NAME:    GH_PAT
	# TOKEN:   $(OS_GIT_ENV_GITHUB_TOKEN)

os-docker-build:
	@echo ""
	@echo "Building with Docker image..."
	cd $(OS_DOCKER_SRC_FSPATH) && $(OS_DOCKER_BIN_NAME) build --tag $(OS_DOCKER_ENV_REGISTRY)/$(OS_DOCKER_VAR_IMAGE_NAME_TAGGED) .
	@echo ""
os-docker-build-del:
	@echo ""
	@echo "Deleting with Docker image..."
	$(OS_DOCKER_BIN_NAME) rmi -f $(OS_DOCKER_VAR_IMAGE_NAME)

os-docker-run: os-docker-login
	@echo ""
	@echo "Running with Docker container ..."
	$(OS_DOCKER_BIN_NAME) run --detach --name=$(OS_DOCKER_VAR_CONTAINER_NAME) $(OS_DOCKER_ENV_REGISTRY)/$(OS_DOCKER_VAR_IMAGE_NAME_TAGGED)
os-docker-run-del:
	@echo ""
	@echo "Deleting with Docker container ..."
	$(OS_DOCKER_BIN_NAME) container stop $(OS_DOCKER_VAR_CONTAINER_NAME)
	$(OS_DOCKER_BIN_NAME) container rm $(OS_DOCKER_VAR_CONTAINER_NAME)

os-docker-exec:
	# not working... 
	# https://docs-stage.docker.com/engine/reference/commandline/container_exec/
	@echo ""
	@echo "Running command inside Docker container ..."
	$(OS_DOCKER_BIN_NAME) container exec -it $(OS_DOCKER_VAR_CONTAINER_NAME) $(OS_DOCKER_VAR_IMAGE_NAME_TAGGED)
	@echo ""

os-docker-tag:
	@echo ""
	@echo "Tagging with Docker ..."
	#$(OS_DOCKER_BIN_NAME) tag $(OS_DOCKER_ENV_REGISTRY)/$(OS_DOCKER_VAR_CONTAINER_NAME) $(OS_DOCKER_VAR_IMAGE_NAME_TAGGED)
	$(OS_DOCKER_BIN_NAME) tag $(OS_DOCKER_VAR_CONTAINER_NAME) $(OS_DOCKER_VAR_IMAGE_NAME)

os-docker-push: os-docker-login
	# https://docs.docker.com/engine/reference/commandline/push/
	@echo ""
	@echo "Pushing with Docker ..."
	# use github, not docker hub
	$(OS_DOCKER_BIN_NAME) push $(OS_DOCKER_ENV_REGISTRY)/$(OS_DOCKER_VAR_IMAGE_NAME_TAGGED)

	@echo "You can find it on github at:"
	@echo https://github.com/users/$(OS_GIT_ENV_GITHUB_NAME)/packages/container/package/$(OS_DOCKER_ENV_APPLICATION_NAME)
	@echo ""

os-docker-pull:
	@echo ""
	@echo "Pulling with Docker ..."
	$(OS_DOCKER_BIN_NAME) pull $(OS_DOCKER_ENV_REGISTRY)/$(OS_DOCKER_VAR_IMAGE_NAME_TAGGED)

# go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
# go install github.com/codingconcepts/pk@latest

os-port-scan:
	# https://github.com/hktalent/scan4all/releases/tag/2.8.7
	go install github.com/hktalent/scan4all@2.6.9
	scan4all --host localhost

	# this checks for ports
	#go install github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
	#naabu --host localhost

	# this checks for vulnerabilities
	# https://github.com/projectdiscovery/nuclei
	go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
	nuclei -update-templates
	nuclei -u https://browse.localhost/

os-port-ls:
	# https://dev.to/smpnjn/how-to-kill-a-process-running-on-a-port-3pdf
	# lsof -i 5000
	lsof -i :$(ARG)
os-port-kill:
	# kill -9 PID
	kill -9 $(ARG)




## Installs go. Used for CI, but not yet. Need to test it.
os-dep-go:

	@echo ""
	@echo "-- Installing go"
	# https://github.com/kevincobain2000/gobrew
	curl -sLk https://raw.githubusercontent.com/kevincobain2000/gobrew/master/git.io.sh | sh

	# Check if go version installed.
	@echo installed $(OS_GO_BIN_NAME) at : $(shell which $(OS_GO_BIN_NAME))
	@echo ""
	# hint to user to setup paths.
	@echo ""
	@echo "You need the following paths:"
	@echo "export PATH="$HOME/.gobrew/current/bin:$HOME/.gobrew/bin:$PATH""
	@echo "export GOROOT="$HOME/.gobrew/current/go""


# What if i want to us gotip ?
# https://pkg.go.dev/golang.org/dl/gotip
# Then in your Makefile override the OS_GO_BIN_NAME=gotip

## Installs gotip. Used for CI but rarely.
os-dep-gotip:
	@echo ""
	@echo "-- Installing gotip ..."
	# MUST have go already installed
	$(OS_GO_BIN_NAME) install golang.org/dl/gotip@$(GO_GOTIP_BIN_VERSION)
	@echo "gotip installed at : $(GO_GOTIP_BIN_WHICH)"
	@echo ""

	gotip download


### GIT

# From os.mk
# env-git
OS_GIT_GITHUB_NAME=$(OS_ENV_GIT_GITHUB_NAME)
OS_GIT_GITHUB_TOKEN=$(OS_GIT_ENV_GITHUB_TOKEN)


# Variables overridable
OS_GIT_REPO_NAME:=?
OS_GIT_REPO_ORG:=gedw99
OS_GIT_REPO_SERVER:=github.com
OS_GIT_REPO_BRANCH:=main

# File Paths overridable
# the path above the git repo. Modify this checkout different branches to different folders
OS_GIT_WORK_FSPATH=$(PWD)
# the path of the final git repo.
OS_GIT_FSPATH=$(OS_GIT_WORK_FSPATH)/$(OS_GIT_REPO_NAME)



# Variables calculated at runtime
OS_GIT_SHA    = $(shell cd $(OS_GIT_FSPATH) && git rev-parse --short HEAD)
OS_GIT_TAG    = $(shell cd $(OS_GIT_FSPATH) && git describe --tags --abbrev=0 --exact-match 2>/dev/null)
OS_GIT_DIRTY  = $(shell cd $(OS_GIT_FSPATH) && test -n "`git status --porcelain`" && echo "dirty" || echo "clean")


## git print
os-git-print:
	@echo
	@echo "--- GIT ---"
	@echo ""
	@echo "---- env ----"
	@echo "OS_GIT_ORIGIN_USER:        $(OS_GIT_ORIGIN_USER)"
	@echo "OS_GIT_ORIGIN_EMAIL:       $(OS_GIT_ORIGIN_EMAIL)"
	@echo "OS_GIT_SSH_USER:           $(OS_GIT_SSH_USER)"
	@echo ""
	@echo "OS_GIT_GITHUB_NAME:        $(OS_GIT_GITHUB_NAME)"
	@echo "OS_GIT_GITHUB_TOKEN:       $(OS_GIT_GITHUB_TOKEN)"
	@echo ""
	@echo "---- server ----"
	@echo "OS_GIT_REPO_NAME:          $(OS_GIT_REPO_NAME)"
	@echo "OS_GIT_REPO_ORG:           $(OS_GIT_REPO_ORG)"
	@echo "OS_GIT_REPO_SERVER:        $(OS_GIT_REPO_SERVER)"
	@echo "OS_GIT_REPO_BRANCH:        $(OS_GIT_REPO_BRANCH)"
	@echo ""
	@echo "---- file path ----"
	@echo "OS_GIT_WORK_FSPATH:        $(OS_GIT_WORK_FSPATH)"
	@echo "OS_GIT_REPO_FSPATH:        $(OS_GIT_FSPATH)"
	@echo ""
	@echo "---- hashes ----"
	@echo "OS_GIT_SHA:                $(OS_GIT_SHA)"
	@echo "OS_GIT_TAG:                $(OS_GIT_TAG)"
	@echo "OS_GIT_DIRTY:              $(OS_GIT_DIRTY)"
	@echo ""

### REPO ###


os-git-commit-sign:
	# sign commits
	# https://docs.github.com/en/authentication/managing-commit-signature-verification/signing-commits
	# git commit -S -m "YOUR_COMMIT_MESSAGE"
os-git-sign-setup:
	# setup repo fro signing
	# https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key
	

os-git-merge:
	# merge origin with our fork


## git clone origin
os-git-clone-origin:
	# works :)
	# assuming you have forked upstream
	mkdir -p $(OS_GIT_WORK_FSPATH)
	cd $(OS_GIT_WORK_FSPATH) && git clone git@$(OS_GIT_SSH_USER):$(OS_GIT_ORIGIN_USER)/$(OS_GIT_REPO_NAME) -b $(OS_GIT_REPO_BRANCH)

	$(MAKE) os-git-clone-origin-post

	$(MAKE) os-git-open-config

## git clone upstream
os-git-clone-upstream:
	mkdir -p $(OS_GIT_WORK_FSPATH)
	cd $(OS_GIT_WORK_FSPATH) && git clone ssh://git@$(OS_GIT_REPO_SERVER) -b $(OS_GIT_REPO_BRANCH)

	$(MAKE) os-git-open-config

## git delete the repro
os-git-delete:
	rm -rf $(OS_GIT_WORK_FSPATH)

# modifies the git config to include the upstream remote and your credentials. Typically used after you have clone your origin.
os-git-clone-origin-post:
	# update the .git/config with upstream info so you can easily sync upstream
	#cd $(PWD)/$(OS_GIT_REPO_NAME) && git remote add upstream ssh://git@github.com:$(OS_GIT_REPO_ORG)/$(OS_GIT_REPO_NAME).git 
	cd $(OS_GIT_FSPATH) && git remote add upstream git@github.com:$(OS_GIT_REPO_ORG)/$(OS_GIT_REPO_NAME).git 
	# update user and user email
	cd $(OS_GIT_FSPATH) && git config user.name $(OS_GIT_ORIGIN_USER)
	cd $(OS_GIT_FSPATH) && git config user.email $(OS_GIT_ORIGIN_EMAIL)

## git open config, so you can check the git config.
os-git-open-config:
	code $(OS_GIT_FSPATH)/.git/config




## git status, to see what has changed.
os-git-status-print:
	@echo
	@echo -- GIT BRANCH:
	@cd $(OS_GIT_FSPATH) && git branch --show-current
	@echo

	@echo
	@echo -- GIT REMOTES:
	@cd $(OS_GIT_FSPATH) && git remote -v
	@echo

	@echo
	@echo --- GIT STATUS:
	cd $(OS_GIT_FSPATH) && git status
	@echo

	


### OPERATIONS ###

## git pull from upstream, to get changes others have made.
os-git-pull-upstream:
	cd $(OS_GIT_FSPATH) && git fetch upstream

	cd $(OS_GIT_FSPATH) && git merge upstream/$(OS_GIT_REPO_BRANCH)

## git add changes, to stage all changes.
os-git-add:
	cd $(OS_GIT_FSPATH) && git add -A 
	cd $(OS_GIT_FSPATH) && git status

## git commit changes, to commit all staged changes.
OS_GIT_COMMENT=?
os-git-commmit:
	cd $(OS_GIT_FSPATH) && git commit -m '$(OS_GIT_COMMENT)'
	cd $(OS_GIT_FSPATH) && git status

## git push PR to origin, to push your committed changes.
os-git-push-origin:
	cd $(OS_GIT_FSPATH) && git push origin $(OS_GIT_REPO_BRANCH)


