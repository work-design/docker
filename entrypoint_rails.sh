#!/bin/sh

bin/rails db:prepare
bin/rails g rails_com:migrations
bin/rails db:migrate
rm -f tmp/pids/server.pid
bin/rails s -b 0.0.0.0
