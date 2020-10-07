info "4.1 - Worker Node Configuration Files"

check_4_1_1="4.1.1  - Ensure that the kubelet service file permissions are set to 644 or more restrictive"
na "$check_4_1_1"
na "RKE doesn’t require or maintain a configuration file for kubelet. All configuration is passed in as arguments at container run time."

check_4_1_2="4.1.2  - Ensure that the kubelet service file ownership is set to root:root"
na "$check_4_1_2"
na "RKE doesn’t require or maintain a configuration file for kubelet. All configuration is passed in as arguments at container run time."

check_4_1_3="4.1.3  - Ensure that the proxy kubeconfig file permissions are set to 644 or more restrictive"
file3=(/etc/kubernetes/ssl/kubecfg-kube-proxy.yaml)
if [ -f "$file3" ]; then
  if [ "$(stat -c %a $file3)" -eq 644 -o "$(stat -c %a $file3)" -eq 600 -o "$(stat -c %a $file3)" -eq 400 ]; then
    pass "$check_4_1_3"
  else
    warn "$check_4_1_3"
    warn "     * Wrong permissions for $file3"
  fi
else
  info "$check_4_1_3"
  info "     * File not found"
fi

check_4_1_4="4.1.4  - Ensure that the proxy kubeconfig file ownership is set to root:root"
if [ -f "$file3" ]; then
  if [ "$(stat -c %u%g $file3)" -eq 00 ]; then
    pass "$check_4_1_4"
  else
    warn "$check_4_1_4"
    warn "     * Wrong ownership for $file3"
  fi
else
  info "$check_4_1_4"
fi

check_4_1_5="4.1.5  - Ensure that the kubelet.conf file permissions are set to 644 or more restrictive"
file=(/etc/kubernetes/ssl/kubecfg-kube-node.yaml)
if [ -f "$file" ]; then
  if [ "$(stat -c %a $file)" -eq 644 -o "$(stat -c %a $file)" -eq 600 -o "$(stat -c %a $file)" -eq 400 ]; then
    pass "$check_4_1_5"
  else
    warn "$check_4_1_5"
    warn "     * Wrong permissions for $file"
  fi
else
  info "$check_4_1_5"
  info "     * File not found"
fi

check_4_1_6="4.1.6  - Ensure that the config file ownership is set to root:root"
file2=(/etc/kubernetes/ssl/kubecfg-kube-node.yaml)
if [ -f "$file2" ]; then
  if [ "$(stat -c %u%g $file2)" -eq 00 ]; then
    pass "$check_4_1_6"
  else
    warn "$check_4_1_6"
    warn "     * Wrong ownership $file2"
  fi
else
  info "$check_4_1_6"
fi

check_4_1_7="4.1.7  - Ensure that the certificate authorities file permissions are set to 644 or more restrictive"
file4=(/etc/kubernetes/ssl/kube-ca.pem)
  if [ "$(stat -c %a $file4)" -eq 644 -o "$(stat -c %a $file4)" -eq 600 -o "$(stat -c %a $file4)" -eq 400 ]; then
    pass "$check_4_1_7"
    pass "       * client-ca-file: $file4"
  else
    warn "$check_4_1_7"
    warn "     * Wrong permissions for $file4"
  fi

check_4_1_8="4.1.8  - Ensure that the client certificate authorities file ownership is set to root:root"
  if [ "$(stat -c %u%g $file4)" -eq 00 ]; then
    pass "$check_4_1_8"
    pass "       * client-ca-file: $file4"
  else
    warn "$check_4_1_8"
    warn "     * Wrong ownership for $file4"
  fi

check_4_1_9="4.1.9 - Ensure that the kubelet configuration file has permissions set to 644 or more restrictive"
na "$check_4_1_9"
na "RKE doesn’t require or maintain a configuration file for kubelet. All configuration is passed in as arguments at container run time."

check_4_1_10="4.1.10 - Ensure that the kubelet configuration file ownership is set to root:root"
na "$check_4_1_10"
na "RKE doesn’t require or maintain a configuration file for kubelet. All configuration is passed in as arguments at container run time."




