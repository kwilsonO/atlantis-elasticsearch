CONF_FILE="${ES_REPO_ROOT}/config/atlantis/atlantis.config"

#read config file
source "${CONF_FILE}"

LOCALHOSTNAME=$(uname -n)

echo "${ES_NAME} : ${LOCALHOSTNAME} Stop:"

echo "Stopping elasticsearch..."
myprocid="$(ps -ef | grep "elasticsearch-${ES_VERSION}" | grep -v grep | awk '{print $2}')"

if [ "${myprocid}" = "" ]; then 

	echo "No elasticsearch process found."
else

	echo "Killing proccess pid: ${myprocid}..."
	kill -9 $myprocid

fi
