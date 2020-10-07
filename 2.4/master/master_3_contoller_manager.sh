info "1.3 - Controller Manager"

check_1_3_1="1.3.1  - Ensure that the --terminated-pod-gc-threshold argument is set as appropriate"
tpgt=$(docker inspect kube-controller-manager | jq -e '.[0].Args[] | match("--terminated-pod-gc-threshold=\\d+").string')
if [ "$tpgt" = \"--terminated-pod-gc-threshold=1000\" ]; then
    pass "$check_1_3_1"
    pass "       * terminated-pod-gc-threshold: $tpgt"
else
    warn "$check_1_3_1"
fi

check_1_3_2="1.3.2  - Ensure that the --profiling argument is set to false"
profiling3=$(docker inspect kube-controller-manager | jq -e '.[0].Args[] | match("--profiling=false").string')
if [ "$profiling" = \"--profiling=false\" ]; then
    pass "$check_1_3_2"
else
    warn "$check_1_3_2"
fi

check_1_3_3="1.3.3  - Ensure that the --use-service-account-credentials argument is set to true"
usac=$(docker inspect kube-controller-manager | jq -e '.[0].Args[] | match("--use-service-account-credentials=true").string')
if [ "$usac" = \"--use-service-account-credentials=true\" ]; then
    pass "$check_1_3_3"
else
    warn "$check_1_3_3"
fi

check_1_3_4="1.3.4  - Ensure that the --service-account-private-key-file argument is set as appropriate"
sapkf=$(docker inspect kube-controller-manager | jq -e '.[0].Args[] | match("--service-account-private-key-file=.*").string')
if [ "$sapkf" = \"--service-account-private-key-file=/etc/kubernetes/ssl/kube-service-account-token-key.pem\" ]; then
    pass "$check_1_3_4"
else
    warn "$check_1_3_4"
fi

check_1_3_5="1.3.5  - Ensure that the --root-ca-file argument is set as appropriate"
rcf=$(docker inspect kube-controller-manager | jq -e '.[0].Args[] | match("--root-ca-file=.*").string')
if [ "$rcf" = \"--root-ca-file=/etc/kubernetes/ssl/kube-ca.pem\" ]; then
    pass "$check_1_3_5"
else
    warn "$check_1_3_5"
fi

check_1_3_6="1.3.6  - Ensure that the RotateKubeletServerCertificate argument is set to true "
rksc=$(docker inspect kube-controller-manager | jq -e '.[0].Args[] | match("--feature-gates=.*(RotateKubeletServerCertificate=true).*").captures[].string')
if [ "$rksc" = \"RotateKubeletServerCertificate=true\" ]; then
    pass "$check_1_3_6"
else
    warn "$check_1_3_6"
fi

check_1_3_7="1.3.7  - Ensure that the --address argument is set to 127.0.0.1"
address3=$(docker inspect kube-controller-manager | jq -e '.[0].Args[] | match("--address=127\\.0\\.0\\.1").string')
if [ "$address3" = \"--address=127.0.0.1\" ]; then
  	pass "$check_1_3_7"
else
  	warn "$check_1_3_7"
fi
