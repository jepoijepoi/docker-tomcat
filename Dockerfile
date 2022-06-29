# FROM tomcat:9.0.8-jre8-alpine
# RUN apk --no-cache --update add ca-certificates openssl fontconfig ttf-dejavu wget
# ENV WAR_URL=""
# COPY run.sh /usr/local/tomcat/bin/run-app.sh
# COPY web.xml /usr/local/tomcat/conf/web.xml
# COPY server.xml /usr/local/tomcat/conf/server.xml
# COPY error.html /usr/local/tomcat/error.html
# CMD ["run-app.sh"]

FROM openjdk:8-jre-alpine

ENV TOMCAT_MAJOR=9 \
    TOMCAT_VERSION=9.0.31

RUN apk --no-cache --update add ca-certificates openssl fontconfig ttf-dejavu wget

RUN apk -U upgrade --update && \
    wget -O /tmp/apache-tomcat.tar.gz https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    tar -C /opt -xvf /tmp/apache-tomcat.tar.gz && \
    ln -s /opt/apache-tomcat-${TOMCAT_VERSION}/ /usr/local/tomcat && \
    rm -rf /usr/local/tomcat/webapps/* && \
    rm -rf /tmp/apache-tomcat.tar.gz && \
    addgroup -g 2000 tomcat && \
    adduser -h /usr/local/tomcat -u 2000 -G tomcat -s /bin/sh -D tomcat && \
    mkdir -p /usr/local/tomcat/logs && \
    mkdir -p /usr/local/tomcat/work && \
    chown -R tomcat:tomcat /usr/local/tomcat/ && \
    chmod -R u+wxr /usr/local/tomcat

ENV CATALINA_HOME /usr/local/tomcat/
ENV PATH $CATALINA_HOME/bin:$PATH
ENV TOMCAT_NATIVE_LIBDIR=$CATALINA_HOME/native-jni-lib
ENV LD_LIBRARY_PATH=$CATALINA_HOME/native-jni-lib

WORKDIR $CATALINA_HOME
USER tomcat
EXPOSE 8080

CMD ["catalina.sh", "run"]

ENV WAR_URL=""

COPY run.sh /usr/local/tomcat/bin/run-app.sh
COPY web.xml /usr/local/tomcat/conf/web.xml
COPY server.xml /usr/local/tomcat/conf/server.xml
COPY error.html /usr/local/tomcat/error.html

CMD ["run-app.sh"]
