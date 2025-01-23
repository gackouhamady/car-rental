# Utilisez une image de base Java avec JDK 21
FROM eclipse-temurin:21-jdk

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier les fichiers Gradle Wrapper dans le conteneur
COPY gradlew gradlew
COPY gradle gradle

# Copier le fichier build.gradle et settings.gradle
COPY build.gradle settings.gradle ./

# Copier le code source
COPY src src

# Donner les permissions d'exécution au script Gradle Wrapper
RUN chmod +x gradlew

# Télécharger les dépendances Gradle pour éviter de le refaire à chaque build
RUN ./gradlew dependencies --no-daemon

# Construire le projet
RUN ./gradlew build --no-daemon

# Exposer un port si votre application en utilise un (ex. 8080)
EXPOSE 8080

# Commande par défaut pour démarrer l'application
CMD ["java", "-jar", "build/libs/rentalService-0.0.1-SNAPSHOT.jar.jar"]
