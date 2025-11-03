#! /bin/env sh

set -eu

. ./common.sh

# build main(debug)
if [ $# = 0 ] || [ "$1" = "d" ] || [ "$1" = "debug" ]; then
  build_main_debug

# build main(release)
elif [ $# = 1 ] && { [ "$1" = "r" ] || [ "$1" = "release" ]; }; then
  build_main_release

# build submission(release)
elif [ $# = 1 ] && { [ "$1" = "s" ] || [ "$1" = "submission" ]; }; then
  build_submission_release

else
  echo "invalid argument(s)." >&2
  exit 1
fi
