#! /bin/env sh
set -eu

src=./src/main.rs
sub=./submission/submission.rs
lib=~/codes/reprol/

rustfmt $src
library-bundler -l $lib $src > $sub
rustfmt $sub
