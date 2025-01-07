#!/bin/bash
# SPSX-FileCopyrightText: 2024 Taisei Suzuki
# SPDX-License-Identifier: BSD-3-Clause

set -e  # エラー発生時にスクリプトを停止
dir=~
[ "$1" != "" ] && dir="$1"

echo "Changing to directory $dir/ros2_ws"
cd $dir/ros2_ws || { echo "Failed to change directory"; exit 1; }

echo "Building with colcon"
colcon build || { echo "Build failed"; exit 1; }

echo "Sourcing .bashrc"
source $dir/.bashrc || { echo "Failed to source .bashrc"; exit 1; }

echo "Launching ROS2 node"
timeout 10 ros2 launch mypkg btc_listen.launch.py > /tmp/mypkg.log || { echo "Launch failed"; exit 1; }

echo "Filtering log"
cat /tmp/mypkg.log | grep -E "btc_price|published" || { echo "No matching log entries found"; exit 1; }

