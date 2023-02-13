## build stage
FROM node:lts-alpine as build-stage

WORKDIR /app

COPY package*.json ./

RUN npm i -g @quasar/cli

RUN npm ci

COPY . .

RUN quasar build

## production stage

FROM nginx:stable-alpine as production-stage

COPY --from=build-stage /app/dist/spa /usr/share/nginx/html

# COPY add.conf /etc

EXPOSE 3000

CMD ["nginx", "-g","daemon off;"]