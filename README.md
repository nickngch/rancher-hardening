# Rancher Hardening Benchmark Scanning Script

## rancher-harden
This script is to performance hardening benchmark scanning against Rancher v2.3.x  (k8s v1.15) cluster based on https://rancher.com/docs/rancher/v2.x/en/security/hardening-2.3/

## Pre-requisites:
- jq
- grep
- awk
- kubectl

## Usage
1. git clone https://github.com/nickngch/rancher-hardening.git
2. cd rancher-hardening
3. Execute the script based on the node's role
### For Master Node
Control plane
- sudo bash ./master.sh 2.3 cp

Control plan + ETCD
- sudo bash ./master.sh 2.3 all

### For Worker Node
- sudo ./worker.sh 2.3

### Limitation
- Section 1.6 and 1.7 in master node require manual verification.

#### Modified from https://github.com/neuvector/kubernetes-cis-benchmark
