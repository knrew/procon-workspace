#! /bin/env sh

function build() {
  cargo build --release --package submission
}

function run() {
  oj t -S -c ./target/release/submission
}

function submit() {
  oj submit -l rust $1 submission/submission.rs
}

if [ $# -ge 2 ]; then
  command echo "too many arguments." >&2
  exit 1
fi

if [ $# == 1 ]; then
  if [ $1 != "f" ] && [ $1 != "force" ]; then
    command echo "invalid argument." >&2
    exit 1
  else 
    force_submit=1
  fi
else
  force_submit=0
fi

if [ ! -e .url.txt ]; then
  command echo "url file not found." >&2
  command echo "run download.sh." >&2
  exit 1
fi
url=$(cat .url.txt)

./bundle.sh
if [ $? != 0 ]; then
  command echo "failed to bundle." >&2
  command echo "submission has cancelled." >&2
  exit 1
fi

build
if [ $? != 0 ]; then
  command echo "compile error." >&2
  command echo "submission has cancelled." >&2
  exit 1
fi

if [ $force_submit == 1 ]; then
  submit $url
  exit $?
fi

run
if [ $? == 0 ]; then
  command echo "test passed."
  command echo -e "submitting to \e[34m${url}\e[m..."
  submit $url
else
  command echo -e "\e[31mtest failed!\e[m" >&2
  command echo "submission has cancelled." >&2
  exit 1
fi
