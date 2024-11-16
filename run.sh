#! /bin/env sh

set -eu

./bundle.sh
if [ $? != 0 ]; then
  command echo "failed to bundle."
  exit 1
fi

# test
if [ $# == 0 ]; then
  ./test.sh

# test debug 
elif [ $# == 1 ] && [ $1 == "t" ]; then
  ./test.sh

# test release
elif [ $# == 1 ] && [ $1 == "tr" ]; then
  ./test.sh r

# run debug
elif [ $# == 1 ] && [ $1 == "r" ]; then
  cargo run --package submission

# run release
elif [ $# == 1 ] && [ $1 == "rr" ]; then
  cargo run --release --package submission

# build debug
elif [ $# == 1 ] && [ $1 == "b" ]; then
  cargo build --package submission

# buid release
elif [ $# == 1 ] && [ $1 == "br" ]; then
  cargo build --release --package submission

# run debug sample
elif [ $# == 2 ] && [ $1 == "s" ]; then
  bat test/sample-${2}.in
  bat test/sample-${2}.out
  cargo run --package submission < test/sample-${2}.in

# run release sample
elif [ $# == 2 ] && [ $1 == "sr" ]; then
  bat test/sample-${2}.in
  bat test/sample-${2}.out
  cargo run --release --package submission < test/sample-${2}.in

else 
  command echo "invalid argument(s)."
  # TODO: show help
  exit 1
fi
