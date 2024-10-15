#! /bin/env sh

# set -eu

./bundle.sh

if [ $# -ge 2 ]; then
  command echo "too many argument(s)."
  exit 1
fi

if [ $# == 1 ]; then
  if [ $1 != "f" ] && [ $1 != "force" ]; then
    command echo "invalid argument."
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

cargo build --release --bin $submission
if [ $? != 0 ]; then
  command echo "compile error."
  command echo "submission has cancelled."
  exit 1
fi 

oj t -S -c ./target/release/$submission
test_passed=$?

if [ $test_passed == 0 ]; then
  command echo "test passed."
else
  command echo -e "\e[31m!!!test failed!!! \e[m"
fi

if [ $test_passed == 0 ] || [ $force_submit == 1 ]; then
  oj submit $url src/${submission}.rs
else     
  command echo "submission has cancelled."
fi
