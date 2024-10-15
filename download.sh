#! /bin/env sh

set -eu

if [ $# != 1 ]; then
  command echo "invalid argument(s)."
  command echo "input URL."
  exit 1
fi

if [ -e ./test ]; then
  command rm -rf ./test
fi

if [ -e ./.url.txt ]; then
  command rm ./.url.txt
fi

url=$1

oj download $url
command echo $url > ./.url.txt 
