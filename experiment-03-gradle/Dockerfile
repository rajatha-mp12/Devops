FROM openjdk:17-jdk-slim
LABEL maintainer="DevOps Workshop - Gradle"

WORKDIR /app

COPY build/libs/gradle-demo-app-1.0.0.jar app.jar

EXPOSE 8080

ENV JAVA_OPTS="-Xmx512m -Xms256m"

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
