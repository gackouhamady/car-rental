FROM openjdk:21-oracle


WORKDIR /car-rental

COPY . /app


RUN chmod +x /app/gradlew

# Définir le point d'entrée (facultatif, mais vous pouvez l'utiliser pour démarrer l'application)
ENTRYPOINT ["./gradlew"]
