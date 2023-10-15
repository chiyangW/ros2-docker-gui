#!/bin/bash
set -e
set -o pipefail
#Configure the moveit2 tutorial from https://moveit.picknik.ai/main/doc/tutorials/tutorials.html
set -v
# update ros packages
rosdep update
sudo apt update
sudo apt dist-upgrade

#install colcon with mixin
sudo apt install python3-colcon-common-extensions
sudo apt install python3-colcon-mixin
colcon mixin add default https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml
colcon mixin update default

#install vcstool
sudo apt install python3-vcstool

#Create workspace for the tutorial
mkdir -p ~/ws_moveit/src

#Change directory to the workspace and pull the tutorial
cd ~/ws_moveit/src
git clone https://github.com/ros-planning/moveit2_tutorials

#Download source code for Moveit
vcs import < moveit2_tutorials/moveit2_tutorials.repos

#Install Moveit and dependencies
sudo apt update && rosdep install -r --from-paths . --ignore-src --rosdistro $ROS_DISTRO -y

#Configure the workspace
cd ..
colcon build --mixin release
