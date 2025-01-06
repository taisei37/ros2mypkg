#!/bin/bash

# ディレクトリの指定
dir=~
[ "$1" != "" ] && dir="$1"

# ワークスペースをビルド
cd $dir/ros2_ws
colcon build
source $dir/.bashrc

# 60秒間、`btc_publisher`ノードを起動してログを確認
timeout 60 ros2 run mypkg talker > /tmp/talker.log

# ログに価格が含まれているかを確認
if grep -q '\$' /tmp/talker.log; then
    echo "Test Passed: BTC price is being published."
else
    echo "Test Failed: No BTC price found in the logs."
fi

