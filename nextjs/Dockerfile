FROM node:22-alpine AS builder

WORKDIR /usr/src/app

COPY package.json package-lock.json* yarn.lock* ./

COPY . .

RUN yarn install --frozen-lockfile

RUN yarn build

FROM node:22-alpine

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/.next ./.next

COPY --from=builder /usr/src/app/node_modules ./node_modules

COPY --from=builder /usr/src/app/package.json ./package.json

EXPOSE 3000

CMD ["yarn", "start", "--", "-H", "0.0.0.0", "-p", "3000"]
