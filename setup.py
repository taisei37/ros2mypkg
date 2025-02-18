from setuptools import find_packages, setup
import os
from glob import glob

package_name = 'ros2mypkg'

setup(
    name=package_name,
    version='0.0.0',
    packages=find_packages(exclude=['test']),
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
        (os.path.join('share', package_name), glob('launch/*.launch.py'))
    ],
    install_requires=['setuptools', 'yfinance'],
    zip_safe=True,
    maintainer='Taisei Suzuki',
    maintainer_email='iseita31kamekichi@gmail.com',
    description='ロボットシステム学のサンプル',
    license='BSD-3-Clause',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            'btc = ros2mypkg.btc:main',
        ],
    },
)

