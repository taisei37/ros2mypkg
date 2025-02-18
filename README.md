[![test](https://github.com/taisei37/ros2mypkg/actions/workflows/test.yml/badge.svg)](https://github.com/taisei37/ros2mypkg/actions/workflows/test.yml)
#robosys2024
ロボットシステム学授業用(課題2)
# ビットコインの価格を表示

## 機能

- このROS2パッケージはyfinance ライブラリを用いてYahoo！ファイナンスのビットコインの価格を60秒毎に取得し表示する機能を持ちます。

## 使用方法と注意点
- このパッケージはyfinanceを使用しているため、最初にこのライブラリをインストールする必要があります。

```
pip install yfinance
```

- 以下のコマンドでビットコインの価格を表示できます

- パブリッシュ方法

 一つ目の端末で以下のコマンドを実行
 btc_priceトピックへの価格送信

```
ros2 run ros2mypkg btc
```

- 二つ目の端末で以下のコマンドを実行

```
ros2 topic echo /btc_price
```
- 出力例(2025年1月1日21時30分30秒の場合)
```
data: 2025-01-01 21:30:30, $148415.25
---
```

## 動作環境
このパッケージは以下の環境で動作確認済み
- Ubuntu 22.04 LTS

## ライセンス
- このソフトウェアパッケージは３条項BSDライセンスの下、再頒布および使用が許可されてされています。

© 2025 Taisei Suzuki
