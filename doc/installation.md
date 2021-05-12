
# Setting up the SMB Simulation Software
> The updated SMB software is still work in progress! Thus, this documentation explains the steps to install SMB software. Installation process might be lack of some dependencies. 

> Please inform oilter@ethz.ch for any missing library, package, driver, error or any kind of unclear instruction.

## Remark

SMB system consist of two part: simulation and hardware. If you want to use the system on a real SMB Robot with real sensors and actuators, hardware part should be installed **on top of the simulation part**. This document contains the instruction about SMB Simulation Software. To install SMB Simulation Hardware plaese refer to this document. 

[comment]: <> (TODO: Add hardware document link )


## Prerequisites
- ROS Noetic
> Note that, the system has been developed in Ubuntu 20.04.

To see if the system has the correct ROS distribution please use the following terminal command. 

```bash
echo $ROS_DISTRO
# output: noetic
```
If you do not see the output, please refer to the [official ROS website](http://wiki.ros.org/noetic/Installation/Ubuntu) to install **ROS Noetic Desktop**. 

After installation, please ensure that environment variables like ROS_ROOT and ROS_PACKAGE_PATH are set in order to verify the installation by running the following terminal command.

```bash
printenv | grep ROS
```
[comment]: <> (TODO: Noetic Desktop or Desktop Full )

## Closed source packages

Currently, for some of the core software packages, you'll need to be granted access by the RSL. These repositories are hosted on bitbucket, thus you'll need a bitbucket (Atlassian) account. 
Send your account details (username and associated email address) to [Johannes from RSL](https://rsl.ethz.ch/the-lab/people/person-detail.MjU0MDk1.TGlzdC8yNDQyLC0xNDI1MTk1NzM1.html) and ask for permission to access the RSS related SMB repositories.

[comment]: <> (TODO: Is the name correct? )

## Catkin Workspace and all Packages

Create a new catkin workspace.

```bash
# crete the directories
mkdir -p <directory_to_ws>/<catkin_ws_name>/src
cd <directory_to_ws>/<catkin_ws_name>/

# initilize the catkin workspace
catkin init
catkin config --extend /opt/ros/noetic
catkin config -DCMAKE_BUILD_TYPE=Release
```
example: 

```bash
# Example directory to ws and catkin workspace name
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/
# Example ends
```
To download the SMB packages, the vcs command-line tools will be used. For more information about the tool you can check the [link](http://wiki.ros.org/vcstool).

To install vcstool run the following terminal command.

```bash
sudo apt install python3-vcstool
```
To download the SMB packages by using vcs tool run the following terminal command. 

```bash
vcs import --recursive --input https://raw.githubusercontent.com/ETHZ-RobotX/smb_dev/refactor/purging/smb.repos .

# Example ends
```
