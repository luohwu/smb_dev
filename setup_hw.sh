#!/bin/bash
#install.sh

# Necessary libraries for RoboSense driver
read -p "Installing necessary libraries for RoboSense. Press enter to continue..."
sudo apt-get install -y libyaml-cpp-dev libpcap-dev libprotobuf-dev protobuf-compiler git

# Flir Camera driver install
read -p "Installing driver of The RGB camera is a FLIR Blackfly S BFS-U3-16S2C. Press enter to continue..."

cd $HOME

if ! -d "~/Drivers"
then
	echo "Drivers directory does not exist." 
	echo "Creating a directory with the name 'Drivers' "
	mkdir Drivers


else 
	echo "Drivers directory exists." 
fi

cd Drivers

wget 'https://public.boxcloud.com/d/1/b1!aCpLdgsxMTYMeKhr1EXbEfyX7Zf_23f8Bime2m_vFjLwGYSL5v0d3jRxrW_3nDDmn2PBbtdrj_Axm000nJkDSIfJJI6P9K9c0Vj8PbS5GqssSCMlkUt3i6ZjO5UB0oS29MHtUd0qel2_5BpeeF9yndmo43Tayv0eShNUh0CyFahLI2z3MuMzAvahK9697Qx2LcK3JyZrFTBvThyR78hYHXXqrjN0MNmuKEbUfLTh8U6UZ-ZzRB0uJhRvLLzU0t1iqTG9xooVYNcoJYfPU0pfBnQwLY2bywxA8pmYVSLJHYp2uVCcGQ9dstREouveocCHyACZH76ZG407MmS6oNoTonRGUeA2aWFhkIvkEF3OS7OrArpgsRCx2Nz4Qli4FruTHebQpWu89uc2BBG1q8SNH9siSVPolIwTH0dkSStrzW0apP9tU58rV9Qch8babIv0F_rLbP84JTTe0gv95VJV3ONFfWUd7_osA2QUqplv1z9VU9iQtCK65N0shhdMhM0yYf8_Nekjjft3zlP80BTscAoMg170Cjjd7KuKFlMlyXl2fBtnSKEG69R8M5DeleKoSwRT2R_DPzUrunZIdb9ufV74mKVYyC10penm_IO_5xYDWs5XFNRzL18sdOgov70rGpMe0nEIV7y3LYVcy-ACefaajHsjnM07XseCaP8-ouaHsvn1_vAdXsxgxFdNxQd37tLRjllxhF0ZvKDX0Nez6zWnmWdcanAfplfLs5RWQEMpmrAEna27h2vnL1RtGU8IczVN-1RHmoWcjZixHAqqHb10LvAQ6y3tPcV1UH-op6FK1bypgiAZSgIS3VsVG0xArIo6lVINec27mwEBJNcknSl2reERAIqHKcSJezc4sKo7gB8cI5ZUuqf1VU_Vr03LUyHxb3OqeEA0g4rMT2X8NhX9AQBddOG3PfMiB5x0bfNZZ3gEu2yihiMaaUxdTzT6eWcCe7-7fAWnSztDnKIgpidBylQdVoT_6FIhAiHMCpD70tGbkzfrA6DnUkKTdRlr2XTfFTKbG3jDa-LHiLeDbH_3SjTxJvUiCU-mbr5iKzDcmIc-HzscB-cdR8sex9Myf6B8W4HYcf1bOb3vceJUNsBBqpxTDF-Z1wi1uccZa-mWtCHjbG6O4PkcYrXT2vgPp--zh0Kdvsm7Cuf6VGAMlqJj4GAdIUMto-3i0muQT7ilcVFHLi9cTnsY7ecnZ4XgZLSv47O70EgjjqJkpjz77-TSzjbdjaW1anyTmQNJCzztFmf24vJaGU6nctJ5tCtLJmPzEBPqLcvUpXCmenK1BsOb4oCFBy_UFUlvPV8zHBbvk0v_1ADtA3gGpwoLI6SyiNvFxJghX8RF7fVSHJNEXabR3cyLzmGFCwCz87Qzz4uQcImXArFKLtEWyg3mNzGh3Dh2uMkuLd2mjBzSnYvvORn2TtEk-311DbdjVQ../download' -O spinnaker-2.4.0.143-Ubuntu20.04-arm64-pkg.tar.gz

tar -xvf spinnaker-2.4.0.143-Ubuntu20.04-arm64-pkg.tar.gz 

rm spinnaker-2.4.0.143-Ubuntu20.04-arm64-pkg.tar.gz 

cd spinnaker-2.4.0.143-arm64/

sudo dpkg  -i libgentl_2.4.0.143_amd64.deb libspinnaker_2.4.0.143_amd64.deb libspinnaker-dev_2.4.0.143_amd64.deb libspinnaker-c_2.4.0.143_amd64.deb libspinnaker-c-dev_2.4.0.143_amd64.deb


cd $HOME
cd ~/catkin_WS
cd src

echo "Creating ROS workspace"
mkdir -p ~/catkin_WS/src
cd ~/catkin_WS
catkin init
catkin config --extend /opt/ros/melodic
catkin config -DCMAKE_BUILD_TYPE=Release

echo "Downloading packages of sensors"
vcs import . < smb_dev/smb_purged_hw.rosinstall


