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
sudo dnf -y install temurin-17-jdk
wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war
sudo java -jar jenkins.war --httpPort=9091 -y
sudo dnf -y install git-all

# expand tmp
cd                                 
fallocate -l 2G mydrive.img    
mkfs -t ext3 mydrive.img        
sudo umount /tmp                
sudo mount -t auto -o loop mydrive.img /tmp

sudo systemctl start jenkins
