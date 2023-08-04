#! /usr/bin/bash

logfile="duckdns.log"
touch $logfile

echo "Starting Duckdns-updater" >> $logfile
echo "Domains: $DUCKDNS_ENV_DOMAINS" >> $logfile
echo "Token: $DUCKDNS_ENV_TOKEN" >> $logfile
echo
echo "Updater uses this URL:" >> $logfile
echo "https://www.duckdns.org/update?domains='${DUCKDNS_ENV_DOMAINS}'&token='${DUCKDNS_ENV_TOKEN}'&ip=" >> $logfile

# None of the users environmentvariables are copied to the cronjob.
# Instead it uses /etc/environment
# So for us to use our environmentvariables we need to copy them to /etc/environment
echo "Configuring environmentvaribels" >> $logfile
echo "export DUCKDNS_ENV_DOMAINS=$DUCKDNS_ENV_DOMAINS" >> /etc/environment
echo "export DUCKDNS_ENV_TOKEN=$DUCKDNS_ENV_TOKEN" >> /etc/environment

# Register when to do the cronjob
echo "Registering cronjob" >> $logfile
crontab -l | { cat; echo "*/1 * * * * /opt/duckdns/duck.sh > /dev/null 2>&1"; } | crontab -
crontab -l  >> $logfile

# Starting the crontab
echo "Starting cron" >> $logfile
cron >> $logfile
echo "cron started" >> $logfile

tail -F duckdns.log
