FROM openjdk:17
RUN mvn clean package
COPY ./target/viajabara-1.jar app.jar
EXPOSE 8090
CMD ["java", "-jar", "app.jar"]
