#! /bin/env sh

set -eu

./bundle.sh

function debug() {
  cargo build --bin submission
  oj t -S -c ./target/debug/submission
}

function release() {
  cargo build --release --bin submission
  oj t -S -c ./target/release/submission
}

if [ $# == 0 ] || [ $1 == "d" ] || [ $1 == "debug" ]; then
  debug
elif [ $1 == "r" ] || [ $1 == "release" ]; then
  release
else
  command echo "invalid argument(s)."
fi
