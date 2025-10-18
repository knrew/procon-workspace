#! /bin/env sh

CARGO="cargo +1.89.0"

#
# main.rs
#

build_main_debug() {
  $CARGO build --bin main
}

build_main_release() {
  $CARGO build --release --bin main
}

RUN_MAIN_DEBUG=./target/debug/main

RUN_MAIN_RELEASE=./target/release/main

#
# submission.rs
#

build_submission_debug() {
  $CARGO build --package submission --bin submission
}

build_submission_release() {
  $CARGO build --release --package submission --bin submission
}

RUN_SUBMISSION_DEBUG=./target/debug/submission

RUN_SUBMISSION_RELEASE=./target/release/submission
