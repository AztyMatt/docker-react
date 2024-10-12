#Build phase
FROM node:16-alpine as builder

WORKDIR /app

COPY package.json .
RUN npm install
COPY . .

RUN npm run build

#Run phase
FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html

# L'image Nginx intègre déjà le lancement de Nginx