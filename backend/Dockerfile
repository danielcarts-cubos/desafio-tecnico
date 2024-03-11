# FROM node:20-alpine3.19
FROM node@sha256:f4c96a28c0b2d8981664e03f461c2677152cd9a756012ffa8e2c6727427c2bda

LABEL maintainer="dcsouza@dcc.ufrj.br"

WORKDIR /home/node/app

COPY package.json package-lock.json /home/node/app/

RUN yarn install --immutable

COPY index.js /home/node/app/

CMD ["node", "/home/node/app/index.js"]