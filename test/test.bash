#!/bin/bash
# SPSX-FileCopyrightText: 2024 Taisei Suzuki
# SPDX-License-Identifier: BSD-3-Clause

set -e  # エラー発生時にスクリプトを停止
dir="$HOME"
[ "$1" != "" ] && dir="$1"

cd "$dir/ros2_ws"
colcon build
source /opt/ros/rolling/setup.bash
source "$dir/ros2_ws/install/setup.bash"

timeout 65 ros2 launch mypkg btc_listen.launch.py > /tmp/mypkg.log &
LAUNCH_PID=$!

# プロセスが終了するまで待機
wait $LAUNCH_PID || echo "Launch process terminated with a timeout."

# ログファイルの内容を確認
if [[ -s /tmp/mypkg.log ]]; then
  grep -E btc_price /tmp/mypkg.log || echo "No matching lines found."
else
  echo "Log file is empty or does not exist."
fi

