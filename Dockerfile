FROM openjdk:11

RUN addgroup --system spring && adduser --system spring
USER spring:spring

COPY ./build/libs/*-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","/app.jar"]