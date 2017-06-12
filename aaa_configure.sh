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
AAA_CONFG="$AAA_HOME/aaa.conf"
TNS_CONFG="$ORACLE_HOME/network/admin/tnsnames.ora"
#TNS_CONFG="$ORACLE_HOME/tnsnames.ora"
echo "aaa: $AAA_CONFG , tns: $TNS_CONFG"

if [[ -z $AAA_HOME ]]; then
	echo "$AAA_HOME is not set"
	 exit 1
fi

if [[ -z $ORACLE_HOME ]]; then
	echo "$ORACLE_HOME is not set"
	 exit 1
fi

 su alepo -c "sed -i -e 's/^ConnectStr=.*/ConnectStr=$SERVICE_NAME;$USER;$PASSWORD/' ${AAA_CONFG}"
 su alepo -c "sed -i -e 's/(ADDRESS=.*/(ADDRESS = (PROTOCOL = TCP)(HOST = $HOST)(PORT = 1521))/' $TNS_CONFG"
