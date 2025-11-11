#!/bin/bash

benchmark=$1
ip=$2
port=$3


usage(){
	echo ""
	echo "Usage: "
	echo "Usage: bash $0 benchmark host port"
	echo "Usage: bash $0 benchmark dir"

}

cd "$(dirname $0)"

if [ -z "$benchmark" ] || [ -z $ip ]
then
	usage
	exit 1
fi

if [ -z "$port" ]
then
	dir="$ip"
else
	dir="${ip}-${port}"
fi

echo "$dir $benchmark result:"
echo -e thread"\t"qps"\t"latency
while read thread
do
	if [ -e ${dir}/${benchmark}_$thread.log ]
	then
		qps=$(cat ${dir}/${benchmark}_$thread.log|grep queries:|awk -F'(' '{print $2}'|awk '{print $1}')
		latency=$(cat ${dir}/${benchmark}_$thread.log|grep avg:|awk '{print $2}')
		echo -e ${thread}"\t"${qps}"\t"${latency}
	fi
done<threads.txt
