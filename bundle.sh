#! /bin/env sh

set -eu

LIBRARY_DIR=~/codes/reprol/
SOURCE_FILE=./src/main.rs
SUBMISSION_FILE=./submission/submission.rs

rustfmt $SOURCE_FILE
library-bundler -l $LIBRARY_DIR $SOURCE_FILE > $SUBMISSION_FILE
rustfmt $SUBMISSION_FILE
