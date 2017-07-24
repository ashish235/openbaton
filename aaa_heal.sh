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

case "$cause" in

("serviceDown") 
	echo "The AAA is down, let's try to restart it..."
	#check if pid file is present, if yes, then delete the pid file.
	if	[[  -f  $AAA_HOME/alepoaaaserver.pid ]]; then
			su - alepo -c "rm -fr $AAA_HOME/alepoaaaserver.pid"
	fi
	# start AAA services.
	su - alepo -c "export LD_LIBRARY_PATH=/home/alepo/alepoaaa/;/home/alepo/alepoaaa/alepoaaa start"
	# check if AAA services successfully started
	if [ ! `su - alepo -c "$AAA_HOME/alepoaaa status| grep 'running' " ` ]; then
		echo "ERROR: the AAA is not started"
	    exit 1
	
	fi
	
	echo "The AAA is running again!"
	;;
*) echo "The cause $cause is unknown"
	exit 2
	;;
esac

