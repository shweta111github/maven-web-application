node ('nodes'){
def mavenHome = tool name: 'maven3.8.5'
echo "the job name is: ${env.JOB_NAME}"
echo "the build number is: ${env.BUILD_NUMBER}"
echo "the node name is: ${env.NODE_NAME}"
  properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '5', daysToKeepStr: '', numToKeepStr: '5')), [$class: 'JobLocalConfiguration', changeReasonComment: ''], pipelineTriggers([pollSCM('* * * * *')])])
try
{
  //CheckoutCode from git
stage('CheckoutCode'){
  sendSlackNotification("STARTED")
git branch: 'development', credentialsId: '3618ffee-d89b-42a7-95c6-644de0cd31b4', url: 'https://github.com/citibank-DevOps/maven-web-application.git'
}
//Build
stage('Build')
{
  sh "${mavenHome}/bin/mvn clean package"
}
//Execute SonarQube report
stage('ExecuteSonarQubeReport')
{
 sh "${mavenHome}/bin/mvn sonar:sonar"
}
/*
//UploadArtifacts into Nexus
stage('UploadArtifactsIntoNexus')
{
 sh "${mavenHome}/bin/mvn deploy" 
}
//Deploy application into tomcat server
stage('DeployApp')
{
sshagent(['35bd916b-b69a-4325-bbe8-4a19b884c335']) {
    sh "scp -o StrictHostKeyChecking=no target/maven-web-application.war ec2-user@172.31.3.157:/opt/apache-tomcat-9.0.70/webapps"
}
}*/
}
catch(e)
{
currentBuild.result="FAILURE"
}
finally
{
sendSlackNotification(currentBuild.result)
}
}//node closing
def sendSlackNotification(String buildStatus = 'STARTED') {
  // build status of null means successful
  buildStatus =  buildStatus ?: 'SUCCESSFUL'

  // Default values
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
  def summary = "${subject} (${env.BUILD_URL})"

  // Override default values based on build status
  if (buildStatus == 'STARTED') {
    color = 'BLUE'
    colorCode = '#0000FF'
  } else if (buildStatus == 'SUCCESSFUL') {
    color = 'GREEN'
    colorCode = '#00FF00'
  } else {
    color = 'RED'
    colorCode = '#FF0000'
  }

  // Send notifications
  slackSend (color: colorCode, message: summary)
}
