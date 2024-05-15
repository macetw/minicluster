#!/bin/sh -e

if [ -z "$GITHUB_TOKEN" ]; then
    echo -n Github token:\ 
    read GITHUB_TOKEN
    export GITHUB_TOKEN
fi

set -x

curl -sfL https://get.k3s.io | sh -
sudo chmod -R a+rw /etc/rancher/k3s

k3s kubectl get node

k3s check-config

sudo chmod a+r /etc/rancher/k3s/k3s.yaml
cat /etc/rancher/k3s/k3s.yaml > ~/.kube/config

kubectl get -o yaml -n kube-system configmap coredns > /tmp/cm.yaml
sed -i '/NodeHosts/a \    140.82.113.3 github.com' /tmp/cm.yaml
kubectl apply -n kube-system -f /tmp/cm.yaml
rm -f /tmp/cm.yaml

curl -s https://fluxcd.io/install.sh | sudo FLUX_VERSION=2.3.0 bash

flux bootstrap github --owner macetw --repository minicluster --private=false --personal=true --token=$token --version=v2.3.0


# Needed for ingress-nginx:
# openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout /tmp/tls.key -out /tmp/tls.crt -subj "/CN=nginxsvc/O=nginxsvc"
# kubectl create secret tls tls-secret --key /tmp/tls.key --cert /tmp/tls.crt
# rm -f /tmp/tls.key /tmp/tls.crt
