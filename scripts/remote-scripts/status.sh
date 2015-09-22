CONF_FILE="/data/atlantis/elasticsearch/atlantis-elasticsearch/config/atlantis/atlantis.config"
if [[ "${ES_REPO_ROOT}" != "" ]] ; then
	CONF_FILE="${ES_REPO_ROOT}/config/atlantis/atlantis.config"
else
	export ES_REPO_ROOT="/data/atlantis/elasticsearch/atlantis-elasticsearch"
fi

#read in config
source "$CONF_FILE"

myprocid="$(ps -ef | grep "elasticsearch-${ES_VERSION}" | grep -v grep | awk '{print $2}')"

#time running math
NOW=$(date +%s)
DIFF=$(($NOW-$ES_START_TIME))
TIMERUN=$(date -u -d @$DIFF +%H:%M:%S)
START=$(date -u -d @$ES_START_TIME +%c)

LOCALHOSTNAME=$(uname -n)

echo "${ES_NAME} : ${LOCALHOSTNAME} Status:"

if [ "${myprocid}" = "" ]; then 

	echo "No elasticsearch process found."
else

	echo "[${myprocid}] atlantis-elasticsearch running for ${TIMERUN} since ${START}"

fi
