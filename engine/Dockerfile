FROM ruby:3.1-alpine as build
RUN apk add --update --no-cache build-base git nodejs yarn postgresql-dev libxml2-dev libxslt-dev tzdata libgit2 cmake

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
RUN rake assets:precompile
RUN rm -rf $APP_HOME/test/dummy/node_modules

FROM ruby:3.1.1-alpine
RUN apk add --update --no-cache fish postgresql-dev libxml2-dev libxslt-dev tzdata
COPY --from=build /app /app
WORKDIR /app
RUN bundle config set --local path 'vendor/bundle'

RUN chmod +x docker/entrypoint_engine.sh
CMD docker/entrypoint_engine.sh
