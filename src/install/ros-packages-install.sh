# Change this for dev install
ROWBOAT_INSTALL_DIR=/home/odroid/rowboat1/src

# Install ROS packages
sudo apt-get -y install ros-jade-image-transport

# Make all local workspaces and add paths to workspace
for ws in safety arbiter navigator
do
    catkin_make -C $ROWBOAT_INSTALL_DIR/$ws
    echo "source $ROWBOAT_INSTALL_DIR/$ws/devel/setup.bash" >> ~/.bashrc
done

# Make sure the user can source the ROS workspaces
# chmod -R 755 /vagrant/*

exit
