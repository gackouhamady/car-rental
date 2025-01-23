# Utiliser une image de base avec JDK 21
FROM openjdk:21-oracle

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier tous les fichiers du répertoire local vers le répertoire de travail dans le conteneur
COPY . /app

# Donner les permissions d'exécution à gradlew
RUN chmod +x /app/gradlew

# Exécuter gradlew avec un argument qui garde le conteneur actif (par exemple, démarrer un serveur ou une tâche longue)
ENTRYPOINT ["./gradlew", "build"]
