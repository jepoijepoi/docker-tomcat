WAR_FILE=${WAR_URL:7}
WAR_FILE=${WAR_FILE##*/}
if [ -f "$CATALINA_HOME/webapps/$WAR_FILE" ];
then
  echo "$WAR_FILE downloaded. Ignore."
else
  echo "Downloading war file..."
  wget -P $CATALINA_HOME/webapps/ $WAR_URL
fi
catalina.sh run