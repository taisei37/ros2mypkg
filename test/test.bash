#!/bin/bash
# SPDX-FileCopyrightText: 2024 Taisei Suzuki
# SPDX-License-Identifier: BSD-3-Clause

# 作業ディレクトリの設定
dir=~
[ "$1" != "" ] && dir="$1"

# ROS2 ワークスペースのビルド
cd $dir/ros2_ws || { echo "指定されたディレクトリが存在しません: $dir/ros2_ws"; exit 1; }
colcon build || { echo "ビルドに失敗しました。"; exit 1; }

# .bashrcの読み込み
if [ -f "$dir/.bashrc" ]; then
  source "$dir/.bashrc" || { echo ".bashrcの読み込みに失敗しました。"; exit 1; }
else
  echo "$dir/.bashrc が存在しません。"
  exit 1
fi

# ROS2 ノードをバックグラウンドで起動
timeout 65 ros2 run ros2mypkg btc &
ros_pid=$!

# ノードが起動してメッセージを送信するのを待つ
sleep 15

# トピックを監視し、出力をログに記録
timeout 50 ros2 topic echo /btc_price --qos-profile sensor_data > /tmp/mypkg.log

# ログの内容を表示
if grep -q "Error" /tmp/mypkg.log; then
  echo "エラーを検出"
  exit 1
else
  echo "テスト成功"
  cat /tmp/mypkg.log
fi

# 正常終了
exit 0

