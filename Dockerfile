FROM node:14-alpine AS Builder

WORKDIR /code

COPY . /code

RUN npm config set registry https://registry.npmmirror.com && npm install && npm run build

FROM nginx:alpine

COPY --from=Builder /code/public/ /usr/share/nginx/html/


