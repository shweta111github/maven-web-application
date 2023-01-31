node{
def mavenHome = tool name: 'maven3.8.5'
echo "the job name is: ${env.JOB_NAME}"
echo "the build number is: ${env.BUILD_NUMBER}"
echo "the node name is: ${env.NODE_NAME}"
//CheckoutCode from git
stage('CheckoutCode'){
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
}//node closing
