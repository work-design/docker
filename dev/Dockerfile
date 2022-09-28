FROM ruby:3.1-alpine
RUN apk add --update --no-cache build-base libc6-compat git bash fish nodejs yarn postgresql-dev libxml2-dev libxslt-dev tzdata
RUN gem install foreman

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# 安装 Ruby 依赖
COPY Gemfile* $APP_HOME/
RUN bundle config set --local path 'vendor/bundle'
RUN bundle install

# 安装 Node.js 依赖
COPY package.json yarn.lock $APP_HOME/
RUN yarn install --check-files

COPY . $APP_HOME

RUN chmod +x docker/entrypoint_rails.sh
CMD docker/entrypoint_rails.sh
