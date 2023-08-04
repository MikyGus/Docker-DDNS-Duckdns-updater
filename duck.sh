#! /usr/bin/bash

logfile="/opt/duckdns/duckdns.log"
urlstring="https://www.duckdns.org/update?domains=${DUCKDNS_ENV_DOMAINS}&token=${DUCKDNS_ENV_TOKEN}&ip="

echo $(date +%Y-%m-%d_%T) Updating domains >> $logfile

#echo "Domains: $DUCKDNS_ENV_DOMAINS" >> $logfile
#echo "Token: $DUCKDNS_ENV_TOKEN" >> $logfile

echo url="${urlstring}" | curl -k -K - >> $logfile
echo "-- $urlstring" >> $logfile
