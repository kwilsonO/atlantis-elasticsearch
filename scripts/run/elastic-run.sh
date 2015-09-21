#read config file
source "${ES_REPO_ROOT}/config/atlantis/atlantis.config"

ESCONFIGDIR="${ES_REPO_ROOT}/config/elasticsearch"
NODEROOTDIR="${ES_REPO_ROOT}/elasticsearch-${ES_VERSION}"
NODECONFIGDIR="${NODEROOTDIR}/config"

declare -A NODEDATA
NODEDATA["@CLUSTERNAME@"]="${ES_CLUSTER_NAME}"
NODEDATA["@NODENAME@"]="${ES_NODE_NAME}"
NODEDATA["@REGION@"]="${ES_REGION}"

if [ -e "${NODECONFIGDIR}/elasticsearch.yml" ]; then
	echo "Removing old config file..."
	rm "${NODECONFIGDIR}/elasticsearch.yml"
fi

#copy a fresh template
echo "Copying fresh template nd inserting values..."
cp "${ESCONFIGDIR}/templates/elasticsearch.yml.template" ${NODECONFIGDIR}/elasticsearch.yml

#insert node data
for i in "${!NODEDATA[@]}"
do
	SEDSTR="s|${i}|${NODEDATA[${i}]}|g"
	sed -i $SEDSTR ${NODECONFIGDIR}/elasticsearch.yml
done

#delete old log files
if [ -e "${ES_LOG_PATH}/*" ]; then
	rm $ES_LOG_PATH/*
fi

$NODEROOTDIR/bin/elasticsearch -Des.config=$NODECONFIGDIR/elasticsearch.yml > $ES_LOG_PATH/out.log 2> $ES_LOG_PATH/err.log &
