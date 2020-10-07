info "1.2 - API Server" 

check_1_2_2="1.2.2  - Ensure that the --basic-auth-file argument is not set"
baf=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--basic-auth-file=.*").string')
if [ -z "$baf" ]; then
	pass "$check_1_2_2"
else
	warn "$check_1_2_2"
fi

check_1_2_3="1.2.3  - Ensure that the --token-auth-file parameter is not set"
taf=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--token-auth-file=.*").string')
if [ -z "$taf" ]; then
    pass "$check_1_2_3"
else
    warn "$check_1_2_3"
fi

check_1_2_4="1.2.4  - Ensure that the --kubelet-https argument is set to true"
kh=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--kubelet-https=false").string')
if [ -z "$kh" ]; then
    pass "$check_1_2_4"
else
    warn "$check_1_2_4"
fi

check_1_2_5="1.2.5  - Ensure that the --kubelet-client-certificate and --kubelet-client-key arguments are set as appropriate"
kcc=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--kubelet-client-certificate=.*").string')
kck=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--kubelet-client-key=.*").string')
if [ "$kcc" = \"--kubelet-client-certificate=/etc/kubernetes/ssl/kube-apiserver.pem\" ]; then
    if [ "$kck" = \"--kubelet-client-key=/etc/kubernetes/ssl/kube-apiserver-key.pem\" ]; then
        pass "$check_1_2_5"
    else
        warn "$check_1_2_5"
    fi
else
    warn "$check_1_2_5"
fi

check_1_2_6="1.2.6  - Ensure that the --kubelet-certificate-authority argument is set as appropriate"
kca=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--kubelet-certificate-authority.*").string')
if [ "$kca" = \"--kubelet-certificate-authority=/etc/kubernetes/ssl/kube-ca.pem\" ]; then
  pass "$check_1_2_6"
else
  warn "$check_1_2_6"
fi

check_1_2_7="1.2.7  - Ensure that the --authorization-mode argument is not set to AlwaysAllow"
am=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--authorization-mode=(Node|RBAC|,)+").string')
if [ "$am" = \"--authorization-mode=Node,RBAC\" ]; then
    pass "$check_1_2_7"
else
    warn "$check_1_2_7"
    warn "      * $am"
fi

check_1_2_8="1.2.8  - Ensure that the --authorization-mode argument is set to Node"
amn=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--authorization-mode=(Node|RBAC|,)+").string')
if [ "$amn" = \"--authorization-mode=Node,RBAC\" ]; then
    pass "$check_1_2_8"
else
    warn "$check_1_2_8"
fi

check_1_2_9="1.2.9  - Ensure that the --authorization-mode argument is set to RBAC"
amn=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--authorization-mode=(Node|RBAC|,)+").string')
if [ "$amn" = \"--authorization-mode=Node,RBAC\" ]; then
    pass "$check_1_2_9"
else
    warn "$check_1_2_9"
fi

check_1_2_11="1.2.11  - Ensure that the admission control policy is not set to AlwaysAdmit"
alwaysadmit=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--enable-admission-plugins=.*(AlwaysAdmit).*").captures[].string')
if [ -z "$alwaysadmit" ]; then
    pass "$check_1_2_11"
else
    warn "$check_1_2_11"
fi

check_1_2_14="1.2.14  - Ensure that the admission control policy is set to ServiceAccount"
sa=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--enable-admission-plugins=.*(ServiceAccount).*").captures[].string')
if [ "$sa" = \"ServiceAccount\" ]; then
    pass "$check_1_2_14"
else
    warn "$check_1_2_14"
fi

check_1_2_15="1.2.15  - Ensure that the admission control plugin NamespaceLifecycle is set"
nlc=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--enable-admission-plugins=.*(NamespaceLifecycle).*").captures[].string')
if [ "$nlc" = \"NamespaceLifecycle\" ]; then
    pass "$check_1_2_15"
else
    warn "$check_1_2_15"
fi

check_1_2_16="1.2.16  - Ensure that the admission control plugin PodSecurityPolicy is set"
psp=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--enable-admission-plugins=.*(PodSecurityPolicy).*").captures[].string')
if [ "$psp" = \"PodSecurityPolicy\" ]; then
    pass "$check_1_2_16"
else
    warn "$check_1_2_16"
fi

check_1_2_17="1.2.17  - Ensure that the admission control plugin NodeRestriction is set"
nr=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--enable-admission-plugins=.*(NodeRestriction).*").captures[].string')
if [ "$nr" = \"NodeRestriction\" ]; then
    pass "$check_1_2_17"
else
    warn "$check_1_2_17"
fi

check_1_2_18="1.2.18  - Ensure that the --insecure-bind-address argument is not set"
iba=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--insecure-bind-address=(?:(?!127\\.0\\.0\\.1).)+")')
if [ -z "$iba" ]; then
	pass "$check_1_2_18"
else
    warn "$check_1_2_18"
fi

check_1_2_19="1.2.19  - Ensure that the --insecure-port argument is set to 0"
ip=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--insecure-port=0").string')
if [ "$ip" = \"--insecure-port=0\" ]; then
	pass "$check_1_2_19"
else
    warn "$check_1_2_19"
fi

check_1_2_20="1.2.20  - Ensure that the --secure-port argument is not set to 0"
sp=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--secure-port=6443").string')
if [ "$sp" = \"--secure-port=0\" ]; then
        warn "$check_1_2_20"
else
        pass "$check_1_2_20"
fi

check_1_2_21="1.2.21  - Ensure that the --profiling argument is set to false"
profiling=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--profiling=false").string')
if [ $profiling = \"--profiling=false\" ]; then
    pass "$check_1_2_21"
else
    warn "$check_1_2_21"
fi

check_1_2_22="1.2.22  - Ensure that the --audit-log-path argument is set as appropriate"
alp=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--audit-log-path=/var/log/kube-audit/audit-log.json").string')
if [ "alp" = \"--audit-log-path=/var/log/kube-audit/audit-log.json\" ]; then
    pass "$check_1_2_22"
else
    warn "$check_1_2_22"
fi

check_1_2_23="1.2.23  - Ensure that the --audit-log-maxage argument is set to 30 or as appropriate"
alm=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--audit-log-maxage=\\d+").string')
if [  -z "alm" ]; then
    warn "$check_1_2_23"
    warn "      configuration not found"
else
    if [ "$alm" = \"--audit-log-maxage=5\" ]; then
        pass "$check_1_2_23"
    else
        warn "$check_1_2_23"
    fi
fi

check_1_2_24="1.2.24  - Ensure that the --audit-log-maxbackup argument is set to 10 or as appropriate"
almm=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--audit-log-maxbackup=\\d+").string')
if [ -z "$almm" ]; then
    warn "$check_1_2_24"
    warn "      configuration not found"
else
    if [ "$almm" = \"--audit-log-maxbackup=5\" ]; then
        pass "$check_1_2_24"
    else
        warn "$check_1_2_24"
        warn "        * $almm"
    fi
fi

check_1_2_25="1.2.25  - Ensure that the --audit-log-maxsize argument is set to 100 or as appropriate"
almmm=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--audit-log-maxsize=\\d+").string')
if [ -z "$almmm" ]; then
    warn "$check_1_2_25"
else
    if [ "almmm" = \"--audit-log-maxsize=100\" ]; then
        pass "$check_1_2_25"
    else
        warn "$check_1_2_25"
        warn "        * $almmm"
    fi
fi

check_1_2_26="1.2.26  - Ensure that the --request-timeout argument is set as appropriate"
rt=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--request-timeout=.*").string')
am=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--authorization-mode=.*").string')
if [ -z "$rt" ]; then
    if [ "$am" = \"--authorization-mode=Node,RBAC\" ]; then
        pass "$check_1_2_26"
    else
        warn "$check_1_2_26"
    fi
else
    warn "$check_1_2_26"
fi

check_1_2_27="1.2.27  - Ensure that the --service-account-lookup argument is set to true"
scl=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--service-account-lookup=true").string')
if [ "$scl" = \"--service-account-lookup=true\" ]; then
    pass "$check_1_2_27"
else
    warn "$check_1_2_27"
fi

check_1_2_28="1.2.28  - Ensure that the --service-account-key-file argument is set as appropriate"
sakf=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--service-account-key-file=.*").string')
if [ "$sakf" = \"--service-account-key-file=/etc/kubernetes/ssl/kube-service-account-token-key.pem\" ]; then
    pass "$check_1_2_28"
else
    warn "$check_1_2_28"
fi

check_1_2_29="1.2.29  - Ensure that the --etcd-certfile and --etcd-keyfile arguments are set as appropriate"
ec=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--etcd-certfile=.*").string')
ek=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--etcd-keyfile=.*").string')
if [ "$ec" = \"--etcd-certfile=/etc/kubernetes/ssl/kube-node.pem\" ]; then
    if [ "$ek" = \"--etcd-keyfile=/etc/kubernetes/ssl/kube-node-key.pem\" ]; then
        pass "$check_1_2_29"
    else
        warn "$check_1_2_29"
    fi
else
    warn "$check_1_2_29"
fi

check_1_2_30="1.2.30  - Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate"
tlf=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--tls-cert-file=.*").string')
tpf=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--tls-private-key-file=.*").string')
if [ "$tlf" = \"--tls-cert-file=/etc/kubernetes/ssl/kube-apiserver.pem\" ]; then
    if [ "$tpf" = \"--tls-private-key-file=/etc/kubernetes/ssl/kube-apiserver-key.pem\" ]; then
        pass "$check_1_2_30"
    else
        warn "$check_1_2_30"
    fi
else
    warn "$check_1_2_30"
fi

check_1_2_31="1.2.31  - Ensure that the --client-ca-file argument is set as appropriate"
ccf=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--client-ca-file=.*").string')
if [ "$ccf" = \"--client-ca-file=/etc/kubernetes/ssl/kube-ca.pem\" ]; then
    pass "$check_1_2_31"
else
    warn "$check_1_2_31"
fi

check_1_2_32="1.2.32  - Ensure that the --etcd-cafile argument is set as appropriate"
ec=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--etcd-cafile=.*").string')
if [ "$ec" = \"--etcd-cafile=/etc/kubernetes/ssl/kube-ca.pem\" ]; then
    pass "$check_1_2_32"
else
    warn "$check_1_2_32"
fi

check_1_2_33="1.2.33  - Ensure that the --encryption-provider-config argument is set as appropriate"
epc=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--encryption-provider-config=.*").string')
if [ -z "$epc" ]; then
    warn "$check_1_2_33"
else
    pass "$check_1_2_33"
fi

check_1_2_34="1.2.34  - Ensure that encryption providers are appropriately configured"
epc=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--encryption-provider-config=.*").string')
if [ -z "$epc" ]; then
    warn "$check_1_2_34"
    warn "      encryption is not configured"
else
    config=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--encryption-provider-config=.*").string' | sed -e 's/^"//' -e 's/"$//' | cut -d = -f2)
    provider=$(grep -A 1 providers: $provider | grep aescbc\|kms\|secretbox)
    if [ -z "$provider" ]; then
            warn "$check_1_2_34"
    else
            pass "$check_1_2_34"
    fi
fi
