info "2 - Etcd Node Configuration Files"

check_2_1="2.1  - Ensure that the --cert-file and --key-file arguments are set as appropriate (Scored)"
cf=$(docker inspect etcd | jq -e '.[0].Args[] | match("--cert-file=.*").string')
kf=$(docker inspect etcd | jq -e '.[0].Args[] | match("--key-file=.*").string')
if [ -z "$cf" ]; then
    warn "$check_2_1"
elif [ -z "$kf" ]; then
    warn "$check_2_1"
else
    pass "$check_2_1"
fi

check_2_2="2.2  - Ensure that the --client-cert-auth argument is set to true (Scored)"
cca=$(docker inspect etcd | jq -e '.[0].Args[] | match("--client-cert-auth(=true)*").string')
if [ "$cca" = \"--client-cert-auth\" ]; then
    pass "$check_2_2"
else
    warn "$check_2_2"
fi

check_2_3="2.3  - Ensure that the --auto-tls argument is not set to true (Scored)"
at=$(docker inspect etcd | jq -e '.[0].Args[] | match("--auto-tls(?:(?!=false).*)").string')
if [ -z "$at" ]; then
    pass "$check_2_3"
else
    warn "$check_2_3"
fi

check_2_4="2.4  - Ensure that the --peer-cert-file and --peer-key-file arguments are set as appropriate (Scored)"
pcf=$(docker inspect etcd | jq -e '.[0].Args[] | match("--peer-cert-file=.*").string')
pkf=$(docker inspect etcd | jq -e '.[0].Args[] | match("--peer-key-file=.*").string')
if [ -z "$pcf" ]; then
    warn "$check_2_4"
elif [ -z "$pkf" ]; then
    warn "$check_2_4"
else
    pass "$check_2_4"
fi

check_2_5="2.5  - Ensure that the --peer-client-cert-auth argument is set to true (Scored)"
pcc=$(docker inspect etcd | jq -e '.[0].Args[] | match("--peer-client-cert-auth(=true)*").string')
if [ "$pcc" = \"--peer-client-cert-auth\" ]; then
    pass "$check_2_5"
else
    warn "$check_2_5"
fi

check_2_6="2.6  - Ensure that the --peer-auto-tls argument is not set to true (Scored)"
pat=$(docker inspect etcd | jq -e '.[0].Args[] | match("--peer-auto-tls(?:(?!=false).*)").string')
if [ -z "$pat" ]; then
    pass "$check_2_6"
else
    warn "$check_2_6"
fi
