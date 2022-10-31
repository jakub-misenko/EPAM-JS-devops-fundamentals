# Local build
FROM node:18-alpine As dev

WORKDIR /usr/src/app
COPY --chown=node:node package.json ./
COPY --chown=node:node package-lock.json ./
RUN npm ci
COPY --chown=node:node . .

USER node

# Production build
FROM node:18-alpine As prod
ENV NODE_ENV production

WORKDIR /usr/src/app
COPY --chown=node:node package.json ./
COPY --chown=node:node package-lock.json ./
COPY --chown=node:node --from=dev /usr/src/app/node_modules ./node_modules
COPY --chown=node:node . .

RUN npm run build
RUN npm ci --only=production && npm cache clean --force
USER node

CMD [ "node", "dist/main.js" ]