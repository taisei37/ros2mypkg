#!/bin/bash
# SPSX-FileCopyrightText: 2024 Taisei Suzuki
# SPDX-License-Identifier: BSD-3-Clause

set -e  # エラー発生時にスクリプトを停止
dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws
colcon build
source $dir/.bashrc


timeout 65 ros2 launch mypkg btc_listen.launch.py > /tmp/mypkg.log &



cat /tmp/mypkg.log | grep -E btc_price

kill %1

