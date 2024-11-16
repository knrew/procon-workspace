#! /bin/env sh

set -eu

lib=~/codes/reprol/
src=./src/main.rs
sub=./submission/submission.rs

rustfmt $src
library-bundler -l $lib $src > $sub
rustfmt $sub
