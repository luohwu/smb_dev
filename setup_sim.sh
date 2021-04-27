#!/bin/bash
#install.sh


while true; do
    read -p "Do you have ROS-Noetic-Desktop in your system? : " yn
    case $yn in
        [Nn]* ) 
        	while true; do
    		read -p "Existing ROS Distro and Packages will be deleted. Do you want to continue? : " yn
    		case $yn in
        		[Yy]* ) 
        			sudo apt-get purge ros-*
				sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
				sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
				sudo apt update
				sudo apt install ros-noetic-desktop
				echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
				source ~/.bashrc
				break;;
        		[Nn]* )         		
        			echo "Need ROS-Noetic-Desktop to continue..."
        			echo "Installation is being terminated"
        			return 0;;
        		* ) echo "Please answer yes or no.";;
    		esac
	done
	break;;
	
        [Yy]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

	
# Necessary packages of ROS
read -p "Necessary official ROS packages will be installed. Press enter to continue..."

sudo apt-get install -y ros-noetic-hector-gazebo-plugins ros-noetic-controller-manager ros-noetic-joint-state-controller ros-noetic-gazebo-plugins ros-noetic-transmission-interface ros-noetic-joint-limits-interface ros-noetic-joint-limits-interface ros-noetic-pointcloud-to-laserscan ros-noetic-twist-mux ros-noetic-perception-pcl ros-noetic-ros-control ros-noetic-gazebo-ros-control ros-noetic-cmake-modules ros-noetic-xacro ros-noetic-robot-state-publisher python3-catkin-tools python3-osrf-pycommon


# Necessary libraries for drivers 
read -p "Installing necessary libraries for RoboSense. Press enter to continue..."
sudo apt-get install -y libyaml-cpp-dev libpcap-dev libprotobuf-dev protobuf-compiler git


cd $HOME


echo "Creating ROS workspace"
mkdir -p ~/catkin_WS/src
cd ~/catkin_WS
catkin init
catkin config --extend /opt/ros/melodic
catkin config -DCMAKE_BUILD_TYPE=Release

echo "Downloading necessary 3rd party packages"
cd src
git clone --branch refactor/purging https://github.com/ETHZ-RobotX/smb_dev.git
vcs import . < smb_dev/smb_purged.rosinstall



