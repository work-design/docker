#!/bin/sh

RAILS_ENV=production bin/rails db:prepare
RAILS_ENV=production bin/rails db:migrate
rm -f tmp/pids/server.pid
bin/rails s -b 0.0.0.0 -e production
