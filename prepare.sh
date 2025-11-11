#!/bin/bash

source sysbench.ini
sysbench --config-file=sysbench.ini --tables=${tables} --table_size=${table_size} oltp_common prepare
