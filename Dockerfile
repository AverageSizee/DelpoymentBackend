FROM openjdk:23-jdk AS build
WORKDIR /Backend

COPY . .

# Install Maven
RUN curl -sL https://archive.apache.org/dist/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz | tar xz -C /opt
RUN ln -s /opt/apache-maven-3.8.6/bin/mvn /usr/bin/mvn


# Run Maven build
RUN mvn clean package -DskipTests

FROM openjdk:23-slim
WORKDIR /app
COPY --from=build /app/Backend/target/BackEnd-0.0.1-SNAPSHOT.jar BackEnd.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "BackEnd.jar"]
