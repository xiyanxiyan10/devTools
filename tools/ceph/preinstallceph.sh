#PreInstall ceph-deploy on centos
#remove old ceph-deploy
yum remove ceph-deploy

#clean old conf
rm -rf /etc/ceph/*
rm -rf /var/lib/ceph/*/*
rm -rf /var/log/ceph/*
rm -rf /var/run/ceph/*

#stop fireware
iptables -F 
getenforce 
setenforce 0

#install ceph-deploy
cd /etc/yum.repos.d/
mv CentOS-Base.repo CentOS-Base.repo.bak
sudo wget -O CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
yum cleancache
yum clean all
yum makecache
sudo yum update && sudo yum install ceph-deploy

#Install ceph by ceph deploy 
# set ssh login
# set hostname
# install ceph

