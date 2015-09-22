CONF_FILE_PATH="config/atlantis/atlantis.config"
REPO_NAME="atlantis-elasticsearch"


usage()
{

cat <<-EOF
	usage: $0 options
	
	This script builds a config file with the passed info sets up elastic search.

	Options:
		Default:
		-R	The region this elastic search node will service (us-east-1, eu-west-1, etc)
		-n	The node name of this node (usually master{1..3})
		-c	The cluster name that this node is apart of (usually elasticsearch-atlantis)
		
		Additional:
		-p	The path to the elasticsearch install (default /data/atlantis/elasticserach)
		-o	The path for elasticsearch to log to (default /var/log/atlantis/elasticsearch)	
		-v	The elastic search version to install (default 1.7.1)
		-u	ES download url(def: download.elastic.co/elasticsearch/elasticsearch/elasticsearch-\${ES_VERSION}.tar.gz)

		Non-Config Related:
		-b	Build config but don't start setup
		-h	Show this message
		
	EOF
}


if [ $# -ne 0 ]; then
	OPTREGION=""
	OPTNAME="$(uname -n)"
	OPTCLUSTER="atlantis-elasticsearch"
	OPTPATH="/data/atlantis/elasticsearch"
	OPTLOGPATH="/var/log/atlantis/elasticsearch"
	OPTVERSION="1.7.1"
	OPTDLURL="https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-\${ES_VERSION}.tar.gz"
	OPTBUILDONLY=""

	while getopts R:n:c:p:o:v:u:bh opt; do
		#if non empty str or health flag/build flag
		if [ "${OPTARG}" != "" ] || [ "${opt}" == "h" ] || [ "${opt}" == "b" ]; then

			case $opt in
				R)
					OPTREGION=$OPTARG
					;;
				n)
					OPTNAME=$OPTARG
					;;
				c)
					OPTCLUSTER=$OPTARG
					;;
				p)
					OPTPATH=$OPTARG
					;;
				o)
					OPTLOGPATH=$OPTARG
					;;
				v)
					OPTVERSION=$OPTARG
					;;
				u)
					OPTDLURL=$OPTARG
					;;
				b)
					OPTBUILDONLY="true"
					;;
				h)
					usage
					exit 0
					;;
				\?)
					echo "Option ${opt} not recognized..."
					exit 1
			esac
		fi
	done

	if [[ "${OPTREGION}" == "" ]]; then
		echo "No region specified please enter a region to the -R flag"
		exit 1
	fi

	if [[ "${OPTNAME}" == "" ]]; then
		echo "No node name specified please enter a node name to the -n flag"
		exit 1
	fi

	if [[ "${OPTCLUSTER}" == "" ]]; then
		echo "No cluster name entered please enter a cluster name to -c"
		exit 1
	fi

	OPTPATHROOT=""
	OPTTEMPLATEDIR=""
	if [[ "${OPTPATH}" == "" ]]; then
		OPTPATHROOT="/data/atlantis/elasticsearch"
		OPTPATH="${OPTPATHROOT}/${REPO_NAME}"
	else
		OPTPATHROOT="${OPTPATH}"
		OPTPATH="${OPTPATH}/${REPO_NAME}"
	fi

	OPTTEMPLATEDIR="${OPTPATH}/config/atlantis/templates"
	if [[ ! -d $OPTTEMPLATEDIR ]]; then
		echo "Directory $OPTTEMPLATEDIR does not exist please fix config"
		exit 1
	fi
	
	#save old config isntead of overwrite
	if [[ -f $CONF_FILE_PATH ]]; then
		echo "Found existing atlantis.config, renaming to avoid deletion.."
		DATESTR=$(date +%m-%d-%y_%H-%M-%S)
		mv $CONF_FILE_PATH "$OPTPATH/config/atlantis/atlantis.config-${DATESTR}"
	fi

	OPTCONFPATH="${OPTPATH}/config/atlantis"	
	OPTCONFTMPPATH="${OPTCONFPATH}/templates"

	#cp templte to root
	cp "${OPTCONFTMPPATH}/atlantis.config.template" "${OPTCONFPATH}/atlantis.config"

	#find and replace vars in config
	sed -i -E "s|ES_PATH=\".+?\"|ES_PATH=\"${OPTPATHROOT}\"|g" "${OPTCONFPATH}/atlantis.config"
	sed -i -E "s|ES_LOG_PATH=\".+?\"|ES_LOG_PATH=\"${OPTLOGPATH}\"|g" "${OPTCONFPATH}/atlantis.config"
	sed -i -E "s|ES_VERSION=\".+?\"|ES_VERSION=\"${OPTVERSION}\"|g" "${OPTCONFPATH}/atlantis.config"
	sed -i -E "s|ES_DL_URL=\".+?\"|ES_DL_URL=\"${OPTDLURL}\"|g" "${OPTCONFPATH}/atlantis.config"
	sed -i -E "s|ES_REGION=\".+?\"|ES_REGION=\"${OPTREGION}\"|g" "${OPTCONFPATH}/atlantis.config"
	sed -i -E "s|ES_NODE_NAME=\".+?\"|ES_NODE_NAME=\"${OPTNAME}\"|g" "${OPTCONFPATH}/atlantis.config"
	sed -i -E "s|ES_CLUSTER_NAME=\".+?\"|ES_CLUSTER_NAME=\"${OPTCLUSTER}\"|g" "${OPTCONFPATH}/atlantis.config"

	if [[ "${OPTBUILDONLY}" == "true" ]]; then
		echo "Finished building config and aborting before setup due to -b flag"
		exit 0
	fi
fi


if [[ ! -f $CONF_FILE_PATH ]]; then
		echo "No atlantis config file found, please use a pre-existing configuration or fill in the template."
		exit 1
fi

#read in config
echo "Reading config..."
source $CONF_FILE_PATH


if [[ "${ES_NODE_NAME}" == "" ]]; then
	echo "Node name not set, please enter a node name in config and retry"
	exit 1
fi

#export repo path/name
export ES_REPO_ROOT="${ES_PATH}/${REPO_NAME}"
export ES_REPO_NAME="${REPO_NAME}"


SETUPSCRIPTS="${ES_REPO_ROOT}/scripts/setup"

for f in $SETUPSCRIPTS/*.sh; do

	echo "Executing setup script: $f"
	bash $f

done
