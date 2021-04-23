#!/bin/bash
#install.sh


# Folder name of the catkin workspace
catkin_ws_name=$1
# Install ros 
ros_install=$3


# ROS installation
if [$ros_install == "ros_install"]
then
	sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
	sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
	sudo apt update
	sudo apt install ros-noetic-desktop
	echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
	source ~/.bashrc
fi
	
# Necessary packages of ROS
echo "Installing necessary ROS packages"
sudo apt-get install -y ros-noetic-hector-gazebo-plugins ros-noetic-controller-manager ros-noetic-joint-state-controller ros-noetic-gazebo-plugins ros-noetic-transmission-interface ros-noetic-joint-limits-interface ros-noetic-joint-limits-interface ros-noetic-pointcloud-to-laserscan ros-noetic-twist-mux ros-noetic-perception-pcl ros-noetic-ros-control ros-noetic-gazebo-ros-control


# Necessary libraries for drivers 
echo "Installing necessary libraries for RoboSense"
sudo apt-get install -y libyaml-cpp-dev libpcap-dev libprotobuf-dev protobuf-compiler git

cd $HOME

if [! -d "~/Drivers"]
then
	echo "Drivers directory does not exist." 
	echo "Creating a directory with the name 'Drivers' "
	mkdir Drivers


else 
	echo "Drivers directory exists." 
fi

cd Drivers 
echo "Installing RoboSense Lidar drivers."
git clone https://github.com/RoboSense-LiDAR/rslidar_sdk.git
cd rslidar_sdk
git submodule init
git submodule update
mkdir build && cd build
cmake .. && make -j4


cd $HOME

echo "Creating ROS workspace"
mkdir -p ~/catkin_ws_name/src
cd ~/catkin_ws_name
catkin init
catkin config --extend /opt/ros/melodic
catkin config -DCMAKE_BUILD_TYPE=Release

echo "Downloading necessary 3rd party packages"
cd src
git clone git@github.com:ETHZ-RobotX/smb_dev.git
vcs import . < smb_dev/smb2_0.rosinstall



