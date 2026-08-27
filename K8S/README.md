# Kubernetes Cluster Setup (1 Control Plane + 2 Workers)

This procedure is for Ubuntu/Debian VMs using kubeadm, containerd, and Calico.

Node plan:
- cp1: 192.168.43.131
- w1: 192.168.43.132
- w2: 192.168.43.133

Important:
- Run all steps marked "on all nodes" on cp1, w1, and w2.
- Use matching Kubernetes versions on all nodes.

## 1) Set hostnames (on each node)

On cp1:
```bash
sudo hostnamectl set-hostname cp1
```

On w1:
```bash
sudo hostnamectl set-hostname w1
```

On w2:
```bash
sudo hostnamectl set-hostname w2
```

Optional but recommended on all nodes (`/etc/hosts`):
```text
192.168.43.131 cp1
192.168.43.132 w1
192.168.43.133 w2
```

## 2) Configure static IPs (on each node)

Example netplan file (`/etc/netplan/00-installer-config.yaml`), adjusting only the node IP:

cp1:
```yaml
network:
  version: 2
  ethernets:
    enp0s3:
      dhcp4: no
      addresses:
        - 192.168.43.131/24
      routes:
        - to: default
          via: 192.168.43.1
      nameservers:
        addresses:
          - 1.1.1.1
          - 8.8.8.8
```

w1: use `192.168.43.132/24`

w2: use `192.168.43.133/24`

Apply netplan on each node:
```bash
sudo netplan apply
```

## 3) Disable swap (on all nodes) 

Comment it out in `/etc/fstab` and then reboot the machine

Verify:

```bash
free -h
swapon --show
```

## 4) Enable required kernel modules and sysctl (on all nodes)

```bash
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/kubernetes.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system
```

## 5) Install containerd and configure systemd cgroups (on all nodes)

```bash
sudo apt update
sudo apt install -y containerd

sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml

sudo systemctl restart containerd
sudo systemctl enable containerd
sudo systemctl status containerd --no-pager
```

## 6) Install kubeadm, kubelet, kubectl (on all nodes)

```bash
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl gpg
sudo mkdir -p -m 755 /etc/apt/keyrings

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.36/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.36/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl enable kubelet
```

## 7) Initialize control plane (on cp1 only)

Use a Pod CIDR that does not overlap with your node/LAN subnet (`192.168.43.0/24`).
Example used here: `10.244.0.0/16`.

```bash
sudo kubeadm init --apiserver-advertise-address=192.168.43.131 --pod-network-cidr=10.244.0.0/16
```

Configure kubectl for your user on cp1:
```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

Install Calico CNI on cp1 with the same Pod CIDR (`10.244.0.0/16`):
```bash
curl -fsSL https://raw.githubusercontent.com/projectcalico/calico/v3.29.0/manifests/calico.yaml -o calico.yaml

Important: before you apply the `calico.yaml` adjust the `CALICO_IPV4POOL_CIDR` inside `calico.yaml`. Set `10.244.0.0/16` (or whatever value you pass in `--pod-network-cidr`).

Rule of thumb:
- Node subnet, Pod CIDR, and Service CIDR must be different and non-overlapping.
- Default Service CIDR is `10.96.0.0/12` unless you set another value.

# Validate manifest syntax locally before apply
kubectl apply --dry-run=client -f calico.yaml

kubectl apply -f calico.yaml
```

## 8) Join worker nodes (on w1 and w2)

On cp1, print join command:
```bash
kubeadm token create --print-join-command
```

Run the printed `kubeadm join ...` command with `sudo` on w1 and w2.

For example:

```bash
sudo kubeadm join 192.168.43.131:6443 --token 0363a2.sx6z25fajyyjcxmk \
	--discovery-token-ca-cert-hash sha256:f45b303f01cc7c598b38d6c0f9a73e0fc45bc47a67ad67ab857ae7be98417c8a 
```

If token expired, create a new one on cp1:
```bash
kubeadm token create --print-join-command
```

## 9) Verify cluster (on cp1)

```bash
kubectl get nodes -o wide && kubectl get pods -A
```

All nodes should become `Ready`.

## 10) Quick workload test (on cp1)

```bash
kubectl create deployment nginx --image=nginx
kubectl expose deployment nginx --port=80 --type=NodePort
kubectl get svc nginx
kubectl get pods -o wide
```

## Common fixes if something fails

- If `kubeadm init` says swap is enabled, re-check `swapon --show`.
- If nodes stay `NotReady`, check CNI pods:
  - `kubectl get pods -n kube-system`
- If join fails due to token, generate a new join command on cp1.
- If time is out of sync, enable NTP/chrony on all nodes.
