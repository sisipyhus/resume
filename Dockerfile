FROM node:14-alpine AS Builder

WORKDIR /code

COPY ./public /code

FROM nginx:alpine

COPY --from=Builder /code/public/ /usr/share/nginx/html/


