# github workflows

Uses the file path to determine actions.

Windows, Mac and Linux.

Calls Makefiles to do its work

- Precondition are git, make, golang

## references

https://github.com/actions/starter-workflows

## actions we use

makefiles:

git: https://github.com/marketplace/actions/gittools

golang:

docker: https://github.com/marketplace/actions/build-and-push-docker-images for docker push to githubs ghcr.io at https://github.com/features/packages

release: https://github.com/marketplace/actions/automatic-releases to automatically upload assets, generating changelogs, handling pre-releases, and so on


