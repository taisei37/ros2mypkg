#robosys2024
ロボットシステム学授業用(課題2)
# ビットコインの価格を表示

## 機能

- このROS2パッケージはyfinance ライブラリを用いてYahoo！ファイナンスのビットコインの価格を取得し表示する機能を持ちます。

## 使用方法
- このパッケージはyfinanceを使用しているため、最初にこのライブラリをインストールする必要があります。

``pip install yfinance``

- 以下のコマンドでビットコインの価格を表示できます

- パブリッシュ方法①
 一つ目の端末で以下のコマンドを実行

``ros2 run mypkg btc``

- 二つ目の端末で以下のコマンドを実行

``ros2 topic echo /btc_price``

- パブリッシュ方法②

-- 以下のコマンドで`btc`と`btclistener`を同時に実行できます

``ros2 launch mypkg btc_listen.launch.py``

## 必要なソフトウェア
- python
 -テスト実行中

## テスト環境
- Ubuntu 20.04 LTS

##ライセンス
- このソフトウェアパッケージは３条項BSDライセンスの下、再頒布および使用が許可されてされています。

© 2024 Taisei Suzuki
