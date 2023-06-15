FROM debian:10 AS nodejs-my-website

#LABEL org.opencontainers.image.source https://github.com/plumpqueen/devopsrepo

RUN apt-get update -yq \
&& apt-get install curl gnupg -yq \
&& curl -sL https://deb.nodesource.com/setup_18.x | bash \
&& apt-get install nodejs -yq \
&& apt-get clean -y

# à gauche c'est l'équivalent de notre local (ici .)
# à droite c'est le dossier dans notre image (ici /app/)
ADD . /app/
WORKDIR /app

RUN npm install

RUN npm run build

EXPOSE 3000

COPY docker/ghcr.io/plumpqueen/devopsrepo/nodejs-my-website/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

ENTRYPOINT ["docker-entrypoint"]
CMD npm run start
