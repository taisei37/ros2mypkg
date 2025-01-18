#!/bin/bash
# SPDX-FileCopyrightText: 2024 Taisei Suzuki
# SPDX-License-Identifier: BSD-3-Clause

# デフォルトの作業ディレクトリ
dir=~
[ "$1" != "" ] && dir="$1"

# ROS2 ワークスペースに移動してビルド
cd $dir/ros2_ws
colcon build
source $dir/.bashrc

# ROS2 ノードをバックグラウンドで起動
timeout 65 ros2 run mypkg btc & 
ros_pid=$!

# ノードが起動してメッセージを送信するのを待つ
sleep 15

# トピックを監視し、出力をログに記録
timeout 10 ros2 topic echo /btc_price > /tmp/mypkg.log

#ログの内容を表示
cat /tmp/mypkg.log

#正常終了
exit 0
