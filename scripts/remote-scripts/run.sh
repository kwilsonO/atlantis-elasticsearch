CONF_FILE="/data/atlantis/elasticsearch/atlantis-elasticsearch/config/atlantis/atlantis.config"
if [[ "${ES_REPO_ROOT}" != "" ]] ; then
	CONF_FILE="${ES_REPO_ROOT}/config/atlantis/atlantis.config"
else
	export ES_REPO_ROOT="/data/atlantis/elasticsearch/atlantis-elasticsearch"
fi

#read config vars
source "$CONF_FILE"

LOCALHOSTNAME=$(uname -n)

echo "${ES_NODE_NAME} : ${LOCALHOSTNAME} Run:"

echo "Starting elasticsearch run script..."
bash $ES_REPO_ROOT/run.sh
