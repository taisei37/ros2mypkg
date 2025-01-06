import launch
import launch.actions
import launch.substitutions
import launch_ros.actions


def generate_launch_description():

      sin_publisher = launch_ros.actions.Node(
          package='mypkg',
          executable='btc',
          )
      sub = launch_ros.actions.Node(
          package='mypkg',
          executable='sub',
          output='screen'
          )

      return launch.LaunchDescription([btc, sub])
