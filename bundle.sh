#! /bin/env sh
set -eu
rustfmt src/main.rs
library-bundler -l ~/codes/reprol/ src/main.rs > src/submission.rs
rustfmt src/submission.rs
