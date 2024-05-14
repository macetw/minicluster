#!/bin/sh -e

if [ ! -z GITHUB_TOKEN ]; then
    echo -n Github token:\ 
    read GITHUB_TOKEN
    export GITHUB_TOKEN
fi

set -x

curl -sfL https://get.k3s.io | sh -
sudo chmod -R a+rw /etc/rancher/k3s

k3s kubectl get node

k3s check-config
# sudo k3s kubectl get pods
# chmod a+rw -R /etc/rancher/k3s/

sudo chmod a+r /etc/rancher/k3s/k3s.yaml
cat /etc/rancher/k3s/k3s.yaml >! ~/.kube/config

kubectl get -o yaml -n kube-system configmap coredns --kubeconfig=/etc/rancher/k3s/k3s.yaml > cm.yaml
sed -i '/NodeHosts/a \    140.82.113.3 github.com' cm.yaml
kubectl apply -n kube-system --kubeconfig=/etc/rancher/k3s/k3s.yaml -f cm.yaml

curl -s https://fluxcd.io/install.sh | sudo FLUX_VERSION=2.1.2 bash

flux bootstrap github --owner macetw --repository minicluster --private=false --personal=true --token=$token --version=v2.1.2 --kubeconfig=/etc/rancher/k3s/k3s.yaml
