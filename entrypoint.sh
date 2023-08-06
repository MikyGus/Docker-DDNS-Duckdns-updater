#! /usr/bin/bash

COL_RED='\033[0;91m'
COL_YELLOW='\033[0;93m'
COL_GREEN='\033[0;92m'
COL_NC='\033[0m'
LBL_ERROR="${COL_RED}[ERROR]${COL_NC}"
LBL_WARNING="${COL_YELLOW}[WARNING]${COL_NC}"
LBL_OK="${COL_GREEN}[OK]${COL_NC}"

logfile="duckdns.log"
touch $logfile

echo "Starting Duckdns-updater" >> $logfile
echo "Domains: $DUCKDNS_ENV_DOMAINS" >> $logfile
echo "Token: $DUCKDNS_ENV_TOKEN" >> $logfile

# DUCKDNS_ENV_FREQUENCY #############
regExpInt='^[0-9]+$'
if [[ $DUCKDNS_ENV_FREQUENCY =~ $regExpInt ]] ; then
	echo -e "${LBL_OK} Update frequency (min): $DUCKDNS_ENV_FREQUENCY" >> $logfile
else
	DUCKDNS_ENV_FREQUENCY=5
	echo -e "${LBL_WARNING} Update frequency invalid or not provided, using standard: $DUCKDNS_ENV_FREQUENCY min" >> $logfile
fi
#########################################
echo
echo "Updater uses this URL:" >> $logfile
echo "https://www.duckdns.org/update?domains='${DUCKDNS_ENV_DOMAINS}'&token='${DUCKDNS_ENV_TOKEN}'&ip=" >> $logfile

# None of the users environmentvariables are copied to the cronjob.
# Instead it uses /etc/environment
# So for us to use our environmentvariables we need to copy them to /etc/environment
echo "Configuring environmentvaribels" >> $logfile
echo "export DUCKDNS_ENV_DOMAINS=$DUCKDNS_ENV_DOMAINS" >> /etc/environment
echo "export DUCKDNS_ENV_TOKEN=$DUCKDNS_ENV_TOKEN" >> /etc/environment
# Variables not needed in cronjob:
# echo "export DUCKDNS_ENV_FREQUENCY=$DUCKDNS_ENV_FREQUENCY" >> /etc/environment

# Register when to do the cronjob
echo "Registering cronjob" >> $logfile
crontab -l | { cat; echo "*/$DUCKDNS_ENV_FREQUENCY * * * * /opt/duckdns/duck.sh > /dev/null 2>&1"; } | crontab -
crontab -l  >> $logfile

# Starting the crontab
echo "Starting cron" >> $logfile
cron >> $logfile
echo $(date +%Y-%m-%d_%T) "Cron started" >> $logfile

tail -F duckdns.log
