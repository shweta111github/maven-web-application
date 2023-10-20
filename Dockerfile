FROM maven:3.9.5
EXPOSE 8080
ADD target/docker-maven-web-application.jar docker-maven-web-application-sample.jar
