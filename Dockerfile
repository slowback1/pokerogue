﻿FROM node:18-buster AS build

WORKDIR /app
COPY package.json .
COPY package-lock.json .

RUN npm install

COPY . .

RUN npm run build


FROM nginx:1.21.3

COPY --from=build /app/dist /usr/share/nginx/html
COPY --from=build /app/.env /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]




