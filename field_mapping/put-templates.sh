HOST="$(cat ~/tstflt-alias/devbox1)"
MAPJSONDIR="/Users/kwilson/work/ooyala/ELK/atlantis-elasticsearch-repos/atlantis-elasticsearch/field_mapping/index-maps"


for f in $MAPJSONDIR/*; do
	index=$(basename "$f")
	echo "Adding template: ${index}..."
	curl -XPUT -H "Content-Type: application/json" $HOST:9200/_template/$index/ -d @"${f}" 
done
