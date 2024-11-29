FROM maven:3.9.9-eclipse-temurin-23-alpine AS build

WORKDIR /app

COPY pom.xml ./
COPY src ./src

#RUN mvn clean package -DskipTests
RUN mvn clean package

FROM openjdk:23-jdk-slim as production

WORKDIR /app

COPY --from=build /app/target/*.jar batch_system.jar

EXPOSE 8080

CMD ["java", "-jar", "batch_system.jar"]