# CMakeLists.txt
find_package(rclpy REQUIRED)
find_package(std_msgs REQUIRED)

install(PROGRAMS
  scripts/btc.py
  scripts/btc_listen.py
  DESTINATION lib/${PROJECT_NAME}
)

