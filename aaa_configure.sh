#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

#/ Usage:
#/ Description:
#/ Examples:
#/ Options:
#/   --help: Display this help message
if (($# == 0)); then

        echo " Requires an argument.Try -h for Help...!!!"
        exit 3
fi
while getopts "H:S:U:P:h" opt; do
    case $opt in
        H )  HOST=$OPTARG ;;
        S )  SERVICE_NAME=$OPTARG  ;;
        U )  USER=$OPTARG ;;
        P )  PASSWORD=$OPTARG ;;
        h )  echo "Script to configure AAA server"
             echo "Usage:"
             echo "$0 [-H hostIP] [-S service name] [-U username] [-P password]   "
             exit 3 ;;
        \? ) echo "Invalid option: - $1, Use $0 -h for Help...!!!"
             exit 3;;
    esac
done
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
