FROM openjdk:8-jdk-alpine
MAINTAINER Shreyas Dange 'shreyas.dange22@gmail.com'
ADD ./target/spring-boot-mongodb-0.0.1-SNAPSHOT.jar product-service.jar
RUN sh -c 'touch product-service.jar'
ENTRYPOINT ["java","-jar","product-service.jar"]