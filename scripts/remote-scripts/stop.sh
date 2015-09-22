CONF_FILE="/data/atlantis/elasticsearch/atlantis-elasticsearch/config/atlantis/atlantis.config"
if [[ "${ES_REPO_ROOT}" != "" ]] ; then
	CONF_FILE="${ES_REPO_ROOT}/config/atlantis/atlantis.config"
else
	export ES_REPO_ROOT="/data/atlantis/elasticsearch/atlantis-elasticsearch"
fi

#read config file
source "${CONF_FILE}"

LOCALHOSTNAME=$(uname -n)

echo "${ES_NODE_NAME} : ${LOCALHOSTNAME} Stop:"

echo "Stopping elasticsearch..."
myprocid="$(ps -ef | grep "elasticsearch-${ES_VERSION}" | grep -v grep | awk '{print $2}')"

if [ "${myprocid}" = "" ]; then 

	echo "No elasticsearch process found."
else

	echo "Killing proccess pid: ${myprocid}..."
	kill -9 $myprocid

fi
