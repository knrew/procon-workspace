# procon workspace
実際に競技プログラミングの問題を解くワークスペース

`src/main.rs`にコードを書く．

ライブラリ -> [https://github.com/knrew/reprol]()

## スクリプト
- `build.sh`: ビルドする
- `bundle.sh`: 提出用コードを生成する(`src/main.rs`->`submission/submission.rs`)
- `download.sh <url>`: urlからテストケースをダウンロードする(oj)
- `test.sh`: テストケースを実行する(oj)
    - `src/main.rs`を実行する
- `submit.sh`: 提出する(oj)
    - `download.sh`で指定したurlが参照される
    - `submission/submission.rs`を実行してサンプルが通るかチェックする
    - `submission/submission.rs`が提出される
- `clip.sh`: `submission/submission.rs`をクリップボードにコピー
