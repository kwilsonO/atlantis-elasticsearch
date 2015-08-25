ESVER="elasticsearch-1.7.1"
ESPATH="/data/elk/atlantis-elasticsearch"
SCRIPTSDIR="${ESPATH}/scripts"
SETUPSCRIPTS="${SCRIPTSDIR}/setup"

for f in $SETUPSCRIPTS/*.sh; do

	sh $f

done
