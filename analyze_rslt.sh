#!/bin/bash

ip=$1
port=$2

usage(){
	echo ""
	echo "Usage: bash $0 host port"
	echo "Usage: bash $0 dir"

	echo ""
	echo "##### benchmarks.txt setup #####"
	echo "oltp_point_select"
	echo "oltp_read_only"
	echo "..."

	echo "##### threads.txt setup #####"
	echo "16"
	echo "32"
	echo "64"
	echo "..."

	echo "oltp_analyze_rslt.sh required"
}


if [ -z $ip ] || ! [ -f threads.txt ] || ! [ -f benchmarks.txt ] || ! [ -f oltp_analyze_rslt.sh ]
then
	usage
	exit 1
fi

while read benchmark
do

	if [ -n "$port" ]
	then
		bash oltp_analyze_rslt.sh $benchmark $ip $port 
	else
		bash oltp_analyze_rslt.sh $benchmark $ip
	fi

	echo ""
	echo ""
done<benchmarks.txt
