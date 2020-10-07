info "1.1 - Master Configuration Files"

check_1_1_1="1.1.1  - Ensure that the API server pod specification file permissions are set to 644 or more restrictive"
na "$check_1_1_1"
na "    RKE doesn’t require or maintain a configuration file for kube-apiserver. All configuration is passed in as arguments at container run time."

check_1_1_2="1.1.2  - Ensure that the API server pod specification file ownership is set to root:root"
na "$check_1_1_2"
na "    RKE doesn’t require or maintain a configuration file for kube-apiserver. All configuration is passed in as arguments at container run time."

check_1_1_3="1.1.3  - Ensure that the controller manager pod specification file permissions are set to 644 or more restrictive"
na "$check_1_1_3"
na "    RKE doesn’t require or maintain a configuration file for kube-apiserver. All configuration is passed in as arguments at container run time."

check_1_1_4="1.1.4  - Ensure that the controller manager pod specification file ownership is set to root:root"
na "$check_1_1_4"
na "    RKE doesn’t require or maintain a configuration file for kube-apiserver. All configuration is passed in as arguments at container run time."

check_1_1_5="1.1.5  - Ensure that the scheduler pod specification file permissions are set to 644 or more restrictive"
na "$check_1_1_5"
na "    RKE doesn’t require or maintain a configuration file for kube-apiserver. All configuration is passed in as arguments at container run time."

check_1_1_6="1.1.6  - Ensure that the scheduler pod specification file ownership is set to root:root"
na "$check_1_1_6"
na "    RKE doesn’t require or maintain a configuration file for kube-apiserver. All configuration is passed in as arguments at container run time."

check_1_1_7="1.1.7  - Ensure that the etcd pod specification file permissions are set to 644 or more restrictive"
na "$check_1_1_7"
na "    RKE doesn’t require or maintain a configuration file for kube-apiserver. All configuration is passed in as arguments at container run time."

check_1_1_8="1.1.8  - Ensure that the etcd pod specification file ownership is set to root:root"
na "$check_1_1_8"
na "    RKE doesn’t require or maintain a configuration file for kube-apiserver. All configuration is passed in as arguments at container run time."

check_1_1_11="1.1.11  - Ensure that the etcd data directory permissions are set to 700 or more restrictive"
#etcd="/var/lib/rancher/etcd/"
etcd=$(stat -c "%n - %a" /var/lib/etcd | cut -d " " -f3)
if [ "$etcd" -eq 700 ]; then
    pass "$check_1_1_11"
else
    warn "$check_1_1_11"
fi    

check_1_1_12="1.1.12  - Ensure that the etcd data directory ownership is set to etcd:etcd"
etcd2=$(stat -c %U:%G /var/lib/etcd)
if [ "$etcd2" = "etcd:etcd" ]; then
  pass "$check_1_1_12"
else
  warn "$check_1_1_12"
  warn "$etcd2"
fi  

check_1_1_13="1.1.13  - Ensure that the admin.conf file permissions are set to 644 or more restrictive"
na "$check_1_1_13"
na "    RKE does not store the kubernetes default kubeconfig credentials file on the nodes. It’s presented to user where RKE is run. We recommend that this kube_config_cluster.yml file be kept in secure store."

check_1_1_14="1.1.14  - Ensure that the admin.conf file ownership is set to root:root"
na "$check_1_1_14"
na "    RKE does not store the default kubectl config credentials file on the nodes. It presents credentials to the user when rke is first run, and only on the device where the user ran the command. Rancher Labs recommends that this kube_config_cluster.yml file be kept in secure store."

check_1_1_15="1.1.15  - Ensure that the scheduler.conf file permissions are set to 644 or more restrictive"
na "$check_1_1_15"
na "    RKE doesn’t require or maintain a configuration file for the scheduler. All configuration is passed in as arguments at container run time."

check_1_1_16="1.1.16  - Ensure that the scheduler.conf file ownership is set to root:root"
na "$check_1_1_16"
na "    RKE doesn’t require or maintain a configuration file for the scheduler. All configuration is passed in as arguments at container run time."

check_1_1_17="1.1.17  - Ensure that the controller-manager.conf file permissions are set to 644 or more restrictive"
na "$check_1_1_17"
na "    RKE doesn’t require or maintain a configuration file for the controller manager. All configuration is passed in as arguments at container run time." 

check_1_1_18="1.1.18  - Ensure that the controller-manager.conf file ownership is set to root:root"
na "$check_1_1_17"
na "    RKE doesn’t require or maintain a configuration file for the controller manager. All configuration is passed in as arguments at container run time."

check_1_1_19="1.1.19  - Ensure that the Kubernetes PKI directory and file ownership is set to root:root"
pki=$(stat -c %U:%G /etc/kubernetes/ssl)
if [ "$pki" = "root:root" ]; then
  pass "$check_1_1_19"
else
  warn "$check_1_1_19"
  #warn "     * Wrong ownership"
fi

check_1_1_20="1.1.20  - Ensure that the Kubernetes PKI certificate file permissions are set to 644 or more restrictive"
certs=(`ls -laR /etc/kubernetes/ssl/ |grep -v yaml | grep -v key | grep -v ^d | grep -v ^/ | grep -v ^t | grep pem | cut -d " " -f9`)
info "$check_1_1_20"
for ((i=0; i<${#certs[@]}; i++)); do
  if [ "$(stat -c %a /etc/kubernetes/ssl/${certs[i]})" -eq 644 -o "$(stat -c %a /etc/kubernetes/ssl/${certs[i]})" -eq 640 -o "$(stat -c %a /etc/kubernetes/ssl/${certs[i]})" -eq 600 ]; then
    pass "check ${certs[i]}"
  else
    warn "$check_1_1_20"
    perm=$(stat -c %a ${certs[i]})
    warn "     * Wrong permissions for ${certs[i]}:$perm"
  fi
done

check_1_1_21="1.1.21  - Ensure that the Kubernetes PKI key file permissions are set to 600"
keys=(`ls -laR /etc/kubernetes/ssl/ |grep -v yaml |  grep -v ^d | grep -v ^/ | grep -v ^t | grep key | cut -d " " -f9`)
info "$check_1_1_21"
  for ((i=0; i<${#keys[@]}; i++)); do
    if [ "$(stat -c %a /etc/kubernetes/ssl/${keys[i]})" -eq 644 -o "$(stat -c %a /etc/kubernetes/ssl/${keys[i]})" -eq 640 -o "$(stat -c %a /etc/kubernetes/ssl/${keys[i]})" -eq 600 ]; then
      pass "check ${keys[i]}"
    else
      warn "$check_1_1_21"
      perm=$(stat -c %a /etc/kubernetes/ssl/${keys[i]})
      warn "     * Wrong permissions for ${keys[i]}:$perm"
    fi
  done
