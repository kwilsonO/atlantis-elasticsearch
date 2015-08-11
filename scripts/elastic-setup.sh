wget "https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.1.tar.gz"
tar -xzf elasticsearch-1.7.1.tar.gz
rm *.gz
rm /root/elk/atlantis-elasticsearch/elasticsearch-1.7.1/config/logging.yml
rm /root/elk/atlantis-elasticsearch/elasticsearch-1.7.1/config/elasticsearch.yml
cp /root/elk/atlantis-elasticsearch/config-files/logging.yml /root/elk/atlantis-elasticsearch/elasticsearch-1.7.1/config/
