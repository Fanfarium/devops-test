FROM node:20-alpine AS builder
WORKDIR /usr/src/app
RUN apk add --no-cache python3 make g++ git
COPY package.json package-lock.json ./
RUN npm ci
COPY tsconfig.json tsconfig.build.json nest-cli.json ./
COPY src ./src
COPY test ./test
RUN npm run build
RUN npm prune --production
FROM node:20-alpine AS runner
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
WORKDIR /home/appuser/app
COPY --from=builder /usr/src/app/package.json ./
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/dist ./dist
USER appuser
ENV NODE_ENV=production
EXPOSE 3000
CMD ["node", "dist/main.js"]
