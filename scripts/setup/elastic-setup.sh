#read in config file
source "${ES_REPO_ROOT}/config/atlantis/atlantis.config"

wget "$ES_DL_URL"
tar -xzf "elasticsearch-${ES_VERSION}.tar.gz"
rm "elasticsearch-${ES_VERSION}.tar.gz"
rm "${ES_REPO_ROOT}/elasticsearch-${ES_VERSION}/config/logging.yml"
rm "${ES_REPO_ROOT}/elasticsearch-${ES_VERSION}/config/elasticsearch.yml"
cp "${ES_REPO_ROOT}/config/elasticsearch/logging.yml" "${ES_REPO_ROOT}/elasticsearch-${ES_VERSION}/config/"

if [[ ! -d $ES_LOG_PATH ]]; then
	mkdir -p $ES_LOG_PATH
fi
