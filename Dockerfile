FROM node:24-alpine

RUN apk add --no-cache git curl && npm install -g pnpm

WORKDIR /app

COPY package.json pnpm-lock.yaml ./

# Remove scramjet from package.json since the GitHub release URL is broken,
# then install everything else
RUN node -e "
  const fs = require('fs');
  const pkg = JSON.parse(fs.readFileSync('package.json'));
  delete pkg.dependencies['@mercuryworkshop/scramjet'];
  fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2));
" && pnpm install --prod --no-frozen-lockfile

COPY . .

ENV NODE_ENV=production
EXPOSE 8080
CMD ["node", "index.js"]
