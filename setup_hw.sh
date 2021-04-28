#!/bin/bash
#install.sh

# Necessary libraries for RoboSense driver
read -p "Installing necessary libraries for RoboSense. Press enter to continue..."
sudo apt-get install -y libyaml-cpp-dev libpcap-dev libprotobuf-dev protobuf-compiler git

# Flir Camera driver install
read -p "Installing driver of The RGB camera is a FLIR Blackfly S BFS-U3-16S2C. Press enter to continue..."

cd $HOME
cd ~/catkin_WS/src/smb_dev/drivers

tar -xvf spinnaker-2.4.0.143-Ubuntu20.04-amd64-pkg.tar.gz 

rm spinnaker-2.4.0.143-Ubuntu20.04-amd64-pkg.tar.gz 

cd spinnaker-2.4.0.143-arm64/

sudo dpkg  -i libgentl_2.4.0.143_amd64.deb libspinnaker_2.4.0.143_amd64.deb libspinnaker-dev_2.4.0.143_amd64.deb libspinnaker-c_2.4.0.143_amd64.deb libspinnaker-c-dev_2.4.0.143_amd64.deb

cd $HOME/catkin_WS/src

echo "Downloading packages of sensors"
vcs import . < smb_dev/smb_purged_hw.rosinstall


