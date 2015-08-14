ESVER="elasticsearch-1.7.1"
LOGPATH="/var/log/atlantis/elasticsearch"
ESPATH="/root/elk/atlantis-elasticsearch"
ESDIR="${ESPATH}/${ESVER}"
ESCONF="${ESPATH}/config-files/m1"

rm $LOGPATH/*
$ESDIR/bin/elasticsearch -Des.config=$ESCONF/elasticsearch.yml > $LOGPATH/out.log 2> $LOGPATH/err.log &
