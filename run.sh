#! /bin/env sh

set -eu

. ./common.sh

# oj test
if [ $# = 0 ] || [ "$1" = "d" ]; then
  build_main_debug &&
    oj t -S -c $RUN_MAIN_DEBUG

# oj test(release)
elif [ $# = 1 ] && [ "$1" = "r" ]; then
  build_main_release &&
    oj t -S -c $RUN_MAIN_RELEASE

# oj test(submission)
elif [ $# = 1 ] && [ "$1" = "sub" ]; then
  ./bundle.sh &&
    build_submission_release &&
    oj t -S -c $RUN_SUBMISSION_RELEASE

# run single sample
elif [ $# = 2 ] && [ "$1" = "s" ]; then
  in=test/sample-${2}.in
  out=test/sample-${2}.out
  if ! [ -f "$in" ]; then
    command echo "\"${in}\" not found." >&2
    exit 1
  fi
  bat "$in"
  [ -f "$out" ] && bat "$out"
  build_main_debug &&
    ./target/debug/main \
      < "$in"

# run single sample(release)
elif [ $# = 2 ] && [ "$1" = "sr" ]; then
  in=test/sample-${2}.in
  out=test/sample-${2}.out
  if ! [ -f "$in" ]; then
    command echo "\"${in}\" not found." >&2
    exit 1
  fi
  bat "$in"
  [ -f "$out" ] && bat "$out"
  build_main_release &&
    ./target/release/main \
      < "$in"

else
  command echo "invalid argument(s)." >&2
  exit 1
fi
