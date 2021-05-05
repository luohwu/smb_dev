#!/bin/bash
#install.sh

# Necessary libraries for RealSense 
# read -p "Installing necessary libraries for RealSense. Press enter to continue..."
# sudo apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
# sudo add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u
# sudo apt-get install librealsense2-dkms librealsense2-utils

# Necessary libraries for RoboSense driver
read -p "Installing necessary libraries for RoboSense. Press enter to continue..."
sudo apt-get install -y libyaml-cpp-dev libpcap-dev libprotobuf-dev protobuf-compiler git

# Flir Camera driver install
read -p "Installing driver of The RGB camera is a FLIR Blackfly S BFS-U3-16S2C. Press enter to continue..."


cd $HOME/$WORKSPACE_NAME_CATKIN/src/smb_dev/drivers

tar -xvf spinnaker-2.4.0.143-Ubuntu20.04-amd64-pkg.tar.gz 
rm spinnaker-2.4.0.143-Ubuntu20.04-amd64-pkg.tar.gz 
cd spinnaker-2.4.0.143-amd64/
sudo dpkg -i libgentl_2.4.0.143_amd64.deb libspinnaker_2.4.0.143_amd64.deb libspinnaker-dev_2.4.0.143_amd64.deb libspinnaker-c_2.4.0.143_amd64.deb libspinnaker-c-dev_2.4.0.143_amd64.deb
rm -R spinnaker-2.4.0.143-amd64

cd $HOME/$WORKSPACE_NAME_CATKIN/src

echo "Downloading packages of sensors"
vcs import . < smb_dev/smb_purged_hw.rosinstall

cd $HOME/$WORKSPACE_NAME_CATKIN
catkin build 



