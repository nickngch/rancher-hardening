info "1.6 - General Security Primitives"

# Make the loop separator be a new-line in POSIX compliant fashion
set -f; IFS=$'
'

check_1_6_1="1.6.1  - Ensure that the cluster-admin role is only used where required(Not Scored)"
cluster_admins=$(kubectl get clusterrolebindings -o=custom-columns=NAME:.metadata.name,ROLE:.roleRef.name,SUBJECT:.subjects[*].name)
info $check_1_6_1
info "Rancher has built in support for maintaining and enforcing Kubernetes RBAC on your workload clusters."

check_1_6_2="1.6.2  - Create administrative boundaries between resources using namespaces (Not Scored)"
info $check_1_6_2
info "With Rancher, users or groups can be assigned access to all clusters, a single cluster or a “Project” (a group of one or more namespaces in a cluster). This allows granular access control to cluster resources."

check_1_6_3="1.6.3  - Create network segmentation using Network Policies (Not Scored)"
info $check_1_6_3
info "Rancher can (optionally) automatically create Network Policies to isolate “Projects” (a group of one or more namespaces) in a cluster."

check_1_6_4="1.6.4  - Ensure that the seccomp profile is set to docker/default in your pod definitions (Not Scored)"
info $check_1_6_4
info "Since this requires the enabling of AllAlpha feature gates we would not recommend enabling this feature at the moment."
	
check_1_6_5="1.6.5 - Apply Security Context to Your Pods and Containers (Not Scored)"
info $check_1_6_5
info "This practice does go against control 1.1.13, but we prefer using a PodSecurityPolicy and allowing security context to be set over a blanket deny."
	
check_1_6_6="1.6.6 - Configure Image Provenance using ImagePolicyWebhook admission controller (Not Scored)"
info $check_1_6_6
info "Image Policy Webhook requires a 3rd party service to enforce policy. This can be configured in the --admission-control-config-file. See the Host configuration section for the admission.yaml file."
	
check_1_6_7="1.6.7 - Configure Network policies as appropriate (Not Scored)"
info $check_1_6_7
info "Rancher can (optionally) automatically create Network Policies to isolate projects (a group of one or more namespaces) within a cluster."
	
check_1_6_8="1.6.8 - Place compensating controls in the form of PSP and RBAC for privileged containers usage (Not Scored)"
info $check_1_6_8
info "Section 1.7 of this guide shows how to add and configure a default “restricted” PSP based on controls."
