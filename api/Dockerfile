FROM ruby:3.0.2-alpine
RUN apk add --update --no-cache build-base git fish postgresql-dev mariadb-dev libxml2-dev libxslt-dev tzdata

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# 安装 Ruby 依赖
COPY Gemfile* $APP_HOME/
RUN bundle config set --local path 'vendor/bundle'
RUN bundle install

COPY . $APP_HOME
RUN chmod +x docker/entrypoint_rails.sh

CMD docker/entrypoint_rails.sh
