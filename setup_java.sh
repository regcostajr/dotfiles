#!/bin/bash

wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" -qO- http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-x64.tar.gz | sudo tar -C /opt/ -xzv
wget -qO- www-us.apache.org/dist/maven/maven-3/3.5.3/binaries/apache-maven-3.5.3-bin.tar.gz | sudo tar -C /opt/ -xzv

echo 'export JAVA_HOME=/opt/jdk1.8.0_172/' | sudo tee /etc/profile.d/java.sh
echo 'export PATH=$PATH:/opt/jdk1.8.0_172/bin' | sudo tee -a /etc/profile.d/java.sh
echo 'export M2_HOME=/opt/apache-maven-3.5.3/' | sudo tee -a /etc/profile.d/java.sh
echo 'export PATH=$PATH:/opt/apache-maven-3.5.3/bin'| sudo tee -a /etc/profile.d/java.sh


