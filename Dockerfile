# Dockerfile
FROM node:18-alpine

WORKDIR /usr/src/app

# Copie les fichiers de dépendances
COPY package*.json ./

# Installation des dépendances
RUN npm ci --only=production

# Copie du code source
COPY . .

# Expose le port (ajustez selon votre application)
EXPOSE 3000

# Commande de démarrage
CMD ["npm", "start"]
