info "1.5 - etcd"

check_1_5_1="1.5.1  - Ensure that the --cert-file and --key-file arguments are set as appropriate (Scored)"
cf=$(docker inspect etcd | jq -e '.[0].Args[] | match("--cert-file=.*").string')
kf=$(docker inspect etcd | jq -e '.[0].Args[] | match("--key-file=.*").string')
if [ "$cf" = --cert-file=/etc/kubernetes/ssl/*.pem ]; then
    if [ "$kf" = --key-file=/etc/kubernetes/ssl/kube-etcd-172-31-24-134-key.pem ]; then
        pass "$check_1_5_1"
    else
      warn "$check_1_5_1"
    fi
else
    warn "$check_1_5_1"
fi

check_1_5_2="1.5.2  - Ensure that the --client-cert-auth argument is set to true (Scored)"
cca=$(docker inspect etcd | jq -e '.[0].Args[] | match("--client-cert-auth(=true)*").string')
if [ "$cca" = \"--client-cert-auth\" ]; then
    pass "$check_1_5_2"
else
    warn "$check_1_5_2"
fi

check_1_5_3="1.5.3  - Ensure that the --auto-tls argument is not set to true (Scored)"
at=$(docker inspect etcd | jq -e '.[0].Args[] | match("--auto-tls(?:(?!=false).*)").string')
if [ -z "$at" ]; then
    pass "$check_1_5_3"
else
    warn "$check_1_5_3"
fi

check_1_5_4="1.5.4  - Ensure that the --peer-cert-file and --peer-key-file arguments are set as appropriate (Scored)"
pcf=$(docker inspect etcd | jq -e '.[0].Args[] | match("--peer-cert-file=.*").string')
pkf=$(docker inspect etcd | jq -e '.[0].Args[] | match("--peer-key-file=.*").string')
if [ "$pcf" = --peer-cert-file=/etc/kubernetes/ssl/* ]; then
    if [ "$pkf" = --peer-key-file=/etc/kubernetes/ssl/* ]; then
        pass "$check_1_5_4"
    else
        warn "$check_1_5_4"
    fi
else
    warn "$check_1_5_4"
fi

check_1_5_5="1.5.5  - Ensure that the --peer-client-cert-auth argument is set to true (Scored)"
pcc=$(docker inspect etcd | jq -e '.[0].Args[] | match("--peer-client-cert-auth(=true)*").string')
if [ "$pcc" = \"--peer-client-cert-auth\" ]; then
    pass "$check_1_5_5"
else
    warn "$check_1_5_5"
fi

check_1_5_6="1.5.6  - Ensure that the --peer-auto-tls argument is not set to true (Scored)"
pat=$(docker inspect etcd | jq -e '.[0].Args[] | match("--peer-auto-tls(?:(?!=false).*)").string')
if [ -z "$pat" ]; then
    pass "$check_1_5_6"
else
    warn "$check_1_5_6"
fi

check_1_5_7="1.5.7  - Ensure that a unique Certificate Authority is used for etcd (Scored)"
ca=$(docker inspect etcd | jq -e '.[0].Args[] | match("--trusted-ca-file=(?:(?!/etc/kubernetes/ssl/kube-ca.pem).*)").string')
if [ -z "$ca" ]; then
    pass "$check_1_5_7"
else
    warn "$check_1_5_7"
fi
