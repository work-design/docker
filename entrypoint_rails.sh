#!/bin/sh -e

bin/rails db:prepare
rm -f tmp/pids/server.pid
bin/rails s -b 0.0.0.0
