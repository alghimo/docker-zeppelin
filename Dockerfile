FROM sequenceiq/spark:1.6.0
MAINTAINER Albert Giménez <albert.gimenez.morales@gmail.com>

RUN mkdir -p /tmp/mvn

WORKDIR /tmp/mvn

RUN \
  curl -O http://www.eu.apache.org/dist/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz && \
  tar -xvf apache-maven-3.3.3-bin.tar.gz && \
  mkdir /usr/maven && \
  mv apache-maven-3.3.3 /usr/maven && \
  ln -s /usr/maven/apache-maven-3.3.3 /usr/maven/default && \
  alternatives --install "/usr/bin/mvn" "mvn" "/usr/maven/default/bin/mvn" 99999

RUN yum install -y git
RUN curl --silent --location https://rpm.nodesource.com/setup_4.x | bash -
RUN yum install -y nodejs

RUN git clone https://github.com/apache/incubator-zeppelin.git /zeppelin

WORKDIR /zeppelin

RUN mvn clean package -Pspark-1.6 -Dhadoop.version=2.6.0 -Phadoop-2.6 -DskipTests

ENV ZEPPELIN_PORT 9995
EXPOSE 9995

COPY zeppelin-env.sh /zeppelin/conf/zeppelin-env.sh
COPY shiro.ini /zeppelin/conf/shiro.ini
COPY bootstrap.sh /etc/bootstrap.sh

ENTRYPOINT ["/etc/bootstrap.sh"]
