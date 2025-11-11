#!/bin/bash

benchmark=$1
ip=$2
port=$3
threads=$4


usage(){
	echo ""
	echo "Usage: bash $0 benchmark host port threads [time=120]"

	echo ""
	echo "##### sysbench.ini setup #####"
	echo "mysql_host=user"
	echo "mysql_password=password"
	echo "mysql_db=sysbench"
	echo "time=120"
}

cd "$(dirname $0)"

if [ -z $benchmark ] || [ -z $ip ] || [ -z $port ] || [ -z $threads ] || ! [ -e sysbench.ini ]
then
	usage
	exit 1
fi

source sysbench.ini

if [ -n "$5" ]
then
	time=$5
fi

sysbench oltp_${benchmark} \
--db-driver=mysql \
--mysql-host=$ip \
--mysql-port=$port \
--mysql-user=$mysql_user \
--mysql-password=$mysql_password \
--mysql-db=$mysql_db \
--sum_ranges=50 \
--distinct_ranges=50 \
--range_size=100 \
--simple_ranges=100 \
--order_ranges=100 \
--index_updates=1 \
--tables=10 \
--table_size=10000000 \
--time=${time} \
--threads=$threads \
--report-interval=5 \
run
