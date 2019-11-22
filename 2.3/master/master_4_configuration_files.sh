info "1.4 - Configuration Files"

check_1_4_1="1.4.1  - Ensure that the API server pod specification file permissions are set to 644 or more restrictive"
na "$check_1_4_1"
na "    RKE doesn’t require or maintain a configuration file for kube-apiserver. All configuration is passed in as arguments at container run time."

check_1_4_2="1.4.2  - Ensure that the API server pod specification file ownership is set to root:root"
na "$check_1_4_2"
na "    RKE doesn’t require or maintain a configuration file for kube-apiserver. All configuration is passed in as arguments at container run time."

check_1_4_3="1.4.3  - Ensure that the controller manager pod specification file permissions are set to 644 or more restrictive"
na "$check_1_4_3"
na "    RKE doesn’t require or maintain a configuration file for kube-apiserver. All configuration is passed in as arguments at container run time."

check_1_4_4="1.4.4  - Ensure that the controller manager pod specification file ownership is set to root:root"
na "$check_1_4_4"
na "    RKE doesn’t require or maintain a configuration file for kube-apiserver. All configuration is passed in as arguments at container run time."

check_1_4_5="1.4.5  - Ensure that the scheduler pod specification file permissions are set to 644 or more restrictive"
na "$check_1_4_5"
na "    RKE doesn’t require or maintain a configuration file for kube-apiserver. All configuration is passed in as arguments at container run time."

check_1_4_6="1.4.6  - Ensure that the scheduler pod specification file ownership is set to root:root"
na "$check_1_4_6"
na "    RKE doesn’t require or maintain a configuration file for kube-apiserver. All configuration is passed in as arguments at container run time."

check_1_4_7="1.4.7  - Ensure that the etcd pod specification file permissions are set to 644 or more restrictive"
na "$check_1_4_7"
na "    RKE doesn’t require or maintain a configuration file for kube-apiserver. All configuration is passed in as arguments at container run time."

check_1_4_8="1.4.8  - Ensure that the etcd pod specification file ownership is set to root:root"
na "$check_1_4_8"
na "    RKE doesn’t require or maintain a configuration file for kube-apiserver. All configuration is passed in as arguments at container run time."

check_1_4_9="1.4.9  - Ensure that the Container Network Interface file permissions are set to 644 or more restrictive"
na "$check_1_4_9"
na "    This is a manual check. https://rancher.com/docs/rancher/v2.x/en/security/benchmark-2.3/#1-4-9-ensure-that-the-container-network-interface-file-permissions-are-set-to-644-or-more-restrictive-not-scored"

check_1_4_10="1.4.10  - Ensure that the Container Network Interface file ownership is set to root:root"
na "$check_1_4_10"
na "    This is a manual check. https://rancher.com/docs/rancher/v2.x/en/security/benchmark-2.3/#1-4-10-ensure-that-the-container-network-interface-file-ownership-is-set-to-root-root-not-scored."

check_1_4_11="1.4.11  - Ensure that the etcd data directory permissions are set to 700 or more restrictive"
#etcd="/var/lib/rancher/etcd/"
etcd=$(stat -c "%n - %a" /var/lib/etcd | cut -d " " -f3)
if [ "$etcd" -eq 700 ]; then
    pass "$check_1_4_11"
else
    warn "$check_1_4_11"
fi    

check_1_4_12="1.4.12  - Ensure that the etcd data directory ownership is set to etcd:etcd"
etcd2=$(stat -c %U:%G /var/lib/etcd)
if [ "$etcd2" = \"etcd:etcd\" ]; then
  pass "$check_1_4_12"
else
  warn "$check_1_4_12"
  warn "$etcd2"
fi  

check_1_4_13="1.4.13  - Ensure that the admin.conf file permissions are set to 644 or more restrictive"
na "$check_1_4_13"
na "    RKE does not store the kubernetes default kubeconfig credentials file on the nodes. It’s presented to user where RKE is run. We recommend that this kube_config_cluster.yml file be kept in secure store."

check_1_4_14="1.4.14  - Ensure that the admin.conf file ownership is set to root:root"
na "$check_1_4_14"
na "    RKE does not store the default kubectl config credentials file on the nodes. It presents credentials to the user when rke is first run, and only on the device where the user ran the command. Rancher Labs recommends that this kube_config_cluster.yml file be kept in secure store."

check_1_4_15="1.4.15  - Ensure that the scheduler.conf file permissions are set to 644 or more restrictive"
file=$(stat -c %a /etc/kubernetes/ssl/kubecfg-kube-scheduler.yaml)
  if [ $file -eq 644 ]; then
    pass "$check_1_4_15"
  else
    warn "$check_1_4_15"
    warn "     * Wrong permissions for $file:$file"
  fi

check_1_4_16="1.4.16  - Ensure that the scheduler.conf file ownership is set to root:root"
file1=$(stat -c %U:%G /etc/kubernetes/ssl/kubecfg-kube-scheduler.yaml)
  if [ "$file1" = "root:root"  ]; then
    pass "$check_1_4_16"
  else
    warn "$check_1_4_16"
    warn "     * Wrong ownership for $file1"
  fi

check_1_4_17="1.4.17  - Ensure that the controller-manager.conf file permissions are set to 644 or more restrictive"
file2=$(stat -c %a /etc/kubernetes/ssl/kubecfg-kube-controller-manager.yaml)
  if [ $file2 -eq 644 ]; then
    pass "$check_1_4_17"
  else
    warn "$check_1_4_17"
    warn "     * Wrong permissions"
  fi

check_1_4_18="1.4.18  - Ensure that the controller-manager.conf file ownership is set to root:root"
file3=$(stat -c %U:%G /etc/kubernetes/ssl/kubecfg-kube-controller-manager.yaml)
  if [ $file3 = root:root ]; then
    pass "$check_1_4_18"
  else
    warn "$check_1_4_18"
    warn "     * Wrong ownership"
  fi

check_1_4_19="1.4.19  - Ensure that the Kubernetes PKI directory and file ownership is set to root:root"
pki=$(stat -c %U:%G /etc/kubernetes/ssl)
if [ "$pki" = \"root:root\" ]; then
  pass "$check_1_4_19"
else
  warn "$check_1_4_19"
  #warn "     * Wrong ownership"
fi

check_1_4_20="1.4.20  - Ensure that the Kubernetes PKI certificate file permissions are set to 644 or more restrictive"
certs=(`ls -laR /etc/kubernetes/ssl/ |grep -v yaml | grep -v key | grep -v ^d | grep -v ^/ | grep -v ^t | grep pem | cut -d " " -f9`)
info "$check_1_4_20"
for ((i=0; i<${#certs[@]}; i++)); do
  if [ "$(stat -c %a /etc/kubernetes/ssl/${certs[i]})" -eq 644 -o "$(stat -c %a /etc/kubernetes/ssl/${certs[i]})" -eq 640 -o "$(stat -c %a /etc/kubernetes/ssl/${certs[i]})" -eq 600 ]; then
    pass "check ${certs[i]}"
  else
    warn "$check_1_4_20"
    perm=$(stat -c %a ${certs[i]})
    warn "     * Wrong permissions for ${certs[i]}:$perm"
  fi
done

check_1_4_21="1.4.21  - Ensure that the Kubernetes PKI key file permissions are set to 600"
keys=(`ls -laR /etc/kubernetes/ssl/ |grep -v yaml |  grep -v ^d | grep -v ^/ | grep -v ^t | grep key | cut -d " " -f9`)
info "$check_1_4_21"
  for ((i=0; i<${#keys[@]}; i++)); do
    if [ "$(stat -c %a /etc/kubernetes/ssl/${keys[i]})" -eq 644 -o "$(stat -c %a /etc/kubernetes/ssl/${keys[i]})" -eq 640 -o "$(stat -c %a /etc/kubernetes/ssl/${keys[i]})" -eq 600 ]; then
      pass "check ${keys[i]}"
    else
      warn "$check_1_4_21"
      perm=$(stat -c %a /etc/kubernetes/ssl/${keys[i]})
      warn "     * Wrong permissions for ${keys[i]}:$perm"
    fi
  done
