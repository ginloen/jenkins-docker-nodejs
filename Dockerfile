FROM node:18

WORKDIR /usr/src/app
COPY [ "index.js", "package-lock.json", "package.json", "./" ]

RUN npm install

EXPOSE 3000
CMD [ "node", "index.js" ]