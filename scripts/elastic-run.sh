rm -r /root/elk/atlantis-elasticsearch/logs/
mkdir /root/elk/atlantis-elasticsearch/logs
mkdir /var/log/atlantis/elasticsearch/
/root/elk/atlantis-elasticsearch/elasticsearch-1.7.1/bin/elasticsearch -Des.config=/root/elk/atlantis-elasticsearch/config-files/m2/elasticsearch.yml > /var/log/atlantis/elasticsearch/out.log 2> /var/log/atlantis/elasticsearch/err.log &
