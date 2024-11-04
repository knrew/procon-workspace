#! /bin/env sh

set -eu

function debug() {
  cargo build --package submission
  oj t -S -c ./target/debug/submission
}

function release() {
  cargo build --package submission --release
  oj t -S -c ./target/release/submission
}

./bundle.sh

if [ $# == 0 ] || [ $1 == "d" ] || [ $1 == "debug" ]; then
  debug
elif [ $# == 1 ] && ([ $1 == "r" ] || [ $1 == "release" ]); then
  release
else
  command echo "invalid argument(s)."
fi
