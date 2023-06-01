FROM ruby:3.2-alpine
RUN apk add --update --no-cache --virtual build-base libc6-compat libpq-dev libgit2 vips git nodejs yarn tzdata fish curl cmake glib

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

# 编译 assets 并于完成后清理依赖
COPY . $APP_HOME
RUN rake assets:precompile # 预先编译前端
RUN rm -rf $APP_HOME/node_modules
RUN chmod +x docker/entrypoint_rails.sh

EXPOSE 3000

CMD docker/entrypoint_rails.sh
