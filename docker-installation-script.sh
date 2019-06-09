#!/bin/sh

# Add GPG key for official Docker repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker repo to APT sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable edge"

# Update the package database with Docker packages
echo "*** Updating the package manager. ***"
sudo apt-get update

# Make sure you are installing from the Docker repo and not the default Ubuntu repo
apt-cache policy docker-ce

# Create the docker group
if groups | grep -qw "docker"; then
  echo "*** The docker group already exists ***"
else
  sudo groupadd docker
  echo "*** docker group created ***"
fi

# Allow user brian to run docker with directly using sudo
if groups brian | grep -qw "docker"; then
  echo "*** User brian is already a member of the docker group ***"
else
  sudo usermod -aG docker brian
  echo "*** Added user brian to the docker group ***"
fi

# Run hello-world program to verify the installation was successful
docker run hello-world

echo "*** Install is now complete. Please reboot your system... ***"
