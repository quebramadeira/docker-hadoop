# docker-hadoop
Docker images:
  - quebramadeira/headnode:1.0
  - quebramadeira/worker:1.0

## prerequisites
Docker installed:
  - sudo yum update && sudo yum install yum-utils devicemapper-persistent-data lvm2
  - sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  - sudo yum install -y docker-ce
  - sudo systemctl start docker && sudo systemctl enable docker
Current user belongs to the docker group:
  - sudo usermod -aG docker <username>
Docker compose installed:
  - sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  - sudo chmod +x /usr/local/bin/docker-compose

## quick start
Place to the home directory:
  - config folder with all the contents;
  - headnode folder with all the contents;
  - worker folder with all the contents;
  - hadoop-3.1.2.tar.gz file from https://hadoop.apache.org/release/3.1.2.html

Create docker images from Dockerfiles:
  - docker build -t headnode:1.0 -f headnode/Dockerfile .
  - docker build -t worker:1.0 -f worker/Dockerfile .

Run headnode and worker containers using:
  - docker run -p 8088:8088 -p 9870:9870 --add-host=headnode:192.168.10.2 --add-host=worker:192.168.10.3 --network=hadoop --ip=192.168.10.2 -itd <headnode_image_id>
  - docker run --add-host=headnode:192.168.10.2 --add-host=worker:192.168.10.3 --network=hadoop --ip=192.168.10.3 -itd <worker_image_id>

Or using docker-compose.yml file:
  - docker-compose up -d

After port forwarding HDFS Namenode and YARN Resource Manager interfaces are available at http://localhost:9870/ and http://localhost:8088/ 
