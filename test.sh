#! /bin/env sh

set -eu

function debug() {
  cargo build --package submission
  oj t -S -c ./target/debug/submission
}

function release() {
  cargo build --release --package submission
  oj t -S -c ./target/release/submission
}

./bundle.sh
if [ $? != 0 ]; then
  command echo "failed to bundle."
  exit 1
fi

if [ $# == 0 ] || [ $1 == "debug" ] || [ $1 == "d" ]; then
  debug
elif [ $# == 1 ] && ([ $1 == "release" ] || [ $1 == "r" ]); then
  release
else
  command echo "invalid argument(s)."
fi
