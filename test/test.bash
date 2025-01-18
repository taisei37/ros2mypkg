#!/bin/bash
# SPDX-FileCopyrightText: 2024 Taisei Suzuki
# SPDX-License-Identifier: BSD-3-Clause

# デフォルトの作業ディレクトリ
dir=~
[ "$1" != "" ] && dir="$1"

# ROS2 ワークスペースに移動してビルド
cd $dir/ros2_ws || exit 1
colcon build || exit 1

# ROS2 環境をセットアップ
source $dir/ros2_ws/install/setup.bash || {
    echo "ERROR: ROS 2 環境のセットアップに失敗しました。" >&2
    exit 1
}

# 'ros2' コマンドが使用可能か確認
if ! which ros2 > /dev/null; then
    echo "ERROR: 'ros2' コマンドが見つかりません。" >&2
    exit 1
fi

# テスト用のログファイル
log_file="/tmp/btc_publisher_test.log"

# ROS2 ノードをバックグラウンドで起動
timeout 50 ros2 run mypkg btc &  # 実際のノード名に更新してください
ros_pid=$!

# ノードが起動してメッセージを送信するのを待つ
sleep 10  # 少し長めに待機

# トピックを監視し、出力をログに記録
timeout 10 ros2 topic echo /btc_price > "$log_file" 2>&1 || {
    echo "ERROR: /btc_price トピックの監視に失敗しました。" >&2
    kill "$ros_pid" 2>/dev/null
    exit 1
}

# ログに期待する内容（価格メッセージ）が含まれているか確認
if ! grep -q -e '^[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}' -e '\$' "$log_file"; then
    echo "ERROR: /btc_price トピックに期待される出力が含まれていません。" >&2
    kill "$ros_pid" 2>/dev/null
    exit 1
fi

# バックグラウンドプロセスを終了
kill "$ros_pid" 2>/dev/null

# プロセスの終了を確認
wait "$ros_pid" 2>/dev/null || true

echo "テスト成功: トピック出力を確認しました。"
exit 0

