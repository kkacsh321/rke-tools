# RKE Build Container

## Summary

This repo container the dockerfile for my RKE Build Container. This is a lightweight container based off alpine that contians all the tools needed to provision RKE clusters:
RKE, Helm, Tiller, Kubectl, etc. This container gets used locally, and in CI to make sure all build processes use same environment setup. 

### How to work with the repo

This is a pretty basic repo that contains the Dockerfile, a simple entry script, and the Makefile.
Make your adjustments to the dockerfile and then use the make commands to help build and test your changes.

`make build` = Will build the container for you

`make shell` = Will build the container and then run the container in interactive mode


## Links

- [RKE](https://github.com/rancher/rke)
- [Rancher](http://rancher.com/rancher/)
- [Helm](https://github.com/helm/helm)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
