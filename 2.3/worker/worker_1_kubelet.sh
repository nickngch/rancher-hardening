info "2.1 - Kubelet"

check_2_1_1="2.1.1  - Ensure that the --anonymous-auth argument is set to false"
#if check_argument "$CIS_KUBELET_CMD" '--anonymous-auth=false' >/dev/null 2>&1; then
anonymous=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--anonymous-auth=false").string')
if [ $anonymous = \"--anonymous-auth=false\" ]; then
  pass "$check_2_1_1"
else
  warn "$check_2_1_1"
fi

check_2_1_2="2.1.2  - Ensure that the --authorization-mode argument is not set to AlwaysAllow"
authorization=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--authorization-mode=Webhook").string' | cut -d "=" -f2 | grep AlwaysAllow)
if [ -z $authorization ]; then
  pass "$check_2_1_2"
else
  warn "$check_2_1_2"
fi

check_2_1_3="2.1.3  - Ensure that the --client-ca-file argument is set as appropriate"
#if check_argument "$CIS_KUBELET_CMD" '--client-ca-file' >/dev/null 2>&1; then
cafile=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--client-ca-file=.*").string')
if [ "$cafile" = \"--client-ca-file=/etc/kubernetes/ssl/kube-ca.pem\" ]; then
  pass "$check_2_1_3"
else
  warn "$check_2_1_3"
  pass "       * client-ca-file: $cafile"
fi

check_2_1_4="2.1.4  - Ensure that the --read-only-port argument is set to 0"
port=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--read-only-port=0").string')
if [ $port = \"--read-only-port=0\" ]; then
  pass "$check_2_1_4"
else
  warn "$check_2_1_4"
fi

check_2_1_5="2.1.5  - Ensure that the --streaming-connection-idle-timeout argument is not set to 0"
timeout=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--streaming-connection-idle-timeout=.*").string' | cut -d "\"" -f2 | cut -d "=" -f2)
if [ $timeout = 0m -o  $timeout = 0s -o $timeout = 0 ]; then
  warn "$check_2_1_5"
  warn "       * streaming-connection-idle-timeout: $timeout"
else
  pass "$check_2_1_5"
fi

check_2_1_6="2.1.6  - Ensure that the --protect-kernel-defaults argument is set to true"
pks=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--protect-kernel-defaults=true").string')
if [ "$pks" = \"--protect-kernel-defaults=true\" ]; then
    pass "$check_2_1_6"
else
    warn "$check_2_1_6"
fi

check_2_1_7="2.1.7  - Ensure that the --make-iptables-util-chains argument is set to true"
iptables=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--make-iptables-util-chains=true").string')
if [ $iptables = \"--make-iptables-util-chains=true\" ]; then
    pass "$check_2_1_7"
else
    warn "$check_2_1_7"
fi

check_2_1_8="2.1.8  - Ensure that the --hostname-override argument is not set"
hostname=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--hostname-override=.*").string')
if [ -z "$hostname" ]; then
    pass "$check_2_1_8"
else
    warn "$check_2_1_8"
    warn "This is used by most cloud providers. Not setting this is not practical in most cases."
fi

check_2_1_9="2.1.9  - Ensure that the --event-qps argument is set to 0"
event=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--event-qps=0").string')
  if [ $event = \"--event-qps=0\" ]; then
    pass "$check_2_1_9"
  else
    warn "$check_2_1_9"
    warn "        * event-qps: $event"
  fi

check_2_1_10="2.1.10  - Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate"
tcf=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--tls-cert-file=.*").string')
pkf=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--tls-private-key-file=.*").string')
if [ -z "$tcf" ]; then
  if [ -z "$pkf" ]; then
    pass "$check_2_1_10"
  else
    warn "$check_2_1_10"
    warn "        * tls-cert-file: $tcf"
    warn "        * tls-private-key-file: $pkf"
  fi
else
  warn "$check_2_1_10"
fi

check_2_1_11="2.1.11  - Ensure that the --cadvisor-port argument is set to 0"
cadvisor=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--cadvisor-port=0").string')
if [ -z "$cadvisor" ]; then
  pass "$check_2_1_11"
else
  warn "$check_2_1_11"
  warn "        * cadvisor-port: $cadvisor"
fi

check_2_1_12="2.1.12  Ensure that the --rotate-certificates argument is not set to false"
rotate=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--rotate-certificates=true").string')
if [ -z $rotate ]; then
  pass "$check_2_1_12"
else
  warn "$check_2_1_12"
  warn "       * rotateCertificates: $rotate"
fi

check_2_1_13="2.1.13 Ensure that the RotateKubeletServerCertificate argument is set to true"
rotetekubelet=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--feature-gates=.*(RotateKubeletServerCertificate=true).*").captures[].string')
if [ "$rotatekubelet" = "RotateKubeletServerCertificate=true" ]; then
  pass "$check_2_1_13"
else
  warn "$check_2_1_13"
  warn "       * --feature-gates=RotateKubeletServerCertificate: $rotatekubelet"
fi

check_2_1_14="2.1.14  - Ensure that the Kubelet only makes use of Strong Cryptographic Ciphers"
aa=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--tls-cipher-suites=.*(TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256).*").captures[].string')
bb=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--tls-cipher-suites=.*(TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256).*").captures[].string')
cc=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--tls-cipher-suites=.*(TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305).*").captures[].string')
dd=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--tls-cipher-suites=.*(TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384).*").captures[].string')
ee=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--tls-cipher-suites=.*(TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305).*").captures[].string')
ff=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--tls-cipher-suites=.*(TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384).*").captures[].string')
gg=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--tls-cipher-suites=.*(TLS_RSA_WITH_AES_256_GCM_SHA384).*").captures[].string')
hh=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--tls-cipher-suites=.*(TLS_RSA_WITH_AES_128_GCM_SHA256).*").captures[].string')
ii=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--tls-cipher-suites=.*(CBC).*").captures[].string')
jj=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--tls-cipher-suites=.*(RC4).*").captures[].string')
count_check=0
if [ "$aa" != \"TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256\" ]; then
	count_check=$(( count_check + 1 ))
	warn "2.1.14 - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256 not found"
fi
if [ "$bb" != \"TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256\" ]; then
        count_check=$(( count_check + 1 ))
        warn "2.1.14 - TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 not found"
fi
if [ "$cc" != \"TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305\" ]; then
        count_check=$(( count_check + 1 ))
	warn "2.1.14 - TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305 not found"
fi
if [ "$dd" != \"TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384\" ]; then
        count_check=$(( count_check + 1 ))
	warn "2.1.14 - TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 not found"
fi
if [ "$ee" != \"TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305\" ]; then
        count_check=$(( count_check + 1 ))
	warn "2.1.14 - TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305 not found"
fi
if [ "$ff" != \"TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384\" ]; then
        count_check=$(( count_check + 1 ))
	warn "2.1.14 - TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384 not found"
fi
if [ "$gg" != \"TLS_RSA_WITH_AES_256_GCM_SHA384\" ]; then
        count_check=$(( count_check + 1 ))
	warn "2.1.14 - TLS_RSA_WITH_AES_256_GCM_SHA384 not found"
fi
if [ "$hh" != \"TLS_RSA_WITH_AES_128_GCM_SHA256\" ]; then
        count_check=$(( count_check + 1 ))
	warn "2.1.14 - TLS_RSA_WITH_AES_128_GCM_SHA256 not found"
fi
if [ -z "$ii" ]; then
	sleep 1
else
        count_check=$(( count_check + 1 ))
	warn "2.1.14 - $ii is enabled"
fi
if [ -z "$jj" ]; then
	sleep 1
else
        count_check=$(( count_check + 1 ))
	warn "2.1.14 - $jj is enabled"
fi
if [ "$count_check" -ge 1 ];then
	warn "$check_2_1_14"
else
	pass "$check_2_1_14"
fi
