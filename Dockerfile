FROM ruby:3.2-alpine as base

# Rails App 所在位置
WORKDIR /rails
ENV RAILS_ENV='production' BUNDLE_PATH='/usr/local/bundle'

FROM base as build
RUN apk update && apk add --update --no-cache build-base libpq-dev gcompat git

# 安装 Ruby 依赖
COPY Gemfile Gemfile.lock ./
RUN bundle install && rm -rf ~/.bundle/ ${BUNDLE_PATH}/ruby/*/cache ${BUNDLE_PATH}/ruby/*/bundler/gems/*/.git

FROM base
RUN apk update && apk add --update --no-cache curl libgit2 vips tzdata libpq-dev fish

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

RUN chmod +x docker/entrypoint_rails.sh

EXPOSE 3000

CMD docker/entrypoint_rails.sh
