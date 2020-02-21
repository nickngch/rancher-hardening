#!/bin/sh
# ------------------------------------------------------------------------------
# Rancher Hardening CIS benchmark
#
# nickngch90
#
# ------------------------------------------------------------------------------

CIS_APISERVER_CMD=${CIS_APISERVER_CMD:-kube-apiserver}
CIS_MANAGER_CMD=${CIS_MANAGER_CMD:-kube-controller-manager}
CIS_SCHEDULER_CMD=${CIS_SCHEDULER_CMD:-kube-scheduler}
CIS_ETCD_CMD=${CIS_ETCD_CMD:-etcd}

# Load dependencies
. ./helper.sh

ver=$1
role=$2
if [ -z "$1" ]; then
    warn "usage: ./master.sh version role"
	exit
fi
# Check for required program(s)
req_progs='awk grep pgrep sed jq'
for p in $req_progs; do
  command -v "$p" >/dev/null 2>&1 || { printf "%s command not found.\n" "$p"; exit 1; }
done

# Load all the tests from master/ and run them
main () {
  info "1 - Master Node Security Configuration"
  
  case $role in
  
	  cp)
		  for test in $ver/master/master_[1-4]_*.sh
		  #. ./$ver/master_[1-4]_*.sh
	          do
			. ./"$test"
		  done
		;;

	  etcd)
		  for test in $ver/master/master_[4-5]_*.sh
	          do
			  . ./"$test"
		  done
		  ;;

	  exp)
		  for test in $ver/master/master_[6-7]_*.sh
		  do
			  . ./"$test"
		  done
		  ;;

	  all)
		  for test in $ver/master/master_[1-5]_*.sh
		  do
			  . ./"$test"
		  done
		  ;;

	*)
		ehco "Invalid node's role"
		;;

  esac



  #for test in $ver/master/master_*.sh
  #do
  #   . ./"$test"
  #done
}

#main "$@"
main
