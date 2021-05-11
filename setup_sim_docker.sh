#!/bin/bash
#setup_sim.sh

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

source /ros_entrypoint.sh

apt-get update

apt-get install -y apt-utils nano wget python3-catkin-tools python3-osrf-pycommon git python3-pip python3-vcstools

apt-get install -y ros-noetic-rviz ros-noetic-hector-gazebo-plugins ros-noetic-controller-manager ros-noetic-joint-state-controller ros-noetic-gazebo-plugins ros-noetic-transmission-interface ros-noetic-joint-limits-interface ros-noetic-joint-limits-interface ros-noetic-pointcloud-to-laserscan ros-noetic-twist-mux ros-noetic-perception-pcl ros-noetic-ros-control ros-noetic-gazebo-ros-control ros-noetic-cmake-modules ros-noetic-xacro ros-noetic-robot-state-publisher python3-catkin-tools python3-osrf-pycommon git python3-pip python3-vcstools	


mkdir ~/Downloads
mkdir -p ~/catkin_ws/src

echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
source ~/.bashrc

cd ~/catkin_ws
catkin init
catkin config --extend /opt/ros/noetic
catkin config -DCMAKE_BUILD_TYPE=Release


echo "Downloading necessary SMB simulation packages"
cd ~/catkin_ws/src
git clone --branch refactor/purging https://github.com/ETHZ-RobotX/smb_dev.git
vcs import . < ~/$WORKSPACE_NAME/src/smb_dev/smb_sim.rosinstall

# these will be removed 
git clone --branch dev/ros_control https://bitbucket.org/leggedrobotics/smb_common.git

git clone --branch dev/effort_control  https://bitbucket.org/leggedrobotics/smb_lowlevel_controller.git

# Build the packages
cd $HOME/$WORKSPACE_NAME_CATKIN
catkin build 

