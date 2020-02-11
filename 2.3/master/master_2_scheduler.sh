info "1.2 - Scheduler"

check_1_2_1="1.2.1  - Ensure that the --profiling argument is set to false"
profiling2=$(docker inspect kube-scheduler | jq -e '.[0].Args[] | match("--profiling=false").string');
if [ $profiling2 = \"--profiling=false\" ]; then
  	pass "$check_1_2_1"
else
  	warn "$check_1_2_1"
fi

check_1_2_2="1.2.2  - Ensure that the --address argument is set to 127.0.0.1"
address=$(docker inspect kube-scheduler | jq -e '.[0].Args[] | match("--address=127\\.0\\.0\\.1").string')
if [ "$address" = \"--address=127.0.0.1\" ]; then
  	pass "$check_1_2_2"
else
  	warn "$check_1_2_2"
fi
