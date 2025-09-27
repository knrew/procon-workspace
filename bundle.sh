#! /bin/env sh

set -eu

LIBRARY_DIR=~/codes/reprol/
SOURCE_FILE=./src/main.rs
SUBMISSION_FILE=./submission/submission.rs

COMMENT="This module is bundled from:
https://github.com/knrew/reprol"

rustfmt $SOURCE_FILE &&
  library-bundler -l $LIBRARY_DIR -c "$COMMENT" $SOURCE_FILE > $SUBMISSION_FILE &&
  rustfmt $SUBMISSION_FILE
