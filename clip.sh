#! /bin/env sh

./bundle.sh
command cat submission/submission.rs | xclip -selection c
