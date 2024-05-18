#!/usr/bin/env bash
set -eu

# https://github.com/Tiryoh/ros2_setup_scripts_ubuntu

# 압축 풀고 해당 경로로 들어가서 아래 명령 실행
# ./run.sh

#sudo rm /var/lib/apt/lists/lock
#sudo rm /var/cache/apt/archives/lock
#sudo rm /var/lib/dpkg/lock*
#sudo dpkg --configure -a
#sudo apt update

# 삭제
# sudo apt remove ~nros-humble-* && sudo apt autoremove
# sudo rm /etc/apt/sources.list.d/ros2.list
# sudo apt update
# sudo apt autoremove
# sudo apt upgrade


CHOOSE_ROS_DISTRO=humble # or iron, etc...
INSTALL_PACKAGE=desktop # or ros-base

sudo apt update

sudo apt-get install expect -y # ros 동작 확인하려고

sudo apt install -y curl gnupg2 lsb-release
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt update
sudo apt install -y ros-$CHOOSE_ROS_DISTRO-$INSTALL_PACKAGE
sudo apt install -y python3-argcomplete
sudo apt install -y python3-colcon-common-extensions
if [ "$(lsb_release -cs)" = "bionic" ]; then
	sudo apt install -y python-rosdep python3-vcstool # https://index.ros.org/doc/ros2/Installation/Linux-Development-Setup/
else
	sudo apt install -y python3-rosdep python3-vcstool # https://index.ros.org/doc/ros2/Installation/Linux-Development-Setup/
fi
[ -e /etc/ros/rosdep/sources.list.d/20-default.list ] ||
sudo rosdep init
rosdep update
grep -F "source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash" ~/.bashrc ||
echo "source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash" >> ~/.bashrc
grep -F "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" ~/.bashrc ||
echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> ~/.bashrc

set +eu


source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash

#echo "success installing ROS2 $CHOOSE_ROS_DISTRO"
#echo "Run 'source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash'"

echo "\n\n\n>>> 아래 [talker]: Publishing: 'Hello World: 1 2 3"
echo "    이런 내용이 출력되면 제대로 설치 완료 \n\n"

# expect 스크립트를 인라인으로 작성
expect << EOF
set timeout -1
set line_count 0

spawn ros2 run demo_nodes_cpp talker

expect {
    -re "Publishing:.*" {
        incr line_count
        if { \$line_count == 3 } {
            send -- "\003"; # Ctrl+C를 보냄
            expect eof
            exit
        }
        exp_continue
    }
}
EOF

