info "1.7 - PodSecurityPolicies"

check=$(kubectl get node | grep ^NAME | cut -d " " -f 1 >/dev/null )
#echo $check
if [ "$check" != "NAME" ]; then 
	warn "kubectl cannot connect to the cluster"
	exit 1
fi


# Make the loop separator be a new-line in POSIX compliant fashion
set -f; IFS=$'
'

check_1_7_1="1.7.1 - Place compensating controls in the form of PSP and RBAC for privileged containers usage (Not Scored)"
psp=$(kubectl get psp restricted -o jsonpath='{.spec.privileged}' | grep "true")
if [ -z "$psp" ]; then
	pass $check_1_7_1
else
	warn $check_1_7_1
fi
	
check_1_7_2="1.7.2 - Do not admit containers wishing to share the host process ID namespace (Scored)"
psp2=$(kubectl get psp restricted -o jsonpath='{.spec.hostPID}' | grep "true")
if [ -z "$psp2"]; then
	pass $check_1_7_2
else
	warn $check_1_7_2
fi

check_1_7_3="1.7.3 - Do not admit containers wishing to share the host IPC namespace (Scored)"
psp3=$(kubectl get psp restricted -o jsonpath='{.spec.hostIPC}' | grep "true")
if [ -z "$psp3"]; then
	pass $check_1_7_3
else
	warn $check_1_7_3
fi
	
check_1_7_4="1.7.4 - Do not admit containers wishing to share the host network namespace (Scored)"
psp4=$(kubectl get psp restricted -o jsonpath='{.spec.hostNetwork}' | grep "true")
if [ -z "$psp4"]; then
	pass $check_1_7_4
else
	warn $check_1_7_4
fi
	
check_1_7_5="1.7.5 - Do not admit containers with allowPrivilegeEscalation (Scored)"
psp5=$(kubectl get psp restricted -o jsonpath='{.spec.allowPrivilegeEscalation}' | grep "true")
if [ -z "$psp5" ]; then
	pass $check_1_7_5
else
	warn $check_1_7_5
fi
	
check_1_7_6="1.7.6 - Do not admit root containers (Not Scored)"
psp6=$(kubectl get psp restricted -o jsonpath='{.spec.runAsUser.rule}' | grep "RunAsAny")
if [ -z "$psp6" ]; then
	pass $check_1_7_6
else
	warn $check_1_7_6
fi
	
check_1_7_7="1.7.7 - Do not admit containers with dangerous capabilities (Not Scored)"
psp7=$(kubectl get psp restricted -o jsonpath='{.spec.requiredDropCapabilities}' | grep "NET_RAW")
if [ "psp7" = \[NET_RAW\] ]; then
	pass $check_1_7_7
else
	warn $check_1_7_7
fi
