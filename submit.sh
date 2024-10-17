#! /bin/env sh

# set -eu

./bundle.sh

function compile() {
  cargo build --release --package submission
}

function run() {
  oj t -S -c ./target/release/submission
}

function submit() {
  oj submit $1 submission/submission.rs
}

if [ $# -ge 2 ]; then
  command echo "too many arguments."
  exit 1
fi

if [ $# == 1 ]; then
  if [ $1 != "f" ] && [ $1 != "force" ]; then
    command echo "invalid argument(s)."
    exit 1
  else 
    force_submit=1
  fi
else
  force_submit=0
fi

if [ ! -e .url.txt ]; then
  command echo "url file not found."
  command echo "run download.sh"
  exit 1
fi
url=$(cat .url.txt)

compile
if [ $? != 0 ]; then
  command echo "compile error."
  command echo "submission has cancelled."
  exit 1
fi 

run
test_passed=$?

if [ $test_passed == 0 ]; then
  command echo "test passed."
else
  command echo -e "\e[31m!!!test failed!!! \e[m"
fi

if [ $test_passed == 0 ] || [ $force_submit == 1 ]; then
  submit $url
else     
  command echo "submission has cancelled."
fi
