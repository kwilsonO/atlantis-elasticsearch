#if a single arg then it's the path to config
CONF_FILE_PATH=""
if [ $# -eq 1 ]; then
	CONF_FILE_PATH="$1"
else
	CONF_FILE_PATH="/data/atlantis/elasticsearch/atlantis-elasticsearch/config/atlantis/atlantis.config"
fi

REPO_NAME="atlantis-elasticsearch"

if [[ ! -f $CONF_FILE_PATH ]]; then
	echo "No atlantis config file found, use pre-made config or fill out template."
	exit 1
fi


echo "Reading config file..."
source "$CONF_FILE_PATH"

#save start time for status check
export ES_START_TIME="$(date +%s)"

if [[ "$ES_REGION" == "" ]]; then
	echo "Region not filled out in template, please fix config and try again."
	exit 1
fi

if [[ "$ES_NODE_NAME" == "" ]]; then
	echo "No node name given in config, please enter a node name and retry."
	exit 1
fi



#export root path/repo name
export ES_REPO_ROOT="${ES_PATH}/${REPO_NAME}"
export ES_REPO_NAME="${REPO_NAME}"



RUNSCRIPTS="${ES_REPO_ROOT}/scripts/run"
for f in $RUNSCRIPTS/*.sh; do

	echo "Running elasticsearch runscript: $f..."
	bash $f

done

