#!/bin/env sh

set -eu

OJ="uv run oj"
CARGO="cargo +1.89.0"

SAMPLES_DIR="./samples"
SOURCE_FILE=./src/main.rs
SUBMISSION_FILE=./submission/submission.rs
LIBRARY_DIR="$HOME/codes/reprol/"
BUNDLE_COMMENT="$(printf "%s\n%s" \
  "This module is bundled from:" \
  "https://github.com/knrew/reprol")"

BIN_MAIN_DEBUG=./target/debug/main
BIN_MAIN_RELEASE=./target/release/main
BIN_SUBMISSION_DEBUG=./target/debug/submission
BIN_SUBMISSION_RELEASE=./target/release/submission

usage() {
  cat << EOF
usage: $0 <command> [options]
commands:
  help                             show this message
  download URL                     download samples and record URL
  bundle                           bundle src/main.rs into submission/submission.rs
  build [--submission] [--release|--debug]
  run [--submission] [--release|--debug]
  test [--submission] [--case N] [--release|--debug]
  submit [--force]
  clip                             bundle then copy submission to clipboard
EOF
}

error() {
  printf "%s\n" "$*" >&2
  exit 1
}

bundle() {
  reprack --library "$LIBRARY_DIR" --comment "$BUNDLE_COMMENT" "$SOURCE_FILE" > "$SUBMISSION_FILE"
  rustfmt "$SUBMISSION_FILE"
}

build_main() {
  if [ "$1" = "release" ]; then
    $CARGO build --release --bin main
  else
    $CARGO build --bin main
  fi
}

build_submission() {
  if [ "$1" = "release" ]; then
    $CARGO build --release --package submission --bin submission
  else
    $CARGO build --package submission --bin submission
  fi

}

download_command() {
  url=""

  while [ $# -gt 0 ]; do
    case "$1" in
      --help | -h)
        usage
        exit 0
        ;;
      *)
        if [ -n "$url" ]; then
          error "unknown option for download: $1"
        else
          url="$1"
        fi
        ;;
    esac
    shift
  done

  [ -n "$url" ] || error "URL is required"

  if [ -e "$SAMPLES_DIR" ]; then
    rm -rf "$SAMPLES_DIR"
  fi

  if [ -e ./.url.txt ]; then
    rm ./.url.txt
  fi

  $OJ download --directory "$SAMPLES_DIR" "$url"
  echo "$url" > ./.url.txt
}

bundle_command() {
  bundle
}

build_command() {
  submission=0
  release=0
  debug=0

  while [ $# -gt 0 ]; do
    case "$1" in
      --submission | -s)
        submission=1
        ;;
      --release | -r)
        release=1
        ;;
      --debug | -d)
        debug=1
        ;;
      --help | -h)
        usage
        exit 0
        ;;
      *)
        error "unknown option for build: $1"
        ;;
    esac
    shift
  done

  if [ "$debug" = 1 ] && [ "$release" = 1 ]; then
    error "--debug and --release cannot be used together"
  fi

  if [ "$submission" = 0 ]; then
    if [ "$release" = 1 ]; then
      build_main "release"
    else
      build_main "debug"
    fi
  else
    bundle
    if [ "$debug" = 1 ]; then
      build_submission "debug"
    else
      build_submission "release"
    fi
  fi
}

run_command() {
  submission=0
  release=0
  debug=0

  while [ $# -gt 0 ]; do
    case "$1" in
      --submission | -s)
        submission=1
        ;;
      --release | -r)
        release=1
        ;;
      --debug | -d)
        debug=1
        ;;
      --help | -h)
        usage
        exit 0
        ;;
      *)
        error "unknown option for run: $1"
        ;;
    esac
    shift
  done

  if [ "$debug" = 1 ] && [ "$release" = 1 ]; then
    error "--debug and --release cannot be used together"
  fi

  if [ "$submission" = 0 ]; then
    if [ "$release" = 1 ]; then
      build_main "release"
      $BIN_MAIN_RELEASE
    else
      build_main "debug"
      $BIN_MAIN_DEBUG
    fi
  else
    bundle
    if [ "$debug" = 1 ]; then
      build_submission "debug"
      $BIN_SUBMISSION_DEBUG
    else
      build_submission "release"
      $BIN_SUBMISSION_RELEASE
    fi
  fi
}

test_command() {
  submission=0
  case_id=-1
  release=0
  debug=0

  while [ $# -gt 0 ]; do
    case "$1" in
      --submission | -s)
        submission=1
        ;;
      --case | -c)
        [ $# -ge 2 ] || error "--case requires value"
        case_id=$2
        shift
        ;;
      --release | -r)
        release=1
        ;;
      --debug | -d)
        debug=1
        ;;
      --help | -h)
        usage
        exit 0
        ;;
      *)
        error "unknown option for test: $1"
        ;;
    esac
    shift
  done

  if [ "$debug" = 1 ] && [ "$release" = 1 ]; then
    error "--debug and --release cannot be used together"
  fi

  if [ "$submission" = 0 ]; then
    if [ "$release" = 1 ]; then
      build_main "release"
      cmd=$BIN_MAIN_RELEASE
    else
      build_main "debug"
      cmd=$BIN_MAIN_DEBUG
    fi
  else
    bundle
    if [ "$debug" = 1 ]; then
      build_submission "debug"
      cmd=$BIN_SUBMISSION_DEBUG
    else
      build_submission "release"
      cmd=$BIN_SUBMISSION_RELEASE
    fi
  fi

  if [ "$case_id" = -1 ]; then
    $OJ test --directory "$SAMPLES_DIR" --command "$cmd"
  else
    sample_in="$SAMPLES_DIR/sample-${case_id}.in"
    sample_out="$SAMPLES_DIR/sample-${case_id}.out"
    [ -f "$sample_in" ] || error "sample not found: $sample_in"
    [ -f "$sample_out" ] || error "sample not found: $sample_out"

    tmp_dir=$(mktemp -d "./.tmp.XXXXXX")
    cleanup() {
      rm -rf "$tmp_dir"
    }
    trap cleanup EXIT

    cp "$sample_in" "$tmp_dir/"
    cp "$sample_out" "$tmp_dir/"

    $OJ test --directory "$tmp_dir" --command "$cmd"
  fi
}

submit_command() {
  force=0

  while [ $# -gt 0 ]; do
    case "$1" in
      --force | -f)
        force=1
        ;;
      --help | -h)
        usage
        exit 0
        ;;
      *)
        error "unknown option for submit: $1"
        ;;
    esac
    shift
  done

  if [ ! -e ./.url.txt ]; then
    error "url file not found. run download first."
  fi
  url=$(cat ./.url.txt)

  bundle
  build_submission "release"

  if [ "$force" = 0 ]; then
    $OJ test --directory "$SAMPLES_DIR" --command "$BIN_SUBMISSION_RELEASE"
  fi

  $OJ submit --language rust "$url" "$SUBMISSION_FILE"
}

clip_command() {
  bundle
  xclip -selection c "$SUBMISSION_FILE"
}

main() {
  if [ $# -eq 0 ]; then
    usage
    exit 0
  fi

  cmd=$1
  shift

  case "$cmd" in
    help | h | --help | -h)
      usage
      ;;
    download | d)
      download_command "$@"
      ;;
    bundle)
      bundle_command "$@"
      ;;
    build | b)
      build_command "$@"
      ;;
    run | r)
      run_command "$@"
      ;;
    test | t)
      test_command "$@"
      ;;
    submit)
      submit_command "$@"
      ;;
    clip | c)
      clip_command "$@"
      ;;
    *)
      usage
      error "unknown command: $cmd"
      ;;
  esac
}

main "$@"
