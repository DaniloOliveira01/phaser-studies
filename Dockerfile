FROM node:20.15.0 as build
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY . ./
COPY package.json yarn.lock ./
RUN yarn install
RUN yarn build

FROM 960737719566.dkr.ecr.us-east-1.amazonaws.com/inteegra-nginx:ga-2

COPY --from=build /app/build /usr/share/nginx/html
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY nginx/error.html /usr/share/nginx/html

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]