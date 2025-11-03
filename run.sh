#! /bin/env sh

set -eu

. ./common.sh

# oj test
if [ $# = 0 ] || [ "$1" = "d" ] || [ "$1" = "debug" ]; then
  build_main_debug &&
    $OJ test --command $RUN_MAIN_DEBUG

# oj test(release)
elif [ $# = 1 ] && { [ "$1" = "r" ] || [ "$1" = "relase" ]; }; then
  build_main_release &&
    $OJ test --command $RUN_MAIN_RELEASE

# oj test(submission)
elif [ $# = 1 ] && { [ "$1" = "s" ] || [ "$1" = "submission" ]; }; then
  build_submission_release &&
    $OJ test --command $RUN_SUBMISSION_RELEASE

# run single sample
elif [ $# = 2 ] && [ "$1" = "c" ]; then
  build_main_debug || exit 1
  in=test/sample-${2}.in
  out=test/sample-${2}.out
  if ! [ -f "$in" ]; then
    echo "\"${in}\" not found." >&2
    exit 1
  fi
  bat "$in"
  [ -f "$out" ] && bat "$out"
  $RUN_MAIN_DEBUG < "$in"

# run single sample(release)
elif [ $# = 2 ] && [ "$1" = "cr" ]; then
  build_main_release || exit 1
  in=test/sample-${2}.in
  out=test/sample-${2}.out
  if ! [ -f "$in" ]; then
    echo "\"${in}\" not found." >&2
    exit 1
  fi
  bat "$in"
  [ -f "$out" ] && bat "$out"
  $RUN_MAIN_RELEASE < "$in"

else
  echo "invalid argument(s)." >&2
  exit 1
fi
