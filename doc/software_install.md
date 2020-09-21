> The updated SMB software is still work in progress! Thus, this documentation is only a rough guide, not (yet) covering all aspects of setting up the software.

# Setting up the SMB software
## Prerequisites
Similar to the [software for the RSS 2019](https://github.com/ethz-asl/eth_supermegabot/blob/master/doc/software_setup.md), the SMB software has a lot of system dependencies.
Unfortunately, there is no list yet. Installing the dependencies from 2019 is a good starting point.

The SMB software runs on ROS melodic, check the [offical instructions](http://wiki.ros.org/melodic/Installation/Ubuntu) on how to set up ROS.
Make sure the package `hector_gazebo_plugins` is installed:
```
sudo apt-get install ros-melodic-hector-gazebo-plugins
```

For some of the core software packages, you'll need to be granted access by the RSL. These repositories are hosted on bitbucket, thus you'll need a bitbucket (Atlassian) account. 
Send your account details (username and associated email adress) to Johannes from RSL and ask for permission to access the RSS related SMB repositories.

## Set up a catkin workspace
We follow the same procedure as for the RSS2019.
Create a new catkin workspace.
```
mkdir -p ~/smb_2_0_catkin_ws/src
cd ~/smb_2_0_catkin_ws
catkin init
catkin config --extend /opt/ros/melodic
catkin config --merge-devel
catkin config -DCMAKE_BUILD_TYPE=Release
```

Using wstool you can manage the packages in your workspace. For that you'll need to get the .rosinstall file within this repository.
```
cd ~/smb_2_0_catkin_ws/src
git clone git@github.com:ETHZ-RobotX/SMB_dev.git
wstool init
wstool merge SMB_dev/smb2_0.rosinstall
wstool up -j8
```

If you're only interested in running the simulation, you can run
```
catkin build smb_sim smb_path_planner
```
