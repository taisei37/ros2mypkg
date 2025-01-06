#!/bin/bash
# SPSX-FileCopyrightText: 2024 Taisei Suzuki
# SPDX-License-Identifier: BSD-3-Clause

# デフォルトのディレクトリ設定
dir=~
[ "$1" != "" ] && dir="$1"

# ROS2ワークスペースに移動
cd "$dir/ros2_ws" || { echo "Failed to change directory to $dir/ros2_ws"; exit 1; }

# ワークスペースをビルド
colcon build || { echo "Build failed"; exit 1; }
source "$dir/.bashrc"

# ノードをバックグラウンドで起動して60秒間実行
timeout 60s ros2 run btc_publisher btc_publisher > /tmp/mypkg.log 2>&1
status=$?

# テスト結果を確認
if [ $status -eq 0 ]; then
  echo "Node ran successfully."
else
  echo "Node did not complete successfully. Exit status: $status"
fi

# ログに期待する出力があるかを確認
grep "Published BTC price:" /tmp/mypkg.log > /tmp/grep_results.log
grep_status=$?

if [ $grep_status -eq 0 ]; then
  echo "Test passed: BTC price was published successfully."
else
  echo "Test failed: BTC price was not published."
fi

# ログ内容を出力（オプション）
cat /tmp/grep_results.log

# スクリプト終了ステータス
exit $grep_status

