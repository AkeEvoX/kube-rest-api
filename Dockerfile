#Use offical base image of Java runtime
FROM openjdk:8-jdk-alpine
#Set Volume point to /tmp
VOLUME /tmp
#Make port 8080 available to the world outside container
EXPOSE 88080
#Set application's JAR file
ARG JAR_FILE=target/kube-rest-api.0.0.1-SNAPSHOT
#Add the application's JAR file to the container
ADD ${JAR_FILE} app.jar
#Run the JAR file
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

