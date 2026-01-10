# procon workspace

競技プログラミングのためのRustワークスペース．
`src/main.rs`に解答を記述し，ライブラリをバンドルして提出する．

## 必要環境

- Rust 1.89.0
- [reprol](https://github.com/knrew/reprol): ライブラリ．`~/codes/reprol/` に配置する．
- [reprack](https://github.com/knrew/reprack): 提出用コード生成用のバンドラ．
- [online-judge-tools](https://github.com/online-judge-tools/oj): `uv run oj`で呼び出して使用する．
- bat: サンプル表示用．
- xclip: クリップボードコピー用．

## スクリプト
- `build.sh [d|r|s]`: mainをdebug/release，またはsubmissionをreleaseでビルド(省略時 debug)
- `bundle.sh`: `src/main.rs`にreprolをバンドルしたものを`submission/submission.rs`に出力する．
- `run.sh [mode]`: `oj test`実行やサンプル単体実行
  - 省略/`d`/`debug`: main(debug)を`oj test`
  - `r`/`release`: main(release)を`oj test`
  - `s`/`submission`: バンドルしてsubmission(release)を`oj test`
  - `c <n>`: `test/sample-n.in`をmain(debug)で実行(`cr`でrelease)
- `download.sh <url>`: 指定 URL からサンプルを取得し`test/`に配置．urlを`.url.txt` に保存．
- `submit.sh [f|force]`: バンドルしてsubmissionをビルドし，`oj test`が通れば保存済みURLに提出(`f`でテスト省略)．
- `clip.sh`: バンドル後の`submission/submission.rs`をクリップボードにコピー．

## 使い方
1. `./download.sh <url>` でサンプル取得．
2. `src/main.rs` に解答を実装．
3. `./run.sh`（または `./run.sh s`）でサンプルテスト．
4. `./submit.sh` で提出．または `./clip.sh` でコードをクリップボードにコピー．
