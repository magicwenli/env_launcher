#!bin/bash

sudo apt-get install -y vim wget git lrzsz net-tools tree nmap gcc gcc-c++ fish tmux

cp ./linux/.bashrc $home
cp ./conf/config.fish $home/.config/fish/
cp ./conf/.tmux.conf $home
tmux source-file $home/.tmux.conf

# setup git 
echo -n "enter your git user.name: "
read name
echo -n "enter your git user.email: "
read email

git config --global user.name "${name}"
git config --global user.email "${email}"

