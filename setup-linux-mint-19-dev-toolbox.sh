#!/bin/sh
#Setup Java development enviroment for Linux Mint 19 (Cinnamon) 

# install updates & security patches
sudo apt update && sudo apt upgrade -y 

# install multimedia codecs
sudo apt install -y ubuntu-restricted-extras mint-meta-codecs vim httpie 

# improve system power management
sudo add-apt-repository ppa:linrunner/tlp && \
sudo apt update && \
sudo apt install -y tlp tlp-rdw && \
sudo tlp start

sudo add-apt-repository ppa:ubuntuhandbook1/apps && \
sudo apt update && \
sudo apt install -y laptop-mode-tools

# install Microsoft Truetype fonts
wget http://httpredir.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb && \
sudo dpkg -i ttf-mscorefonts-installer_3.6_all.deb
	
# remove asian fonts
sudo apt remove \
    fonts-kacst* fonts-khmeros* fonts-lklug-sinhala fonts-guru-extra fonts-nanum* \
    fonts-noto-cjk fonts-takao* fonts-tibetan-machine fonts-lao fonts-sil-padauk  \
    fonts-sil-abyssinica fonts-tlwg-* fonts-lohit-* fonts-beng-extra fonts-gargi  \
    fonts-gubbi fonts-gujr-extra fonts-kalapi fonts-lohit-* fonts-samyak*         \
    fonts-navilu fonts-nakula fonts-orya-extra fonts-pagul fonts-sarai fonts-telu*\
    fonts-wqy* fonts-smc* fonts-deva-extra

sudo dpkg-reconfigure fontconfig

# enable firewall
sudo ufw enable

# install chrome browser
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list && \
sudo apt update && \
sudo apt install -y google-chrome-stable

# install java8
sudo add-apt-repository ppa:webupd8team/java && \
sudo apt update && \
sudo apt install -y oracle-java8-installer oracle-java8-set-default 

# set JAVA_HOME & JRE_HOME
cat >> ~/.bashrc <<EOL \
export JAVA_HOME=/usr/lib/jvm/java-8-oracle \
export JRE_HOME=/usr/lib/jvm/java-8-oracle/jre \
export PATH=$JAVA_HOME/bin:$PATH \
EOL  

# install IntelliJ IDEA Ultimate Edition
wget https://download.jetbrains.com/idea/ideaIU-2016.2.tar.gz && \
tar -xzvf ideaIU-2016.2.tar.gz

# install Maven
cd /opt/ 
sudo wget http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz && \
sudo tar -zxvf apache-maven-3.3.9-bin.tar.gz && \
sudo rm -f apache-maven-3.3.9-bin.tar.gz && \
export MAVEN_HOME=/opt/apache-maven-3.3.9 && \
export PATH=$MAVEN_HOME/bin:$PATH 

# install git
sudo apt install -y git git-flow && \
git config --global user.email "tommy.brettschneider@device-insight.com" && \
git config --global user.name  "Tommy Brettschneider"

# install Docker
sudo apt install -y docker.io docker-compose && \ 
sudo usermod -a -G docker $USER && \ 
sudo systemctl start docker && \
sudo systemctl enable docker 

# install Visual Studio Code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && \
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' && \
sudo apt install -y apt-transport-https && \
sudo apt update && \
sudo apt install -y code

# install Skype
wget https://repo.skype.com/latest/skypeforlinux-64.deb && \
sudo dpkg -i skypeforlinux-64.deb && \
sudo apt install -f

# cleanup system
sudo apt autoclean
sudo apt clean
sudo apt autoremove

# check config
echo $JAVA_HOME
echo $JRE_HOME
echo $MAVEN_HOME
echo $PATH
 
