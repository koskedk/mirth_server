#!/bin/bash

# update the packages/repositories. the y flag makes it run silently, with no prompts
# adding the '> /dev/null' at the end of each command suppresses the output from the installation processes. 
# If you would like to see the output when provisioning, simply remove it.
echo "==============: updating the repos..."
sudo apt-get -y update > /dev/null

# this creates a cleartext copy of your password in /var/cache/debconf/passwords.dat 
# (which is normally only readable by root and the password will be deleted by the 
# package management system after the successfull installation of the mysql-server package).
# this is so that mysql installs without a prompt for a password
echo "==============: creating the mysql password at /var/cache/debconf/passwords.dat"
echo mysql-server mysql-server/root_password password root | sudo debconf-set-selections
echo mysql-server mysql-server/root_password_again password root | sudo debconf-set-selections

# install mysql-server
echo "==============: installing mysql-server..."
sudo apt-get -y install mysql-server > /dev/null

# start the mysql service
echo "==============: starting the mysql service..."
sudo service mysql start > /dev/null

# ensure mysql will start each time the server reboots
echo "==============: setting mysql start-mode to automatic in case of a system reboot"
sudo /usr/sbin/update-rc.d mysql defaults

echo "==============: using createdb script to create a db, a new user, and grant the new user all permissions to the new db.PS: You should avoid using the root user"
./createdb mirthdb mirthuser mirthpass

# make sure we dont have any other jdk installed
echo "==============: purging any existing jdk..."
sudo apt-get purge openjdk-\* > /dev/null

# install this to add the add-apt-repository command
echo "==============: installing python-software-properties..."
sudo apt-get -y install python-software-properties > /dev/null

# add the oracle java PPA (Personal Package Archive)
echo "==============: adding the oracle PPA..."
sudo add-apt-repository -y ppa:webupd8team/java > /dev/null

# update the repositories with the just-installed PPA
echo "==============: updating the repos to reflect the newly added PPA..."
sudo apt-get -y update > /dev/null

# accept oracle's license agreement
echo "==============: accepting the oracle license agreement..."
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections

# install java
echo "==============: installing java 8..."
sudo apt-get -y install oracle-java8-installer > /dev/null

# Now we're ready to install Mirth Connect.
# Assuming mirth connect installer is on this pwd (current working directory)
# Set the permissions to be able to run the installer script
# chmod stands for change mode (change access permissions).
# a+x means allow execute permission to all users
# check out http://ss64.com/bash/chmod.html for more information
echo "==============: allowing execute permission on mirth connect to all users..."
sudo chmod a+x mirthconnect-3.2.2.7694.b68-unix.sh

# Now run the Mirth Connect installer at /opt/mirthconnect
# symlinks created at /usr/local/bin
echo "==============: running the mirth connect installer, version 3.2.2.7694.b68"
sudo ./mirthconnect-3.2.2.7694.b68-unix.sh

# start mirth service
echo "==============: starting mirth service"
sudo service mcservice start

# Resources
# -----------
# https://gist.github.com/jgautsch/9157402
# https://www.youtube.com/watch?v=omZyAO2naqs
# http://www.rackspace.com/knowledge_center/article/installing-mysql-server-on-ubuntu
# http://www.bluepiccadilly.com/2011/12/creating-mysql-database-and-user-command-line-and-bash-script-automate-process

