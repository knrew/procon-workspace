#! /bin/env sh

set -eu

if [ $# != 1 ]; then
  command echo "invalid argument(s)." >&2
  command echo "input URL." >&2
  exit 1
fi

if [ -e ./test ]; then
  command rm -rf ./test
fi

if [ -e ./.url.txt ]; then
  command rm ./.url.txt
fi

url=$1

command echo $url > ./.url.txt 
oj download $url
