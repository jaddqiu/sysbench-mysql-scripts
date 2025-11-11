#!/bin/bash

ip=$1
port=$2
threads=$3

usage(){
	echo ""
	echo "Usage: bash $0 host port threads"

	echo ""
	echo "##### sysbench.ini setup #####"
	echo "mysql_host=user"
	echo "mysql_password=password"
	echo "mysql_db=sysbench"
}

cd "$(dirname $0)"

if [ -z $ip ] || [ -z $port ] || [ -z $threads ] || ! [ -e sysbench.ini ]
then
	usage
	exit 1
fi

source sysbench.ini

sysbench oltp_read_only \
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
