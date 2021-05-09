#!/bin/bash
#setup_sim.sh

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

echo "Downloading necessary SMB simulation packages"
cd ~/catkin_ws/src
vcs import . < ~/$WORKSPACE_NAME/src/smb_dev/smb_sim.rosinstall

# these will be removed 
git clone --branch dev/ros_control https://bitbucket.org/leggedrobotics/smb_common.git

git clone --branch dev/effort_control  https://bitbucket.org/leggedrobotics/smb_lowlevel_controller.git

# Build the packages
cd $HOME/$WORKSPACE_NAME_CATKIN
catkin build 

