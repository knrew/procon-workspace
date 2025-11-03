#! /bin/env sh

set -eu

. ./common.sh

if [ $# != 1 ]; then
  echo "invalid argument(s)." >&2
  echo "input URL." >&2
  exit 1
fi

if [ -e ./test ]; then
  rm -rf ./test
fi

if [ -e ./.url.txt ]; then
  rm ./.url.txt
fi

url=$1

$OJ download "$url"
echo "$url" > ./.url.txt
