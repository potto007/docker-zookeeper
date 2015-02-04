# About

Docker image which lets you run Zookeeper containers on single/cluster mode with environment variables.
You can either run :
- a single zookeeper server on a single host with docker
- a cluster of zookeeper servers on a single host with docker
- a cluster of zookeeper servers on many hosts with docker

The image launches a script which generates zookeeper configuration files (zoo.cfg + myid) from environment variables before running zookeeper server.

# Usage

Simply run a single zookeeper on your development machine
> docker run -dtP ybrdx/zookeeper

or from the Gihub [repo](https://github.com/ybr/docker-zookeeper)
> fig up -d

## boot2docker (cluster & single host)

ZK1
> docker run -dtP -e "ID=1" -e "SERVER_1=192.168.59.103:49010:49011" -e "SERVER_2=192.168.59.103:49020:49021" -e "SERVER_3=192.168.59.103:49030:49031" -p 49010:2888 -p 49011:3888  ybrdx/zookeeper

ZK2
> docker run -dtP -e "ID=2" -e "SERVER_1=192.168.59.103:49010:49011" -e "SERVER_2=192.168.59.103:49020:49021" -e "SERVER_3=192.168.59.103:49030:49031" -p 49020:2888 -p 49021:3888  ybrdx/zookeeper

ZK3
> docker run -dtP -e "ID=3" -e "SERVER_1=192.168.59.103:49010:49011" -e "SERVER_2=192.168.59.103:49020:49021" -e "SERVER_3=192.168.59.103:49030:49031" -p 49030:2888 -p 49031:3888  ybrdx/zookeeper

## AWS (cluster & 3 EC2)

ZK1
> docker run -dt -e "ID=1" -e "SERVER_1=zk1:2888:3888" -e "SERVER_2=zk2:2888:3888" -e SERVER_3="zk3:2888:3888" -p 2181:2181 -p 2888:2888 -p 3888:3888  ybrdx/zookeeper

ZK2
> docker run -dt -e "ID=2" -e "SERVER_1=zk1:2888:3888" -e "SERVER_2=zk2:2888:3888" -e SERVER_3="zk3:2888:3888" -p 2181:2181 -p 2888:2888 -p 3888:3888  ybrdx/zookeeper

ZK3
> docker run -dt -e "ID=3" -e "SERVER_1=zk1:2888:3888" -e "SERVER_2=zk2:2888:3888" -e SERVER_3="zk3:2888:3888" -p 2181:2181 -p 2888:2888 -p 3888:3888  ybrdx/zookeeper

# Options

The container can be configured via environment variables:

| Environment Variable | Zookeeper Property | Default |
| -------------------- | ------------------ | --------|
| ```ID``` | N/A | ```1``` |
| ```TICK_TIME``` | ```tickTime``` | ```2000``` |
| ```INIT_LIMIT``` | ```initLimit``` | ```10``` |
| ```SYNC_LIMIT``` | ```syncLimit``` | ```5``` |
| ```CLIENT_CNXNS``` | ```maxClientCnxns``` | ```60``` |
| ```AUTOPURGE_SNAP_RETAIN_COUNT``` | ```autopurge.snapRetainCount``` | ```3``` |
| ```AUTOPURGE_PURGE_INTERVAL``` | ```autopurge.purgeInterval``` | ```0``` |

So, if you are happy with the default, just run the container to get Zookeeper in standalone mode.

To run a cluster just set more ```SERVER_X``` environment variables (replace ```X``` with the respective id) set to the respective ip:port1:port2.

# Additional Software

* [Apache ZooKeeper](http://zookeeper.apache.org/)
