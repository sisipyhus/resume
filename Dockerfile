FROM node:11-alpine AS Builder

WORKDIR /code

COPY . /code

RUN npm config set registry https://registry.npmmirror.com && npm i puppeteer && npm install && npm run build

FROM nginx:alpine

COPY --from=Builder /code/public/ /usr/share/nginx/html/


