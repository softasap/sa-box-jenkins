#!/bin/sh

JENKINS_USER=SPECIFY YOUR USER
JENKINS_TOKEN=SPECIFY YOUR TOKEN

# prepare info file
INFO_FILE_DIR=$( pwd );
INFO_FILE=jenkins.update.info
rm -f $INFO_FILE
# get current version of cli JAR
rm -f jenkins-cli.jar
wget http://127.0.0.1:8080/jnlpJars/jenkins-cli.jar
#JENKINS_CRUMB=$(wget -q --auth-no-challenge --user $JENKINS_USER --password $JENKINS_PASS  --output-document -  'http://127.0.0.1:8080/crumbIssuer/api/json' | jq '(.crumbRequestField + "=" +.crumb)')
#echo $JENKINS_CRUMB
OLD_WAR_VERSION=$( java -jar jenkins-cli.jar -auth $JENKINS_USER:$JENKINS_TOKEN -s http://127.0.0.1:8080/ version);
echo $OLD_WAR_VERSION

# get new Jenkins WAR and copy it
rm -f jenkins.war
wget http://mirrors.jenkins-ci.org/war/latest/jenkins.war
rm -rf META-INF
jar xvf jenkins.war META-INF/MANIFEST
NEW_WAR_VERSION=$( cat META-INF/MANIFEST.MF | grep Jenkins-Version | cut -f 2 -d ' ' | tr -d "\r");
echo '<h2>Jenkins Framework Update Report</h2>'
if [ $OLD_WAR_VERSION = $NEW_WAR_VERSION ]; then
echo '<p><b>No updates</b> were available for the Jenkins WAR file!</p>'
else
sudo service jenkins stop
sudo cp /usr/share/jenkins/jenkins.war /usr/share/jenkins/jenkins.war.$OLD_WAR_VERSION
sudo mv ./jenkins.war /usr/share/jenkins/jenkins.war
sudo service jenkins start
echo '<p>The Jenkins framework has been updated from version <b>'$OLD_WAR_VERSION'</b> to version <b>'$NEW_WAR_VERSION'</b>!</p>'
fi

