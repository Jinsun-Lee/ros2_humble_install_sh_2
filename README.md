## ${ROS2\\ 설치를\\ 위해\\ {\color{red}인터넷을\\ 연결해야\\ 합니다}}\ !!!!$
```
Contents: Ubuntu 22.04에 ROS2 Humble을 설치
Update  : 2024-05-18
```

```
설치는 “run.sh” 파일을 사용합니다.
설치 과정에서 해당 파일을 다운로드하는 과정도 포함합니다.

인터넷은 “run.sh”파일 다운로드와 ROS2 설치 과정에 필요합니다.
파일이 있다고 인터넷을 연결하지 않으면, 제대로 설치되지 않습니다.

파일이 있는 경우, 파일이 있는 경로로 이동한 후
sh run.sh를 실행하면 설치됩니다.
```
</br></br></br></br>


# 우분투 설치 확인
```
lsb_release -r     # 22.04가 나오는지 확인
sudo passwd root   # 비밀번호 설정

sudo apt update
sudo apt install curl
```



# 1. 설치
```
curl -L -O https://github.com/Jinsun-Lee/ros2_humble_install_sh/raw/main/run.sh; sh run.sh
```
![image](https://github.com/Jinsun-Lee/ros2_humble_install_sh/assets/68187536/f3fdc0af-61af-45d2-9ac4-f4cb47716408)
</br></br>


# 2. 설치 확인
```
ROS가 제대로 설치된 경우에만 아래와 같은 출력이 나온다!

[INFO] [1716016137.177980873] [talker]: Publishing: 'Hello World: 1'
[INFO] [1716016138.177905936] [talker]: Publishing: 'Hello World: 2'
[INFO] [1716016139.177907257] [talker]: Publishing: 'Hello World: 3'
```
![image](https://github.com/Jinsun-Lee/ros2_humble_install_sh/assets/68187536/cce90577-bd60-4fa0-81b0-b96c2752908b)

```
source /opt/ros/humble/setup.bash
sh run.sh
```

</br></br>







</br></br></br>
---

<details>
<summary>설치 제거</summary>
<div markdown="1">       

```
sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock*
sudo dpkg --configure -a
sudo apt update
sudo apt remove ~nros-humble-* && sudo apt autoremove
sudo rm /etc/apt/sources.list.d/ros2.list
sudo apt update
sudo apt autoremove
#sudo apt upgrade

source /opt/ros/humble/setup.bash
ros2 run demo_nodes_cpp talker
```

</div>
</details>


</br></br></br>
