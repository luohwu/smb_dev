#!/bin/bash
#setup_sim.sh

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'


# ROS installation query
while true; do
    read -p "Do you have ROS-Noetic-Desktop in your system? : " yn
    case $yn in
        [Nn]* ) 
        	while true; do
    		read -p "Existing ROS Distro and Packages will be deleted. Do you want to continue? : " yn
    		case $yn in
        		[Yy]* ) 
        			 apt-get purge ros-*
				 sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
				 apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
				 apt update
				 apt install ros-noetic-desktop
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

echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
source ~/.bashrc

	
# Necessary packages of ROS
read -p "Necessary official ROS packages will be installed. Press enter to continue..."

 apt-get install -y ros-noetic-hector-gazebo-plugins ros-noetic-controller-manager ros-noetic-joint-state-controller ros-noetic-gazebo-plugins ros-noetic-transmission-interface ros-noetic-joint-limits-interface ros-noetic-joint-limits-interface ros-noetic-pointcloud-to-laserscan ros-noetic-twist-mux ros-noetic-perception-pcl ros-noetic-ros-control ros-noetic-gazebo-ros-control ros-noetic-cmake-modules ros-noetic-xacro ros-noetic-robot-state-publisher python3-catkin-tools python3-osrf-pycommon


# Catkin Workspace creation. User input
echo "Creating a catkin workspace directory under HOME directory."
echo "For the default name press enter directly. default = catkin_ws "
echo -e "${CYAN} IMPORTANT: directory with the same name will be deleted ${NC}"
read -p "Please type in the name of the catkin workspace directory:" WORKSPACE_NAME

# Default naming
if [ "$WORKSPACE_NAME" == "" ]; then
	
	WORKSPACE_NAME='catkin_ws'
fi

# Check if the directory name is already exist.
if [ -d ""$HOME"/"$WORKSPACE_NAME"" ]; then
	
	echo "A directory with the name '$WORKSPACE_NAME' already exists. It will be deleted."
	read -p "Press enter to continue..."
	 rm -R ~/$WORKSPACE_NAME
	
fi

# Create the directory and initilize the catkin ws
echo "Creating ROS workspace with the name '$WORKSPACE_NAME'"
mkdir -p ~/$WORKSPACE_NAME/src
cd ~/$WORKSPACE_NAME
catkin init
catkin config --extend /opt/ros/noetic
catkin config -DCMAKE_BUILD_TYPE=Release

# For later setup_hw.sh
echo "WORKSPACE_NAME_CATKIN='$WORKSPACE_NAME' " >> ~/.bashrc
source ~/.bashrc


echo "Downloading necessary 3rd party packages"
cd ~/$WORKSPACE_NAME/src
git clone --branch refactor/purging https://github.com/ETHZ-RobotX/smb_dev.git
vcs import . < ~/$WORKSPACE_NAME/srcsmb_dev/smb_purged_sim.rosinstall

# these will be removed 
git clone --branch dev/ros_control https://bitbucket.org/leggedrobotics/smb_common.git

git clone --branch dev/effort_control  https://bitbucket.org/leggedrobotics/smb_lowlevel_controller.git

# Build the packages
cd $HOME/$WORKSPACE_NAME_CATKIN
catkin build 

