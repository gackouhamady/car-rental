# Utiliser une image de base avec JDK 21
FROM openjdk:21-oracle

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier tous les fichiers du répertoire local vers le répertoire de travail dans le conteneur
COPY . /app

# Donner les permissions d'exécution à gradlew
RUN chmod +x /app/gradlew

# Exécuter gradlew lors du lancement du conteneur (optionnel)
ENTRYPOINT ["./gradlew"]
