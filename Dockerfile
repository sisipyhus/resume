FROM node:14-alpine AS Builder

WORKDIR /code

COPY . /code

RUN npm config set https://npm.taobao.org/mirrors && npm i puppeteer&&npm install && npm build

FROM nginx:alpine

COPY --from=Builder /code/public/ /usr/share/nginx/html/


