#! /bin/env sh

set -eu

./bundle.sh

if [ $# == 2 ] && [ $1 == "s" ]; then 
  bat test/sample-${2}.in
  bat test/sample-${2}.out
  cargo run --package submission < test/sample-${2}.in
elif [ $# == 0 ] || [ $1 == "r" ] || [ $1 == "run" ]; then
  cargo run --package submission
elif [ $# == 1 ] && ([ $1 == "b" ] || [ $1 == "build" ]); then
  cargo build --package submission
else
  command echo "invalid argument(s)."
fi
