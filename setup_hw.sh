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

wget 'https://public.boxcloud.com/d/1/b1!Pb4teMP-JF-TsTmXF_cOaFTGsdolIuLEz6mshdQIboGyv-fsmvF2a9s2LGEeNKCx4XhQ6rrjPw6WOLH28_a3pG81uNJGYaWIU5GrPwLEVoehPb9lSgvdmftbK8mFxF-sGKGOAsmKdw2nnTni6Tbq1sfz4-sUsZm0LS0TIVxUuzKz4c0oag6oUS7sV6OzwIpFYpFJxthQqNM4Hzr6RglY74TvkB4AhmzDEhBWl9WW7tITEDi-OzIvSzl72z60jLzP1FD4ZON3OvisAmHS-0gn8brvGUAk-D5Okm8Y3Ch5rofx_s2AsuLjs-6rn7rUL55xYfhzw3SwueRnijH5eIBYTlSuCsOQQHDq5L-FVJyfkab-dXKNn7WENeEqRvW_JuXEoq-KK-ZEG1_-gRXHM4i8SPmq4uEh8u3TiRZFFSs5XEBeRNVXuR9sjkO7_YxT5Sv874RoLyC2_NomGjfxVWCAAJe9ySHoDTUfJ2WiC1r_62Ucgs1ys-lw27CUO1E4iE5k1EeCvzBp2BjS0dJJ60-x_SxQojv5N1b41-9fFQb4mgI5-qCXV_F7dC9Z_zTfY2-OERReKLDxR0fkA1F8QcZkE7K_6-uGO5kKI0oGsF86pUfHL1XUx9-D3fzlgw8IuR4Rv2GLVvemG9bE3Ks86aLSaIjqnYkjLwlykzuYZJ1oSk7ygI1rEiqaiFC5ySLOy-A1pyubMav-Qj0TGtur94o6PF3BTct9vjzzDHnqj-DhRLPGNmhl2S1_xd7vJ5bhroNZdSgYqRtjezG62alsUhrxA0_VtR-PIg_QJ1ir_HuIBvIMZli5TOLOOW8cV9LvNHfbIR-zipNcfx9DPpF4Bf8_1HU8yqX83j3-DyUWXsmYiH1ogaAXF0LtFSJiyw4wMUX8JESpEuxgB_vjFGcUF4j_DXRCRQ5Nj_gzGP-EpyEjUp5oYKielnCwalmR69PeV7b-9grLsn32L0Pb4dZpGkPZ2_9wePnLhlaVuqX189KCT3cbKTirrvP3c4Bc76Iz2m6WMRHFb-G5OO06x6PDSviC8xK-_6AjZ2tbXU450D9IHF6PxBU4k0yW2-j-_cmOG9TGmod3JAXCYIbSF640lMjn72L_q0FLILwahTRuGi4r0NX09HyetTNhmMpY13XMcGW1BDYVx3tEZaTma-TZRut7zDZvuKMtiPjhzB2au17bHYYPekbfGHbYiHYHbSD5lqHZN1KP9SgVlIzmMz57DY9eVlv_Do8HLkQUiAUQYrnWsg8od_HAwEPSr36SUd5VMhXNxOg3C6bCa0kmkwox00-MpClcwqulF2mL1XkZdCEdaavEFr-v4Sz_A-C6LZKPHems_mbfDR6BtL7pveWQBrMmYcgByGOu0kCQDAX-B36CfEpFosFOq-c-jfmdtopsQ6OSEi5laf6hH8YcoJNMalRZGNP_gaESYkpjNhxWSwY./download' -O spinnaker-2.4.0.143-Ubuntu20.04-arm64-pkg.tar.gz

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


