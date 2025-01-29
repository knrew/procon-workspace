#! /bin/env sh

set -eu

# build
if [ $# == 0 ] || [ $1 == "d" ]; then
  cargo build --bin main

# build(release)
elif [ $# == 1 ] && [ $1 == "r" ]; then
  cargo build --release --bin main

# build submission
elif [ $# == 1 ] && [ $1 == "s" ]; then
  ./bundle.sh
  cargo build --package submission

# build submission(release)
elif [ $# == 1 ] && [ $1 == "sr" ]; then
  ./bundle.sh
  cargo build --release --package submission
 
else 
  command echo "invalid argument(s)."
  exit 1
fi
