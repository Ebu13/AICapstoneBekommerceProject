# Temel görüntü olarak OpenJDK 23 kullanıyoruz
FROM openjdk:23-jdk-slim AS build

# Maven için gerekli dosyaları kopyalıyoruz
WORKDIR /app
COPY pom.xml .

# Maven bağımlılıklarını indiriyoruz
RUN apt-get update && apt-get install -y wget && \
    wget -q -O /tmp/maven.tar.gz https://archive.apache.org/dist/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz && \
    tar -xvzf /tmp/maven.tar.gz -C /opt && \
    ln -s /opt/apache-maven-3.8.6/bin/mvn /usr/bin/mvn && \
    mvn dependency:resolve

# Uygulamanın kaynak kodlarını kopyalıyoruz
COPY src ./src

# Uygulamayı derliyoruz
RUN mvn clean package -DskipTests

# Uygulama çalıştırmak için ikinci aşamaya geçiyoruz
FROM openjdk:23-jdk-slim

# Derlenen JAR dosyasını kopyalıyoruz
WORKDIR /app
COPY --from=build /app/target/backend-0.0.1-SNAPSHOT.jar /app/backend.jar

# Uygulama çalıştırma komutu
ENTRYPOINT ["java", "-jar", "/app/backend.jar"]

# Uygulama için gerekli portu açıyoruz
EXPOSE 8081
