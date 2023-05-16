#!/bin/sh -e

if [ "${*}" == "bin/rails s" ]; then
  bin/rails db:prepare
fi

exec "${@}"
