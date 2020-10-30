> The updated SMB software is still work in progress! Thus, this documentation is only a rough guide, not (yet) covering all aspects of setting up the software.

# Setting up the SMB software
## Prerequisites
Similar to the [software for the RSS 2019](https://github.com/ethz-asl/eth_supermegabot/blob/master/doc/software_setup.md), the SMB software has a lot of system dependencies.
Unfortunately, there is no list yet. Installing the dependencies from 2019 is a good starting point.

The SMB software runs on ROS melodic, check the [offical instructions](http://wiki.ros.org/melodic/Installation/Ubuntu) on how to set up ROS.
Make sure that the following ROS packages are installed:
```bash
sudo apt-get install ros-melodic-hector-gazebo-plugins ros-melodic-joy ros-melodic-costmap-2d ros-melodic-ompl ros-melodic-base-local-planner ros-melodic-costmap-converter ros-melodic-mbf-costmap-core ros-melodic-mbf-msgs ros-melodic-libg2o ros-melodic-navfn ros-melodic-move-base
```
Installation of `GLPK` is also required:
```bash
sudo apt install libglpk-dev
```

If you're planning to use the realsense cameras (i.e. on the real robot), you'll need to [install the latest librealsense](https://github.com/IntelRealSense/librealsense/blob/master/doc/distribution_linux.md#installing-the-packages). In a nutshell:
```bash
sudo apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
sudo add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo bionic main"
sudo apt-get update
sudo apt-get install librealsense2-utils librealsense2-dkms librealsense2-dev
```

### Closed source packages
For some of the core software packages, you'll need to be granted access by the RSL. These repositories are hosted on bitbucket, thus you'll need a bitbucket (Atlassian) account. 
Send your account details (username and associated email address) to [Johannes from RSL](https://rsl.ethz.ch/the-lab/people/person-detail.MjU0MDk1.TGlzdC8yNDQyLC0xNDI1MTk1NzM1.html) and ask for permission to access the RSS related SMB repositories.

## Set up a catkin workspace
We follow the same procedure as for the RSS2019.
Create a new catkin workspace.
```bash
mkdir -p ~/smb_2_0_catkin_ws/src
cd ~/smb_2_0_catkin_ws
catkin init
catkin config --extend /opt/ros/melodic
catkin config --merge-devel
catkin config -DCMAKE_BUILD_TYPE=Release
```

Using wstool you can manage the packages in your workspace. For that you'll need to get the .rosinstall file within this repository.
```bash
cd ~/smb_2_0_catkin_ws/src
git clone git@github.com:ETHZ-RobotX/smb_dev.git
wstool init
wstool merge smb_dev/smb2_0.rosinstall
```

If you're running the software on the robot, you'll need to add some more packages.
```bash
wstool merge smb_dev/smb2_0_hw.rosinstall  
```

Once you added all packages, you need to actually download them from the repositories:
```bash
wstool up -j8
```

If you're only interested in running the simulation, you can run
```bash
catkin build smb_sim smb_path_planner
```

If you would like to run the everything on the real robot, you'can execute the following command instead:
```bash
catkin build smb_sensors smb_navigation smb_lpc
```
