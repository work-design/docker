#!/bin/sh -e

rm -f tmp/pids/server.pid

if [ "${*}" == "bin/rails s" ]; then
  bin/rails db:prepare
fi

exec "${@}"
