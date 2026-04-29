FROM node:24-alpine

RUN apk add --no-cache git && npm install -g pnpm

WORKDIR /app

COPY package.json pnpm-lock.yaml ./
# Copy pre-installed node_modules to skip broken remote fetch
COPY node_modules ./node_modules

COPY . .

ENV NODE_ENV=production
EXPOSE 8080
CMD ["node", "index.js"]
