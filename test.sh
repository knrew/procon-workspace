#! /bin/env sh

set -eu

# oj test
if [ $# == 0 ] || [ $1 == "d" ]; then
  cargo build --bin main
  oj t -S -c ./target/debug/main

# oj test(release)
elif [ $# == 1 ] && [ $1 == "r" ]; then
  cargo build --release --bin main
  oj t -S -c ./target/release/main

# oj test(submission)
elif [ $# == 1 ] && [ $1 == "sub" ]; then
  ./bundle.sh
  cargo build --release --package submission
  oj t -S -c ./target/release/submission

# run single sample
elif [ $# == 2 ] && [ $1 == "s" ]; then
  if ! [ -f test/sample-${2}.in ]; then
    command echo "\"test/sample-${2}.in\" not found."
    exit 1
  fi 
  bat test/sample-${2}.in
  [[ -f test/sample-${2}.out ]] && bat test/sample-${2}.out
  cargo run < test/sample-${2}.in

# run single sample(release)
elif [ $# == 2 ] && [ $1 == "sr" ]; then
  if ! [ -f test/sample-${2}.in ]; then
    command echo "\"test/sample-${2}.in\" not found."
    exit 1
  fi
  bat test/sample-${2}.in
  [[ -f test/sample-${2}.out ]] && bat test/sample-${2}.out
  cargo run --release < test/sample-${2}.in

else
  command echo "invalid argument(s)."
fi
