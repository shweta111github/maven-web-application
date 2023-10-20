FROM maven:3.5.4
EXPOSE 8080
ADD target/docker-maven-web-application.jar docker-maven-web-application-sample.jar
