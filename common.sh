#! /bin/env sh

CARGO="cargo +1.70.0"

#
# main.rs
#

build_main_debug() {
  $CARGO build --bin main
}

build_main_release() {
  $CARGO build --release --bin main
}

# shellcheck disable=SC2034
RUN_MAIN_DEBUG=./target/debug/main

# shellcheck disable=SC2034
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

# shellcheck disable=SC2034
RUN_SUBMISSION_DEBUG=./target/debug/submission

# shellcheck disable=SC2034
RUN_SUBMISSION_RELEASE=./target/release/submission
