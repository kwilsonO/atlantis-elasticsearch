CONF_FILE="${ES_REPO_ROOT}/config/atlantis/atlantis.config"

#read config file
source "${CONF_FILE}"

LOCALHOSTNAME=$(uname -n)

echo "${ES_NODE_NAME} : ${LOCALHOSTNAME}  Clear-logs:"

echo "Clearing logs..."
rm $ES_LOG_PATH/err.log
rm $ES_LOG_PATH/out.log
