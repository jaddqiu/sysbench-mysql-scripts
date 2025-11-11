#!/bin/bash

ip=$1
port=$2
suffix=$3

usage(){
	echo ""
	echo "Usage: bash $0 host port [result_dir_suffix]"

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
}


if [ -z $ip ] || [ -z $port ] || ! [ -f threads.txt ] || ! [ -f benchmarks.txt ] || ! [ -f oltp.sh ]
then
	usage
	exit 1
fi


if [ -z $suffix ]
then
	dir="${ip}-${port}"
else
	dir="${ip}-${port}-${suffix}"
fi

mkdir -p ${dir}



while read benchmark
do
	while read thread
	do
		bash oltp.sh $benchmark $ip $port $thread >${dir}/${benchmark}_$thread.log
	done<threads.txt
done<benchmarks.txt
