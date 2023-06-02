FROM ruby:3.2-alpine
RUN apk update
RUN apk add --update --no-cache build-base libpq-dev libgit2 vips git curl nodejs yarn tzdata fish

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# 安装 Ruby 依赖
COPY Gemfile* $APP_HOME/
RUN bundle config set --local path 'vendor/bundle'
RUN bundle config set --local deployment true
RUN bundle install

# 安装 Node.js 依赖
COPY package.json yarn.lock $APP_HOME/
RUN yarn install --check-files

# 编译 assets 并于完成后清理依赖
COPY . $APP_HOME
RUN rake assets:precompile # 预先编译前端

# 清理不必要的安装
RUN rm -rf $APP_HOME/node_modules
RUN apk del nodejs yarn

RUN chmod +x docker/entrypoint_rails.sh

EXPOSE 3000

CMD docker/entrypoint_rails.sh
