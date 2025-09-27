#! /bin/env sh

set -eu

. ./common.sh

# build
if [ $# = 0 ] || [ "$1" = "d" ]; then
  build_main_debug

# build(release)
elif [ $# = 1 ] && [ "$1" = "r" ]; then
  build_main_release

# build submission(release)
elif [ $# = 1 ] && { [ "$1" = "s" ] || [ "$1" = "sub" ]; }; then
  ./bundle.sh &&
    build_submission_release

else
  command echo "invalid argument(s)." >&2
  exit 1
fi
