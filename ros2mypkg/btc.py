# SPDX-FileCopyrightText: 2024 Taisei Suzuki
# SPDX-License-Identifier: BSD-3-Clause
import rclpy
from rclpy.node import Node
from std_msgs.msg import String
import yfinance as yf
from datetime import datetime


class BTCPublisher(Node):
    def __init__(self):
        super().__init__('btc_publisher')
        self.publisher_ = self.create_publisher(String, 'btc_price', 10)
        self.create_timer(60.0, self.publish_price)

    def publish_price(self):
        try:
            ticker = yf.Ticker("BTC-USD")
            current_price = ticker.history(period="1d")['Close'][0]  # 最新の終値を取得
            now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            message = f"{now}, ${current_price:.2f}"
            self.publisher_.publish(String(data=message))
            self.get_logger().info(f"Published message: {message}")
        except Exception as e:
            self.get_logger().error(f"Error fetching latest price: {e}")


def main():
    rclpy.init()
    node = BTCPublisher()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        node.destroy_node()
        rclpy.shutdown()


if __name__ == "__main__":
    main()

