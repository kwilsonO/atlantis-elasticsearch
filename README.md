# atlantis-elasticsearch

A pre-configured repo for use of elastic search in atlantis testflight.

The easiest way to do it:

	- sudo apt-get install git
	- clone this repo into /data/atlantis/elasticsearch (can use a different path, see setup options)
	- cd /data/atlantis/elasticsearch; bash setup.sh -R us-east-1 (or eu-west-1, etc)
	- cd /data/atlantis/elasticsearch; bash run.sh


To use a pre-written config file:

	- sudo apt-get install git
	- clone this repo into /data/atlantis/elasticsearch 
	- cd /data/atlantis/elasticsearch
	- bash setup.sh /path/to/atlantis.config (path to your config should be the 1 and only arg)
	- bash run.sh /path/to/atlantis.config (again one and only arg)

