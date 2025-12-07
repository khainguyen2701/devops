FROM node:22-alpine as base
RUN corepack enable
WORKDIR /app

FROM base as dependencies
COPY package.json package-lock.json pnpm-lock.yaml yarn.lock ./
RUN pnpm install --frozen-lockfile


FROM base as build
COPY --from=dependencies /app/node_modules ./node_modules
COPY . .
RUN pnpm run build

FROM base as start
COPY --from=build /app/.dist ./dist
EXPOSE 3000
CMD ["sh", "-c", "pnpm run dev --host 0.0.0.0"]