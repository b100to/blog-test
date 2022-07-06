FROM adoptopenjdk/openjdk11:jre-11.0.11_9-alpine

RUN addgroup --system spring && adduser --system spring
USER spring:spring

COPY ./build/libs/*-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","/app.jar"]