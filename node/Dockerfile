FROM alpine:3.15

RUN apk add --update --no-cache nodejs npm
RUN npm install -g pnpm

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY package.json pnpm-lock.yaml .npmrc* $APP_HOME/
RUN pnpm install

COPY . $APP_HOME

RUN chmod +x docker/entrypoint_node.sh
CMD docker/entrypoint_node.sh
