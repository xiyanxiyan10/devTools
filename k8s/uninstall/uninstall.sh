#shell used for clean env on computer before install k8s(centos)  
docker stop $(docker ps -q)
docker rm $(docker ps -a -q)
systemctl stop docker 
systemctl disable docker
reboot
#wait computer restart 

rm -rf /var/lib/docker
rm -rf /etc/kubernetes/
rm -rf /etc/ssl/etcd/
rm -rf /var/lib/kubelet
rm -rf /var/lib/etcd
rm -rf /usr/local/bin/kubectl
rm -rf /etc/systemd/system/calico-node.service
rm -rf /etc/systemd/system/kubelet.service
rm -rf /etc/systemd/system/kubelet.service.d
rm -rf /etc/systemd/system/docker.service.d/
rm -rf /etc/systemd/system/docker.service 
rm -rf /etc/systemd/system/etcd.service

#屏蔽掉 /etc/fstab 中的swap
swapoff --all
setenforce 0
systemctl stop firewalld

















































