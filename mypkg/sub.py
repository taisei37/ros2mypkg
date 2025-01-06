import rclpy
from rclpy.node import Node
from std_msgs.msg import String

class BTCSubscriber(Node):
    def __init__(self):
        super().__init__("sub")
        # 'btc_price' トピックを購読（String 型）
        self.subscription = self.create_subscription(
            String,
            'btc_price',  # トピック名
            self.cb,  # コールバック関数
            10
        )

    def cb(self, msg):
        try:
            # 受け取った文字列を数値に変換して表示
            btc_price = float(msg.data.replace('$', '').replace(',', ''))
            self.get_logger().info(f"BTC Price: {btc_price}")
        except ValueError:
            self.get_logger().error(f"Failed to convert the message to a number: {msg.data}")

def main():
    rclpy.init()
    node = BTCSubscriber()
    rclpy.spin(node)

    # シャットダウン時にノードを破棄
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
