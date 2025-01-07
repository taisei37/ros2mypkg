import rclpy
from rclpy.node import Node
from std_msgs.msg import String


class BTCListener(Node):
    def __init__(self):
        super().__init__('btc_listener')
        self.create_subscription(String, 'btc_price', self.btc_price_callback, 10)

    def btc_price_callback(self, msg):
        self.get_logger().info(f"受信したBTC価格: {msg.data}")


def main():
    rclpy.init()
    node = BTCListener()
    try:
        rclpy.spin(node)  # ノードを実行してメッセージを待機
    except KeyboardInterrupt:
        pass
    finally:
        node.destroy_node()  # ノードの破棄
        rclpy.shutdown()  # ROS2のシャットダウン


if __name__ == "__main__":
    main()

