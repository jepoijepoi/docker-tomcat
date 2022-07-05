FROM openjdk:alpine
MAINTAINER Joseph Ganon <joseph.ganon@calgaryparking.com>

# Expose web port
EXPOSE 8080

# Tomcat Version
ENV TOMCAT_VERSION_MAJOR=9 \
    TOMCAT_VERSION_FULL=9.0.64 \
    CATALINA_HOME=/tomcat \
    PATH=/tomcat/bin:$PATH

# Download and install
RUN wget "http://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_VERSION_MAJOR}/v${TOMCAT_VERSION_FULL}/bin/apache-tomcat-${TOMCAT_VERSION_FULL}.tar.gz" &&\
    tar -xzvf apache-tomcat-${TOMCAT_VERSION_FULL}.tar.gz &&\
    rm -f apache-tomcat*.gz &&\
    mv /apache-tomcat* /tomcat &&\
    rm -rf /tomcat/webapps/examples /tomcat/webapps/docs

COPY web.xml /tomcat/conf/web.xml
COPY server.xml /tomcat/conf/server.xml
COPY error.html /tomcat/error.html

ENTRYPOINT ["catalina.sh"]
CMD ["run"]
