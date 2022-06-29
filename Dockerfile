FROM tomcat:9.0.8-jre8-alpine
RUN apk --no-cache --update add ca-certificates openssl fontconfig ttf-dejavu wget
ENV WAR_URL=""
COPY run.sh /usr/local/tomcat/bin/run-app.sh
COPY web.xml /usr/local/tomcat/conf/web.xml
COPY server.xml /usr/local/tomcat/conf/server.xml
COPY error.html /usr/local/tomcat/error.html
CMD ["run-app.sh"]