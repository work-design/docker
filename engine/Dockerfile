FROM ruby:3.0.2-alpine as build
RUN apk update && apk upgrade
RUN apk add --update --no-cache build-base git nodejs yarn postgresql-dev libxml2-dev libxslt-dev tzdata

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# 安装 Ruby 依赖
COPY Gemfile* package.gemspec $APP_HOME/
RUN bundle config set --local path 'vendor/bundle'
RUN bundle install

# 安装 Node.js 依赖
COPY test/dummy/package.json test/dummy/yarn.lock $APP_HOME/test/dummy/
RUN yarn install --cwd test/dummy --check-files

# 编译静态资源，并于完成后清理依赖
COPY . $APP_HOME
RUN bin/vite build
RUN rm -rf $APP_HOME/test/dummy/node_modules

FROM ruby:3.0.2-alpine
RUN apk --update add --no-cache postgresql-dev libxml2-dev libxslt-dev tzdata
COPY --from=build /app /app
WORKDIR /app
RUN bundle config set --local path 'vendor/bundle'
RUN chmod +x docker/entrypoint.sh

EXPOSE 3000:3000
CMD docker/entrypoint.sh
