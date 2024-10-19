# atcoder
実際に競技プログラミングの問題を解くときのいろいろ

`src/main.rs`にコードを書くこと．

ライブラリ -> [https://github.com/knrew/reprol]()

## スクリプト
- `bundle.sh`: 提出用コードを生成
    - `src/main.rs`にライブラリを貼り付けたコードが`submission/submission.rs`に生成される
- `download.sh <url>`: urlからテストケースをダウンロードする(oj)
- `check.sh`: テストケースに対してプログラムを実行する(oj)
- `submit.sh`: 提出する(oj)
    - `download.sh`で指定したurlが参照される
    - `submission/submission.rs`が提出される
