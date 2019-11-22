info "1.1 - API Server"

check_1_1_1="1.1.1  - Ensure that the --anonymous-auth argument is set to false"
aa=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--anonymous-auth=false").string')
if [ "$aa" = \"--anonymous-auth=false\" ]; then
    pass "$check_1_1_1"
else
    warn "$check_1_1_1"
fi

check_1_1_2="1.1.2  - Ensure that the --basic-auth-file argument is not set"
baf=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--basic-auth-file=.*").string')
if [ -z "$baf" ]; then
	pass "$check_1_1_2"
else
	warn "$check_1_1_1"
fi

check_1_1_3="1.1.3  - Ensure that the --insecure-allow-any-token argument is not set"
iaat=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--insecure-allow-any-token").string')
if [ -z "$iaat" ]; then
    pass "$check_1_1_3"
else
    warn "$check_1_1_3"
fi

check_1_1_4="1.1.4  - Ensure that the --kubelet-https argument is set to true"
kh=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--kubelet-https=false").string')
if [ -z "$kh" ]; then
    pass "$check_1_1_4"
else
    warn "$check_1_1_4"
fi

check_1_1_5="1.1.5  - Ensure that the --insecure-bind-address argument is not set"
iba=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--insecure-bind-address=(?:(?!127\\.0\\.0\\.1).)+")')
if [ -z "$iba" ]; then
	pass "$check_1_1_5"
else
        warn "$check_1_1_5"
fi

check_1_1_6="1.1.6  - Ensure that the --insecure-port argument is set to 0"
ip=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--insecure-port=0").string')
if [ "$ip" = \"--insecure-port=0\" ]; then
	pass "$check_1_1_6"
    else
        warn "$check_1_1_6"
fi

check_1_1_7="1.1.7  - Ensure that the --secure-port argument is not set to 0"
sp=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--secure-port=6443").string')
if [ "$sp" = \"--secure-port=0\" ]; then
        warn "$check_1_1_7"
else
        pass "$check_1_1_7"
fi

check_1_1_8="1.1.8  - Ensure that the --profiling argument is set to false"
profiling=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--profiling=false").string')
if [ $profiling = \"--profiling=false\" ]; then
    pass "$check_1_1_8"
else
    warn "$check_1_1_8"
fi

check_1_1_9="1.1.9  - Ensure that the --repair-malformed-updates argument is set to false"
na "$check_1_1_9"
na "		This deprecated flag was removed in 1.14, so it cannot be set."

check_1_1_10="1.1.10  - Ensure that the admission control policy is not set to AlwaysAdmit"
alwaysadmit=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--enable-admission-plugins=.*(AlwaysAdmit).*").captures[].string')
if [ -z "$alwaysadmit" ]; then
    pass "$check_1_1_10"
else
    warn "$check_1_1_10"
fi

check_1_1_11="1.1.11  - Ensure that the admission control policy is set to AlwaysPullImages"
api=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--enable-admission-plugins=.*(AlwaysPullImages).*").captures[].string')
if [ "$api" = \"AlwaysPullImages\" ]; then 
    pass "$check_1_1_11"
else
    warn "$check_1_1_11"
fi

check_1_1_12="1.1.12  - Ensure that the admission control policy is set to DenyEscalatingExec"
dee=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--enable-admission-plugins=.*(DenyEscalatingExec).*").captures[].string')
if [ "$dee" = \"DenyEscalatingExec\"  ]; then
    pass "$check_1_1_12"
else
    warn "$check_1_1_12"
fi

check_1_1_13="1.1.13  - Ensure that the admission control policy is set to SecurityContextDeny"
scd=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--enable-admission-plugins=.*(SecurityContextDeny).*").captures[].string')    
if [ "$scd" = \"SecurityContextDeny\" ]; then
    pass "$check_1_1_13"
    pass "		NOTE This SHOULD NOT be set if you are using a PodSecurityPolicy (PSP)."
else
    warn "$check_1_1_13"
    warn "		NOTE This SHOULD NOT be set if you are using a PodSecurityPolicy (PSP)."
fi

check_1_1_14="1.1.14  - Ensure that the admission control policy is set to NamespaceLifecycle"
nlc=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--enable-admission-plugins=.*(NamespaceLifecycle).*").captures[].string')
if [ "$nlc" = \"NamespaceLifecycle\" ]; then
    pass "$check_1_1_14"
else
    warn "$check_1_1_14"
fi

check_1_1_15="1.1.15  - Ensure that the --audit-log-path argument is set as appropriate"
alp=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--audit-log-path=/var/log/kube-audit/audit-log.json").string')
if [ "alp" = \"--audit-log-log=/var/log/kube-audit/audit-log.json\" ]; then
    pass "$check_1_1_15"
else
    warn "$check_1_1_15"
fi

check_1_1_16="1.1.16  - Ensure that the --audit-log-maxage argument is set to 30 or as appropriate"
alm=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--audit-log-maxage=\\d+").string')
if [  -z "alm" ]; then
    warn "$check_1_1_16"
    warn "      configuration not found"
else
    if [ "$alm" = \"--audit-log-maxage=5\" ]; then
        pass "$check_1_1_16"
    else
        warn "$check_1_1_16"
    fi
fi

check_1_1_17="1.1.17  - Ensure that the --audit-log-maxbackup argument is set to 10 or as appropriate"
almm=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--audit-log-maxbackup=\\d+").string')
if [ -z "$almm" ]; then
    warn "$check_1_1_17"
    warn "      configuration not found"
else
    if [ "$almm" = \"--audit-log-maxbackup=5\" ]; then
        pass "$check_1_1_17"
    else
        warn "$check_1_1_17"
        warn "        * $almm"
    fi
fi

check_1_1_18="1.1.18  - Ensure that the --audit-log-maxsize argument is set to 100 or as appropriate"
almmm=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--audit-log-maxsize=\\d+").string')
if [ -z "$almmm"]; then
    warn "$check_1_1_18"
else
    if [ "almmm" = \"--audit-log-maxsize=100\" ]; then
        pass "$check_1_1_18"
    else
        warn "$check_1_1_18"
        warn "        * $almmm"
    fi
fi

check_1_1_19="1.1.19  - Ensure that the --authorization-mode argument is not set to AlwaysAllow"
am=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--authorization-mode=(Node|RBAC|,)+").string')
if [ "$am" = \"--authorization-mode=Node,RBAC\" ]; then
    pass "$check_1_1_19"
else
    warn "$check_1_1_19"
    warn "      * $am"
fi

check_1_1_20="1.1.20  - Ensure that the --token-auth-file parameter is not set"
taf=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--token-auth-file=.*").string')
if [ -z "$taf" ]; then
    pass "$check_1_1_20"
else
    warn "$check_1_1_20"
fi

check_1_1_21="1.1.21  - Ensure that the --kubelet-certificate-authority argument is set as appropriate"
warn "$check_1_1_21"
warn "Make sure nodes with role:controlplane are on the same local network as your nodes with role:worker. Use network ACLs to restrict connections to the kubelet port (10250/tcp) on worker nodes, only permitting it from controlplane nodes."

check_1_1_22="1.1.22  - Ensure that the --kubelet-client-certificate and --kubelet-client-key arguments are set as appropriate"
kcc=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--kubelet-client-certificate=.*").string')
kck=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--kubelet-client-key=.*").string')
if [ "$kcc" = \"--kubelet-client-certificate=/etc/kubernetes/ssl/kube-apiserver.pem\" ]; then
    if [ "$kck" = \"--kubelet-client-key=/etc/kubernetes/ssl/kube-apiserver-key.pem\" ]; then
        pass "$check_1_1_22"
    else
        warn "$check_1_1_22"
    fi
else
    warn "$check_1_1_22"
fi

check_1_1_23="1.1.23  - Ensure that the --service-account-lookup argument is set to true"
scl=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--service-account-lookup=true").string')
if [ "$scl" = \"--service-account-lookup=true\" ]; then
    pass "$check_1_1_23"
else
    warn "$check_1_1_23"
fi

check_1_1_24="1.1.24  - Ensure that the admission control policy is set to PodSecurityPolicy"
psp=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--enable-admission-plugins=.*(PodSecurityPolicy).*").captures[].string')
if [ "$psp" = \"PodSecurityPolicy\" ]; then
    pass "$check_1_1_24"
else
    warn "$check_1_1_24"
fi

check_1_1_25="1.1.25  - Ensure that the --service-account-key-file argument is set as appropriate"
sakf=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--service-account-key-file=.*").string')
if [ "$sakf" = \"--service-account-key-file=/etc/kubernetes/ssl/kube-service-account-token-key.pem\" ]; then
    pass "$check_1_1_25"
else
    warn "$check_1_1_25"
fi

check_1_1_26="1.1.26  - Ensure that the --etcd-certfile and --etcd-keyfile arguments are set as appropriate"
ec=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--etcd-certfile=.*").string')
ek=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--etcd-keyfile=.*").string')
if [ "$ec" = \"--etcd-certfile=/etc/kubernetes/ssl/kube-node.pem\" ]; then
    if [ "$ek" = \"--etcd-keyfile=/etc/kubernetes/ssl/kube-node-key.pem\" ]; then
        pass "$check_1_1_26"
    else
        warn "$check_1_1_26"
    fi
else
    warn "$check_1_1_26"
fi

check_1_1_27="1.1.27  - Ensure that the admission control policy is set to ServiceAccount"
sa=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--enable-admission-plugins=.*(ServiceAccount).*").captures[].string')
if [ "$sa" = \"ServiceAccount\" ]; then
    pass "$check_1_1_27"
else
    warn "$check_1_1_27"
fi

check_1_1_28="1.1.28  - Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate"
tlf=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--tls-cert-file=.*").string')
tpf=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--tls-private-key-file=.*").string')
if [ "$tlf" = \"--tls-cert-file=/etc/kubernetes/ssl/kube-apiserver.pem\" ]; then
    if [ "$tpf" = \"--tls-private-key-file=/etc/kubernetes/ssl/kube-apiserver-key.pem\" ]; then
        pass "$check_1_1_28"
    else
        warn "$check_1_1_28"
    fi
else
    warn "$check_1_1_28"
fi

check_1_1_29="1.1.29  - Ensure that the --client-ca-file argument is set as appropriate"
ccf=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--client-ca-file=.*").string')
if [ "$ccf" = \"--client-ca-file=/etc/kubernetes/ssl/kube-ca.pem\" ]; then
    pass "$check_1_1_29"
else
    warn "$check_1_1_29"
fi

check_1_1_30="1.1.30  - Ensure that the API Server only makes use of Strong Cryptographic Ciphers"
aa=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--tls-cipher-suites=.*(TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256).*").captures[].string')
bb=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--tls-cipher-suites=.*(TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256).*").captures[].string')
cc=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--tls-cipher-suites=.*(TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305).*").captures[].string')
dd=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--tls-cipher-suites=.*(TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384).*").captures[].string')
ee=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--tls-cipher-suites=.*(TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305).*").captures[].string')
ff=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--tls-cipher-suites=.*(TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384).*").captures[].string')
gg=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--tls-cipher-suites=.*(TLS_RSA_WITH_AES_256_GCM_SHA384).*").captures[].string')
hh=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--tls-cipher-suites=.*(TLS_RSA_WITH_AES_128_GCM_SHA256).*").captures[].string')
ii=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--tls-cipher-suites=.*(CBC).*").captures[].string')
jj=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--tls-cipher-suites=.*(RC4).*").captures[].string')
count_check=0
if [ "$aa" != "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256" ]; then
        count_check=$(( count_check + 1 ))
	warn "$aa not found"
fi
if [ "$bb" != "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256" ]; then
        count_check=$(( count_check + 1 ))
	warn "$bb not found"
fi
if [ "$cc" = "TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305" ]; then
        count_check=$(( count_check + 1 ))
	warn "$cc not found"
fi
if [ "$dd" = "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384" ]; then
        count_check=$(( count_check + 1 ))
	warn "$dd not found"
fi
if [ "$ee" = "TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305" ]; then
        count_check=$(( count_check + 1 ))
	warn "$ee not found"
fi
if [ "$ff" = "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384" ]; then
        count_check=$(( count_check + 1 ))
	warn "$ff not found"
fi
if [ "$gg" = "TLS_RSA_WITH_AES_256_GCM_SHA384" ]; then
        count_check=$(( count_check + 1 ))
	warn "gg not found"
fi
if [ "$hh" = "TLS_RSA_WITH_AES_128_GCM_SHA256" ]; then
        count_check=$(( count_check + 1 ))
	warn "$hh not found"
fi
if [ -z "$ii" ]; then
        sleep 1
else
        count_check=$(( count_check + 1 ))
	warn "$ii is allowed"
fi
if [ -z "$jj" ]; then
        sleep 1
else
        count_check=$(( count_check + 1 ))
	warn "$jj is allowed"
fi
if [ "$count_check" -ge 1 ];then
        warn "$check_1_1_30"
else
        pass "$check_1_1_30"
fi

check_1_1_31="1.1.31  - Ensure that the --etcd-cafile argument is set as appropriate"
ec=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--etcd-cafile=.*").string')
if [ "$ec" = \"--etcd-cafile=/etc/kubernetes/ssl/kube-ca.pem\" ]; then
    pass "$check_1_1_31"
else
    warn "$check_1_1_31"
fi

check_1_1_32="1.1.32  - Ensure that the --authorization-mode argument is set to Node"
amn=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--authorization-mode=(Node|RBAC|,)+").string')
if [ "$amn" = \"--authorization-mode=Node,RBAC\" ]; then
    pass "$check_1_1_32"
else
    warn "$check_1_1_32"
fi

check_1_1_33="1.1.33  - Ensure that the admission control policy is set to NodeRestriction"
nr=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--enable-admission-plugins=.*(NodeRestriction).*").captures[].string')
if [ "$nr" = \"NodeRestriction\" ]; then
    pass "$check_1_1_33"
else
    warn "$check_1_1_33"
fi

check_1_1_34="1.1.34  - Ensure that the --experimental-encryption-provider-config argument is set as appropriate"
epc=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--encryption-provider-config=.*").string')
if [ "$epc" = \"encryption-provider-config=/opt/kubernetes/encryption.yaml\" ]; then
    pass "$check_1_1_34"
else
    warn "$check_1_1_34"
fi

check_1_1_35="1.1.35  - Ensure that the encryption provider is set to aescbc"
epc=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--encryption-provider-config=.*").string')
if [ -z "$epc" ]; then
	warn "$check_1_1_35"
	warn "		encryption is not configured"
else
	ep=$(grep -A 1 providers: /opt/kubernetes/encryption.yaml | grep aescbc)
	if [ "$ep" = \"- aescbc:\" ]; then
    		pass "$check_1_1_35"
	else
    		warn "$check_1_1_35"
	fi
fi

check_1_1_36="1.1.36  - Ensure that the admission control policy is set to EventRateLimit"
erl=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--enable-admission-plugins=.*(EventRateLimit).*").captures[].string')
erlc=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--admission-control-config-file=.*").string')
if [ "$erl" = \"EventRateLimit\" ]; then
    if [ "$erlc" = \"--admission-control-config-file=/opt/kubernetes/admission.yaml\" ]; then
        pass "$check_1_1_36"
    else
        warn "$check_1_1_36"
    fi
else
    warn "$check_1_1_36"
fi

check_1_1_37="1.1.37  - Ensure that the AdvancedAuditing argument is not set to false"
aaa=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--feature-gates=.*(AdvancedAuditing=false).*").captures[].string')
apf=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--audit-policy-file=.*").string')
if [ -z "$aaa" ]; then
    if [ "$apf" = \"--audit-policy-file=/opt/kubernetes/audit.yaml\" ]; then
        pass "$check_1_1_37"
    else
        warn "$check_1_1_37"
    fi
else
    warn "$check_1_1_37"
fi

check_1_1_38="1.1.38  - Ensure that the --request-timeout argument is set as appropriate"
rt=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--request-timeout=.*").string')
am=$(docker inspect kube-apiserver | jq -e '.[0].Args[] | match("--authorization-mode=.*").string')
if [ -z "$rt" ]; then
    if [ "$am" = \"--authorization-mode=Node,RBAC\" ]; then
        pass "$check_1_1_38"
    else
        warn "$check_1_1_38"
    fi
else
    warn "$check_1_1_38"
fi
