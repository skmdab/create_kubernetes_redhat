#!/bin/bash
#
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sysctl --system

yum install ca-certificates curl gnupg redhat-lsb-core yum-utils -y

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

yum update -y
yum install containerd -y

containerd config default > /etc/containerd/config.toml
sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
sed -i 's/sandbox_image = "registry\.k8s\.io\/pause:3\.6"/sandbox_image = "registry\.k8s\.io\/pause:3\.9"/' /etc/containerd/config.toml

systemctl restart containerd
systemctl enable containerd

yum install -y yum-utils ca-certificates curl

cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

yum update -y && yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

yum install yum-plugin-versionlock -y
yum versionlock add kubelet kubeadm kubectl

systemctl daemon-reload
systemctl start kubelet
systemctl enable kubelet.service

