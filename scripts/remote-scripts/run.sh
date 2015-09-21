CONF_FILE="${ES_REPO_ROOT}/config/atlantis/atlantis.config"

#read config vars
source "$CONF_FILE"

LOCALHOSTNAME=$(uname -n)

echo "${ES_NODE_NAME} : ${LOCALHOSTNAME} Run:"

echo "Starting logstash run script..."
bash $ES_REPO_ROOT/run.sh
