#! /bin/env sh

. ./common.sh

submit() {
  oj submit -l rust "$1" submission/submission.rs
}

if [ $# -ge 2 ]; then
  echo "too many arguments." >&2
  exit 1
fi

if [ $# = 1 ]; then
  if [ "$1" != "f" ] && [ "$1" != "force" ]; then
    echo "invalid argument." >&2
    exit 1
  else
    force_submit=1
  fi
else
  force_submit=0
fi

if [ ! -e .url.txt ]; then
  echo "url file not found." >&2
  echo "run download.sh." >&2
  exit 1
fi
url=$(cat .url.txt)

./bundle.sh
if ! mycmd; then
  echo "failed to bundle." >&2
  echo "submission has cancelled." >&2
  exit 1
fi

build_submission_release
if ! mycmd; then
  command echo "compile error." >&2
  command echo "submission has cancelled." >&2
  exit 1
fi

if [ $force_submit = 1 ]; then
  submit "$url"
  exit $?
fi

oj t -S -c $RUN_SUBMISSION_RELEASE
if mycmd; then
  echo "test passed."
  printf %s "submitting to \e[34m${url}\e[m..."
  submit "$url"
else
  printf "\e[31mtest failed!\e[m" >&2
  echo "submission has cancelled." >&2
  exit 1
fi
