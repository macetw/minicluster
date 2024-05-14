```
  git clone https://github.com/macetw/minicluster
  cd minicluster/
  terraform init
  terraform plan
  terraform apply

  # Run script to install k3s:
  ./install-k3s.sh

  # make a fine-grained token and use it in the next step
  # Repo access needed:
  #   * Administration: Read & Write
  #   * Contents: Read & Write
  #
  # We need it here:
  flux bootstrap github  --owner macetw --repository minicluster --private=false --personal=true  --token=$token --token-auth --version=v2.1.2

  curl https://get.helm.sh/helm-canary-linux-amd64.tar.gz
  tar -xzvf ~/Downloads/helm-canary-linux-amd64.tar.gz
  sudo cp linux-amd64/helm /usr/local/bin

  helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
  helm repo update
  helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack
    # Fail, cannot install to cluster.
```
