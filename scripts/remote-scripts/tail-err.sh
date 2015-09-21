CONF_FILE="${ES_REPO_ROOT}/config/atlantis/atlantis.config"

#read config
source "${CONF_FILE}"

LOCALHOSTNAME=$(uname -n)

echo "${ES_NAME} : ${LOCALHOSTNAME} Tail-err:"
tail -n 100 $ES_LOG_PATH/err.log
