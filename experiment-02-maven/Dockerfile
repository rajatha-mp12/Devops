FROM eclipse-temurin:17-jdk-jammy
LABEL maintainer="DevOps Workshop - Maven"

WORKDIR /app

COPY target/maven-demo-app-1.0.0.jar app.jar

EXPOSE 8080

ENV JAVA_OPTS="-Xmx512m -Xms256m"

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
