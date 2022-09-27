#!/bin/sh

bin/rails db:prepare
bin/rails db:migrate
rm -f tmp/pids/server.pid
bin/dev
