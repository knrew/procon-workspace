#! /bin/env sh

set -eu

# oj test
if [ $# == 0 ] || [ $1 == "d" ]; then
  cargo build
  oj t -S -c ./target/debug/main

# oj test(release)
elif [ $# == 1 ] && [ $1 == "r" ]; then
  cargo build --release
  oj t -S -c ./target/release/main

# run single sample
elif [ $# == 2 ] && [ $1 == "s" ]; then
  [[ -f test/sample-${2}.in ]] && bat test/sample-${2}.in
  [[ -f test/sample-${2}.out ]] && bat test/sample-${2}.out
  cargo run < test/sample-${2}.in

# run single sample(release)
elif [ $# == 2 ] && [ $1 == "sr" ]; then
  [[ -f test/sample-${2}.in ]] && bat test/sample-${2}.in
  [[ -f test/sample-${2}.out ]] && bat test/sample-${2}.out
  cargo run --release < test/sample-${2}.in

else
  command echo "invalid argument(s)."
fi
