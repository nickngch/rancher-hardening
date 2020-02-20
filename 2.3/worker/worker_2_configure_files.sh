info "2.2 - Configuration Files"

check_2_2_1="2.2.1  - Ensure that the config file permissions are set to 644 or more restrictive"
file=/etc/kubernetes/ssl/kubecfg-kube-node.yaml
if [ -f "$file" ]; then
  if [ "$(stat -c %a $file)" -eq 644 -o "$(stat -c %a $file)" -eq 600 -o "$(stat -c %a $file)" -eq 400 ]; then
    pass "$check_2_2_1"
  else
    warn "$check_2_2_1"
    warn "2.2.1 -     * Wrong permissions for $file"
  fi
else
  info "$check_2_2_1"
  info "2.2.1 -     * File not found"
fi

check_2_2_2="2.2.2  - Ensure that the config file ownership is set to root:root"
file2=/etc/kubernetes/ssl/kubecfg-kube-node.yaml
if [ -f "$file2" ]; then
  if [ "$(stat -c %u%g $file2)" -eq 00 ]; then
    pass "$check_2_2_2"
  else
    warn "$check_2_2_2"
    warn "2.2.2 -     * Wrong ownership $file2"
  fi
else
  info "$check_2_2_2"
fi

check_2_2_3="2.2.3  - Ensure that the kubelet file permissions are set to 644 or more restrictive"
na "$check_2_2_3"
na "2.2.3 - RKE doesn’t require or maintain a configuration file for kubelet. All configuration is passed in as arguments at container run time."

check_2_2_4="2.2.4  - Ensure that the kubelet file ownership is set to root:root"
na "$check_2_2_4"
na "2.2.4 - RKE doesn’t require or maintain a configuration file for kubelet. All configuration is passed in as arguments at container run time."

check_2_2_5="2.2.5  - Ensure that the proxy file permissions are set to 644 or more restrictive"
file3=/etc/kubernetes/ssl/kubecfg-kube-proxy.yaml
if [ -f "$file3" ]; then
  if [ "$(stat -c %a $file3)" -eq 644 -o "$(stat -c %a $file3)" -eq 600 -o "$(stat -c %a $file3)" -eq 400 ]; then
    pass "$check_2_2_5"
  else
    warn "$check_2_2_5"
    warn "2.2.5 -     * Wrong permissions for $file3"
  fi
else
  info "$check_2_2_5"
  info "2.2.5 -     * File not found"
fi

check_2_2_6="2.2.6  - Ensure that the proxy file ownership is set to root:root"
if [ -f "$file3" ]; then
  if [ "$(stat -c %u%g $file3)" -eq 00 ]; then
    pass "$check_2_2_6"
  else
    warn "$check_2_2_6"
    warn "2.2.6 -     * Wrong ownership for $file3"
  fi
else
  info "$check_2_2_6"
fi

check_2_2_7="2.2.7  - Ensure that the certificate authorities file permissions are set to 644 or more restrictive"
file4=/etc/kubernetes/ssl/kube-ca.pem
  if [ "$(stat -c %a $file4)" -eq 644 -o "$(stat -c %a $file4)" -eq 600 -o "$(stat -c %a $file4)" -eq 400 ]; then
    pass "$check_2_2_7"
  else
    warn "$check_2_2_7"
    warn "2.2.7 -     * Wrong permissions for $file4"
  fi

check_2_2_8="2.2.8  - Ensure that the client certificate authorities file ownership is set to root:root"
  if [ "$(stat -c %u%g $file4)" -eq 00 ]; then
    pass "$check_2_2_8"
  else
    warn "$check_2_2_8"
    warn "2.2.8 -     * Wrong ownership for $file4"
  fi

check_2_2_9="2.2.9 - Ensure that the kubelet configuration file ownership is set to root:root"
na "$check_2_2_9"
na "2.2.9 - RKE doesn’t require or maintain a configuration file for kubelet. All configuration is passed in as arguments at container run time."

check_2_2_10="2.2.10  - Ensure that the proxy file permissions are set to 644 or more restrictive"
na "$check_2_2_10"
na "2.2.10 - RKE doesn’t require or maintain a configuration file for kubelet. All configuration is passed in as arguments at container run time."
