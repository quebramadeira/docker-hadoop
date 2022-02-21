FROM centos
MAINTAINER Alexander Nemchinov <quantumrods@gmail.com>
RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum -y update && yum -y remove java && yum install -y  java-1.8.0-openjdk
COPY hadoop-3.1.2.tar.gz /opt
RUN cd /opt && tar -xf hadoop-3.1.2.tar.gz && mkdir /usr/local/hadoop &&  ln -s /opt/hadoop-3.1.2/ /usr/local/hadoop/current
COPY config/hadoop-env.sh config/core-site.xml config/hdfs-site.xml config/yarn-site.xml /usr/local/hadoop/current/etc/hadoop/
WORKDIR /usr/local/hadoop/current/etc/hadoop
RUN sed -i 's:%PATH_TO_OPENJDK8_INSTALLATION%:/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.312.b07-2.el8_5.x86_64/jre:g' hadoop-env.sh
RUN sed -i 's:%PATH_TO_HADOOP_INSTALLATION:/usr/local/hadoop/current:g' hadoop-env.sh
RUN sed -i 's:%HADOOP_HEAP_SIZE%:512M:g' hadoop-env.sh
RUN sed -i 's:%HDFS_NAMENODE_HOSTNAME%:headnode:g' core-site.xml
RUN sed -i 's:%NAMENODE_DIRS%:/opt/mount1/namenode-dir,/opt/mount2/namenode-dir:g' hdfs-site.xml
RUN sed -i 's:%DATANODE_DIRS%:/opt/mount1/datanode-dir,/opt/mount2/datanode-dir:g' hdfs-site.xml
RUN sed -i 's:%YARN_RESOURCE_MANAGER_HOSTNAME%:headnode:g' yarn-site.xml
RUN sed -i 's:%NODE_MANAGER_LOCAL_DIR%:/opt/mount1/nodemanager-local-dir,/opt/mount2/nodemanager-local-dir:g' yarn-site.xml
RUN sed -i 's:%NODE_MANAGER_LOG_DIR%:/opt/mount1/nodemanager-log-dir,/opt/mount2/nodemanager-log-dir:g' yarn-site.xml
ENV HADOOP_HOME="/usr/local/hadoop/current"
RUN groupadd -g 4000 hadoop && useradd -g hadoop -u 1500 hadoop && useradd -g hadoop -u 1600 yarn && useradd -g hadoop -u 1700 hdfs
RUN mkdir /opt/hadoop-3.1.2/logs && chown :hadoop /opt/hadoop-3.1.2/logs && setfacl -d -R -m g:hadoop:rwx /opt/hadoop-3.1.2/logs && setfacl -R -m g:hadoop:rwx /opt/hadoop-3.1.2/logs
RUN mkdir -p /opt/mount1/datanode-dir %% mkdir -p /opt/mount2/datanode-dir 
RUN chown hdfs:hadoop /opt/mount1/datanode-dir && chown hdfs:hadoop /opt/mount2/datanode-dir
RUN mkdir -p /opt/mount1/nodemanager-local-dir && mkdir -p /opt/mount2/nodemanager-local-dir &&  mkdir -p /opt/mount1/nodemanager-log-dir && mkdir -p /opt/mount2/nodemanager-log-dir
RUN chown yarn:hadoop /opt/mount1/nodemanager-local-dir && chown yarn:hadoop /opt/mount2/nodemanager-local-dir && chown yarn:hadoop /opt/mount1/nodemanager-log-dir && chown yarn:hadoop /opt/mount2/nodemanager-log-dir
VOLUME /opt/mount1 opt/mount2
COPY runworker.sh /runworker.sh
RUN chmod a+x /runworker.sh
CMD ["/runworker.sh"]
