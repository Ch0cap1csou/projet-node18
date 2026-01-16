FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci

FROM node:18-alpine AS production
WORKDIR /app
COPY package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY . .

RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001 && \
    chown -R nodejs:nodejs /app
USER nodejs

EXPOSE 3000
CMD ["npm", "start"]
