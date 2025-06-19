#! /bin/env sh

set -eu

# build
if [ $# == 0 ] || [ $1 == "d" ]; then
  cargo build --bin main

# build(release)
elif [ $# == 1 ] && [ $1 == "r" ]; then
  cargo build --release --bin main

# build submission(release)
elif [ $# == 1 ] && ( [ $1 == "s" ] || [ $1 == "sub" ] ); then
  ./bundle.sh
  cargo build --release --package submission
 
else 
  command echo "invalid argument(s)." >&2
  exit 1
fi
