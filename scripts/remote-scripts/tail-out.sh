CONF_FILE="/data/atlantis/elasticsearch/atlantis-elasticsearch/config/atlantis/atlantis.config"
if [[ "${ES_REPO_ROOT}" != "" ]] ; then
	CONF_FILE="${ES_REPO_ROOT}/config/atlantis/atlantis.config"
else
	export ES_REPO_ROOT="/data/atlantis/elasticsearch/atlantis-elasticsearch"
fi

#read config
source "${CONF_FILE}"

LOCALHOSTNAME=$(uname -n)

echo "${ES_NAME} : ${LOCALHOSTNANE} Tail-out:"
tail -n 100 $ES_LOG_PATH/out.log
