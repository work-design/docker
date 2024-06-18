FROM ccr.ccs.tencentyun.com/work-design/ruby:x86_64 as base

# Rails App 所在位置
WORKDIR /rails
ENV RAILS_ENV='production' BUNDLE_PATH='/usr/local/bundle'

FROM base as build
RUN apk update && apk add --update --no-cache build-base libpq-dev gcompat git

# 安装 Ruby 依赖
COPY Gemfile Gemfile.lock ./
RUN bundle config mirror.https://rubygems.org https://gems.ruby-china.com
RUN bundle install && rm -rf ~/.bundle/ ${BUNDLE_PATH}/ruby/*/cache ${BUNDLE_PATH}/ruby/*/bundler/gems/*/.git
COPY . .

FROM base
RUN apk update && apk add --update --no-cache curl libgit2 vips tzdata libpq-dev fish

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

RUN chmod +x deploy/entrypoint_rails.sh

EXPOSE 3000

CMD deploy/entrypoint_rails.sh
