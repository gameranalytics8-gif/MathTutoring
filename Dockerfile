FROM node:24-alpine

RUN apk add --no-cache git && npm install -g pnpm

WORKDIR /app

COPY package.json pnpm-lock.yaml ./

# Remove the broken GitHub tarball entry from the lockfile and reinstall
RUN sed -i '/scramjet/,/^$/d' pnpm-lock.yaml || true && \
    pnpm install --prod --no-frozen-lockfile

COPY . .

ENV NODE_ENV=production
EXPOSE 8080
CMD ["node", "index.js"]
