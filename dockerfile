FROM openjdk:8
ARG JAR_FILE=target/AeroplaneReservation-0.0.1-SNAPSHOT.jar
ADD ${JAR_FILE} flight.jar
EXPOSE 8082
ENTRYPOINT ["java","-jar","flight.jar"]

