#!/bin/bash

ip=$1
port=$2
threads=$3

if [ -n "$4" ]
then
	time=$4
else
	time=120
fi

usage(){
	echo ""
	echo "Usage: bash $0 host port threads [time=120]"

	echo ""
	echo "##### sysbench.ini setup #####"
	echo "mysql_host=user"
	echo "mysql_password=password"
	echo "mysql_db=sysbench"
}

cd "$(dirname $0)"

if [ -z $ip ] || [ -z $port ] || [ -z $threads ] || ! [ -e "sysbench.ini" ]
then
	usage
	exit 1
fi

bash ./oltp.sh point_select $@
