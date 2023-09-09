#!/usr/bin/env bash

if [[ -e ./MapCycleTemplate.txt && -e ./sandstorm-server/Insurgency/Config/Server/MapCycle.txt  ]]; then
  sort --random-sort < ./MapCycleTemplate.txt > ./server-config/e3edc9f8-fcd7-4bb2-b9d9-f80a8ef27635/MapCycle.txt

fi

wrapper_root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "$wrapper_root"/admin-interface

while true; do
  bundle && bundle exec ruby "$wrapper_root"/admin-interface/lib/webapp.rb "$@"
  CODE=$?
  [ $CODE -eq 2 ] || exit $CODE # Restart if exit code 2
done

