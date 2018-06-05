#!/bin/bash

# Turning off the containers
docker-compose down

# Clean the jenkins_folder
rm -rf jenkins_home
mkdir -p jenkins_home
touch jenkins_home/.gitkeep

# Remove the Drone CI database
sudo rm /var/lib/drone/drone.sqlite
