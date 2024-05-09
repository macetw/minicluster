```
  git clone https://github.com/macetw/minicluster
  cd minicluster/
  terraform init
  terraform plan
  terraform apply

  curl -sfL https://get.k3s.io | sh - 
  sudo k3s kubectl get node 

  k3s check-config
  sudo k3s kubectl get pods
  chmod a+r -R /etc/rancher/k3s/

  # how do I put this k3s cluster into my kube config??

  curl https://get.helm.sh/helm-canary-linux-amd64.tar.gz
  tar -xzvf ~/Downloads/helm-canary-linux-amd64.tar.gz
  sudo cp linux-amd64/helm /usr/local/bin

  helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
  helm repo update
  helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack
    # Fail, cannot install to cluster.
```
