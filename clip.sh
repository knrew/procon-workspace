#! /bin/env sh

./bundle.sh &&
  cat submission/submission.rs | xclip -selection c
