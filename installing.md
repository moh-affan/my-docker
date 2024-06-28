# Installing docker

1. install curl <br/>
```sudo apt-get install -y apt-transport-https ca-certificates curl```
2. add docker gpg <br/>
```curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg```
3. add docker repo <br/>
```echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null```
4. update repo <br/>
```sudo apt update```
5. install docker <br/>
```sudo apt install docker-ce docker-ce-cli containerd.io```
6. add current user to docker group <br/>
```sudo usermod -aG docker <username>```
7. apply group membership <br/>
```newgrp docker```
8. test docker <br/>
```docker run hello-world```
9. get docker info <br/>
```docker info```

# Installing kubernetes

1. turn off swap <br/>
```sudo swapoff -a```
2. unmount swap with comment out /swap.img <br/>
```sudo nano /etc/fstab```<br/>
```#/swap.img      none    swap    sw      0       0```
3. update hostname resolutions (`/etc/hosts`)
```172.17.36.9  bkpsdm-9```<br/>
```172.17.36.10  bkpsdm-10```<br/>
```172.17.36.12  bkpsdm-12```
4. Set up the IPV4 bridge on all nodes<br/>

```
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system
```

5. install k3s on master node<br/>
`curl -sfL https://get.k3s.io | sh -`
9. create token on master node<br/>
`sudo k3a rokwn create`
10. install k3s on worker<br/>
`curl -sfL https://get.k3s.io | K3S_URL=https://<MASTER_IP>:6443 K3S_TOKEN=<NODE_TOKEN> sh -
`
example ` curl -sfL https://get.k3s.io | K3S_URL=https://172.17.36.9:6443 K3S_TOKEN=K10d2da0fc99504aabe64f4798039276128a9e85f4c445cd84deef495622e1776c7::c5jqa0.y62agv99cawwak2d sh -`


srcs:
1. [https://www.digitalocean.com/community/tutorials/how-to-setup-k3s-kubernetes-cluster-on-ubuntu](https://www.digitalocean.com/community/tutorials/how-to-setup-k3s-kubernetes-cluster-on-ubuntu)
2. [https://chatgpt.com/c/63139d02-f60d-4ea4-9180-77556a01f834](https://chatgpt.com/c/63139d02-f60d-4ea4-9180-77556a01f834)

extend lvm
`sudo lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv`
`sudo resize2fs /dev/ubuntu-vg/ubuntu-lv`