> The updated SMB software is still work in progress! Thus, this documentation explains the steps to install SMB software. Installation process might be lack of some dependencies. 
> Please inform oilter@ethz.ch for any missing library, package, driver or error.

# Setting up the SMB software
## Prerequisites
Ubuntu 20.04

### Closed source packages

Currently, for some of the core software packages, you'll need to be granted access by the RSL. These repositories are hosted on bitbucket, thus you'll need a bitbucket (Atlassian) account. 
Send your account details (username and associated email address) to [Johannes from RSL](https://rsl.ethz.ch/the-lab/people/person-detail.MjU0MDk1.TGlzdC8yNDQyLC0xNDI1MTk1NzM1.html) and ask for permission to access the RSS related SMB repositories.


## Setting up Catkin Workspace and all Packages

Download the installation shell script (setup_sim.sh) and run it. Please read carefully the shell outputs/inputs. You might loose some important files during the installation process.

```bash
cd ~/Downloads
wget https://raw.githubusercontent.com/ETHZ-RobotX/smb_dev/refactor/purging/setup_sim.sh
source setup_sim.sh
```
The shell script will install every necessary package along with their dependencies for SMB simulation. You will be asked several question during the installation. Please read them carefully.

If you want to run everything on real robot you should run following commend after the previous step.

```bash
source $HOME/$WORKSPACE_NAME_CATKIN/src/smb_dev/setup_hw.sh
```

The shell script will install every hardware dependency and necessary sensor driver along with their packages.


