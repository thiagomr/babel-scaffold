FROM mhart/alpine-node:10

WORKDIR /src

COPY package.json /src
RUN npm install
ADD . .

RUN apk add --update tzdata
ENV TZ=America/Sao_Paulo
RUN rm -rf /var/cache/apk/*

EXPOSE 80

CMD ["npm", "start"]
