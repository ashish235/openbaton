#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

#/ Usage:
#/ Description:
#/ Examples:
#/ Options:
#/   --help: Display this help message
AAA_HOME="/home/alepo/alepoaaa"
ORACLE_HOME="/u01/app/oracle/product/11.2.0/client"

if [[ -z $AAA_HOME ]]; then
	echo "$AAA_HOME is not set"
	 exit 1
fi

if [ ! `su - alepo -c "$AAA_HOME/alepoaaa status| grep 'running' " ` ]; then
	su - alepo -c "export LD_LIBRARY_PATH=/home/alepo/alepoaaa/;/home/alepo/alepoaaa/alepoaaa start"
	echo "AAA starting"
	
fi
