CONF_FILE="/data/atlantis/elasticsearch/atlantis-elasticsearch/config/atlantis/atlantis.config"
if [[ "${ES_REPO_ROOT}" != "" ]] ; then
	CONF_FILE="${ES_REPO_ROOT}/config/atlantis/atlantis.config"
else
	export ES_REPO_ROOT="/data/atlantis/elasticsearch/atlantis-elasticsearch"
fi

#read in config
source "$CONF_FILE"

myprocid="$(ps -ef | grep "elasticsearch-${ES_VERSION}" | grep -v grep | awk '{print $2}')"

LOCALHOSTNAME=$(uname -n)

echo "${ES_NAME} : ${LOCALHOSTNAME} Status:"

if [ "${myprocid}" = "" ]; then 

	echo "No elasticsearch process found."
else

	echo "[${myprocid}] atlantis-elasticsearch running..."

fi
