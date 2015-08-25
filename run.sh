ESVER="elasticsearch-1.7.1"
ESPATH="/data/elk/atlantis-elasticsearch"
SCRIPTSDIR="${ESPATH}/scripts"
RUNSCRIPTS="${SCRIPTSDIR}/run"


for f in $RUNSCRIPTS/*.sh; do

	sh $f

done

