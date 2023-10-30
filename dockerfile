# Use an official Maven image as the build environment
FROM maven:3.8.1-jdk-8 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the Maven POM file and download project dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the source code to the container
COPY src ./src

# Build the application
RUN mvn clean package

# Create a new image for the runtime environment
FROM openjdk:8-jre-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the compiled JAR file from the build stage
COPY --from=build /app/target/maven-web-application-0.0.1-SNAPSHOT.war app.war

# Expose port 8080 for the application
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "app.war"]
