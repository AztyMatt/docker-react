#Build phase
FROM node:16-alpine as builder

WORKDIR /app

COPY package.json .
RUN npm install
COPY . .

RUN npm run build

#Run phase
FROM nginx
# A noter que EXPOSE n'expose pas le port, c'est juste utile pour les autres devs. ET pour AWS, afin qu'il sache sur quel port exposer notre app
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

# L'image Nginx intègre déjà le lancement de Nginx