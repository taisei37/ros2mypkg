# SPSX-FileCopyrightText: 2024 Taisei Suzuki
# SPDX-License-Identifier: BSD-3-Clause
import rclpy
from rclpy.node import Node
from std_msgs.msg import String
import yfinance as yf


class BTCPublisher(Node):
    def __init__(self):
        super().__init__('btc_publisher')
        self.publisher_ = self.create_publisher(String, 'btc_price', 10)
        self.create_timer(60.0, self.publish_price)

    def publish_price(self):
        try:
            ticker = yf.Ticker("BTC-USD")
            history = ticker.history(period="1d", interval="1m")
            if not history.empty:
                price = history["Close"].iloc[-1]
                self.publisher_.publish(String(data=f"${price:.2f}"))
        except Exception as e:
            print(f"Error fetching price: {e}")


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

