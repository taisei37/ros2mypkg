#!/bin/bash
# SPSX-FileCopyrightText: 2024 Taisei Suzuki
# SPDX-License-Identifier: BSD-3-Clause

# デフォルトのディレクトリ設定
dir=~
[ "$1" != "" ] && dir="$1"

# ROS2ワークスペースに移動
cd $dir/ros2_ws

# ワークスペースをビルド
colcon build
source install/setup.bash

# ノードをバックグラウンドで起動
timeout 15 ros2 run mypkg btc > /tmp/test.bash.log 2>&1 &

# ログファイルの内容を確認
sleep 15

# BTC価格のフォーマットを確認
price_found=$(grep -E '^\$[0-9]+\.[0-9]{2}$' /tmp/test.bash.log)

# エラーメッセージが無いか確認
error_found=$(grep -E 'Error fetching price' /tmp/test.bash.log)

if [ -n "$price_found" ] && [ -z "$error_found" ]; then
    echo "Test Passed: BTC price is correctly published."
    exit 0
else
    echo "Test Failed: Either no valid price found or an error occurred."
    exit 1
fi

