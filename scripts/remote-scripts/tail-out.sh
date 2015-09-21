CONF_FILE="${ES_REPO_ROOT}/config/atlantis/atlantis.config"

#read config
source "${CONF_FILE}"

LOCALHOSTNAME=$(uname -n)

echo "${ES_NAME} : ${LOCALHOSTNANE} Tail-out:"
tail -n 100 $ES_LOG_PATH/out.log
