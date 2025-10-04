## Install zabbix basing on the official documentation file

https://www.zabbix.com/documentation/current/manual/installation/containers

https://github.com/zabbix/zabbix-docker

### Default user for WWW is:
`Admin:zabbix`

## Configure local zabbix-agent to collect data
Change the address of localhost zabbix agent from 127.0.0.1 to **<?>** And make it work (it should be marked as Available).

As a result you should see some data in Graphs.

http://127.0.0.1/zabbix.php?action=charts.view&view_as=showgraph&filter_search_type=0&filter_hostids%5B%5D=10084&filter_set=1

**Please not that the link may vary**