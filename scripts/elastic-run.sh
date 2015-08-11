rm -r /root/elk/atlantis-elasticsearch/logs/
mkdir /root/elk/atlantis-elasticsearch/logs
/root/elk/atlantis-elasticsearch/elasticsearch-1.7.1/bin/elasticsearch -Des.config=/root/elk/atlantis-elasticsearch/config-files/m1/elasticsearch.yml > logs/out.log 2> logs/err.log &
