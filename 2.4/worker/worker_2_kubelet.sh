info "4.2 - Kubelet"

check_4_2_1="4.2.1  - Ensure that the --anonymous-auth argument is set to false"
#if check_argument "$CIS_KUBELET_CMD" '--anonymous-auth=false' >/dev/null 2>&1; then
anonymous=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--anonymous-auth=false").string')
if [ $anonymous = \"--anonymous-auth=false\" ]; then
  pass "$check_4_2_1"
else
  warn "$check_4_2_1"
fi

check_4_2_2="4.2.2  - Ensure that the --authorization-mode argument is not set to AlwaysAllow"
authorization=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--authorization-mode=Webhook").string' | cut -d "=" -f2 | grep AlwaysAllow)
if [ -z $authorization ]; then
  pass "$check_4_2_2"
else
  warn "$check_4_2_2"
fi

check_4_2_3="4.2.3  - Ensure that the --client-ca-file argument is set as appropriate"
#if check_argument "$CIS_KUBELET_CMD" '--client-ca-file' >/dev/null 2>&1; then
cafile=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--client-ca-file=.*").string')
if [ "$cafile" = \"--client-ca-file=/etc/kubernetes/ssl/kube-ca.pem\" ]; then
  pass "$check_4_2_3"
else
  warn "$check_4_2_3"
  pass "       * client-ca-file: $cafile"
fi

check_4_2_4="4.2.4  - Ensure that the --read-only-port argument is set to 0"
port=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--read-only-port=0").string')
if [ $port = \"--read-only-port=0\" ]; then
  pass "$check_4_2_4"
else
  warn "$check_4_2_4"
fi

check_4_2_5="4.2.5  - Ensure that the --streaming-connection-idle-timeout argument is not set to 0"
timeout=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--streaming-connection-idle-timeout=.*").string' | cut -d "\"" -f2 | cut -d "=" -f2)
if [ $timeout = 0m -o  $timeout = 0s -o $timeout = 0 ]; then
  warn "$check_4_2_5"
  warn "       * streaming-connection-idle-timeout: $timeout"
else
  pass "$check_4_2_5"
fi

check_4_2_6="4.2.6  - Ensure that the --protect-kernel-defaults argument is set to true"
pks=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--protect-kernel-defaults=true").string')
if [ "$pks" = \"--protect-kernel-defaults=true\" ]; then
    pass "$check_4_2_6"
else
    warn "$check_4_2_6"
fi

check_4_2_7="4.2.7  - Ensure that the --make-iptables-util-chains argument is set to true"
iptables=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--make-iptables-util-chains=true").string')
if [ $iptables = \"--make-iptables-util-chains=true\" ]; then
    pass "$check_4_2_7"
else
    warn "$check_4_2_7"
fi

check_4_2_10="4.2.10  - Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate"
na "$check_4_2_10"
na "RKE doesn’t require or maintain a configuration file for the kubelet service. All configuration is passed in as arguments at container run time."

check_4_2_11="4.2.11  Ensure that the --rotate-certificates argument is not set to false"
rotate=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--rotate-certificates=true").string')
if [ -z $rotate ]; then
  pass "$check_4_2_11"
else
  warn "$check_4_2_11"
  warn "       * rotateCertificates: $rotate"
fi

check_4_2_12="4.2.12 Ensure that the RotateKubeletServerCertificate argument is set to true"
rotetekubelet=$(docker inspect kubelet | jq -e '.[0].Args[] | match("--feature-gates=.*(RotateKubeletServerCertificate=true).*").captures[].string')
if [ "$rotatekubelet" = "RotateKubeletServerCertificate=true" ]; then
  pass "$check_4_2_12"
else
  warn "$check_4_2_12"
  warn "       * --feature-gates=RotateKubeletServerCertificate: $rotatekubelet"
fi
