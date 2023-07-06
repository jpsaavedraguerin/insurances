#!/bin/bash
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo dnf update && sudo dnf upgrade -y
cat <<EOF > /etc/yum.repos.d/adoptium.repo
[Adoptium]
name=Adoptium
baseurl=https://packages.adoptium.net/artifactory/rpm/amazonlinux/2/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://packages.adoptium.net/artifactory/api/gpg/key/public
EOF
sudo dnf update 
# install git
sudo dnf -y install git-all
# install docker
sudo dnf -y install docker
# install docker-compose
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
# install java
sudo dnf -y install temurin-17-jdk
# expand tmp (t2.micro is too small, we need to expand the swap memory)
cd                                 
fallocate -l 4G mydrive.img    
mkfs -t ext3 mydrive.img        
sudo umount /tmp                
sudo mount -t auto -o loop mydrive.img /tmp

sudo systemctl enable docker.service
sudo systemctl start docker.service

sudo usermod -a -G docker ec2-user