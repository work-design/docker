FROM ruby:3.1.1-alpine as build
RUN apk add --update --no-cache build-base git fish nodejs yarn postgresql-dev libxml2-dev libxslt-dev tzdata

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# 安装 Ruby 依赖
COPY Gemfile* $APP_HOME/
COPY vendor/gems $APP_HOME/vendor/gems/
RUN bundle config set --local path 'vendor/bundle'
RUN bundle install

# 安装 Node.js 依赖
COPY package.json yarn.lock .npmrc $APP_HOME/
RUN yarn install --check-files

# 编译 assets 并于完成后清理依赖
COPY . $APP_HOME
RUN bin/vite build # 预先编译前端
RUN rm -rf $APP_HOME/node_modules

FROM ruby:3.1.1-alpine
RUN apk add --update --no-cache postgresql-dev libxml2-dev libxslt-dev tzdata libgit2 cmake fish
COPY --from=build /app /app
WORKDIR /app
RUN bundle config set --local path 'vendor/bundle'

RUN chmod +x docker/entrypoint_rails.sh
CMD docker/entrypoint_rails.sh
