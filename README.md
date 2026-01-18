# procon workspace

競技プログラミングのためのRustワークスペース．
`src/main.rs`に解答を記述し，ライブラリをバンドルして提出する．

## Requirements

- Rust 1.89.0
- [reprol](https://github.com/knrew/reprol): ライブラリ．`~/codes/reprol/` に配置する．
- [reprack](https://github.com/knrew/reprack): 提出用コード生成用のバンドラ．
- uv: `uv run oj`で使用（`oj`は初回実行時に自動インストール）
- xclip: クリップボードコピー用．

## スクリプト

`tools.sh <command> [options]`: 各種操作をまとめたスクリプト．

- `help`: ヘルプ表示．
- `download URL`: 指定URLからサンプルを取得し`./samples`に配置する．URLを`.url.txt`に保存する．
- `bundle`: `src/main.rs`にreprolをバンドルしたものを`submission/submission.rs`に出力する．
- `build [--submission] [--release|--debug]`: プログラムをビルドする．
- `run [--submission] [--release|--debug]`: プログラムを実行する．
- `test [--submission] [--case N] [--release|--debug]`: `oj test`でサンプルをテストする．
- `submit [--force]`: バンドルしてsubmissionをビルドし，`oj test`が通れば保存済みURLに提出する．
- `clip`: バンドル後の`submission/submission.rs`をクリップボードにコピーする．

## 使い方

1. `./tools.sh download <url>` でサンプル取得．
2. `src/main.rs` に解答を実装．
3. `./tools.sh test`でサンプルテスト．
4. `./tools.sh submit`で提出．または`./tools.sh clip`でコードをクリップボードにコピー．
