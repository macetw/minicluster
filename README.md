```
  git clone https://github.com/macetw/minicluster
  cd minicluster/
  terraform init
  terraform plan
  terraform apply

  curl -sfL https://get.k3s.io | sh -
  sudo k3s kubectl get node

  # install krew:
  (
    set -x; cd "$(mktemp -d)" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    KREW="krew-${OS}_${ARCH}" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
    tar zxvf "${KREW}.tar.gz" &&
    ./"${KREW}" install krew
  )
  echo export PATH='${KREW_ROOT:-$HOME/.krew}/bin:$PATH' > ~/.bashrc

  k3s check-config
  sudo k3s kubectl get pods
  chmod a+rw -R /etc/rancher/k3s/
  # We also need write access if we intend to change the default namespace with the krew `ns` command

  # Install k9s
  wget https://github.com/derailed/k9s/releases/download/v0.32.4/k9s_linux_amd64.deb
  sudo dpkg --install ./k9s_linux_amd64.deb

  # Install kubecolor
  wget https://github.com/kubecolor/kubecolor/releases/download/v0.3.2/kubecolor_0.3.2_linux_amd64.tar.gz
  tar -zxvf kubecolor_0.3.2_linux_amd64.tar.gz kubecolor
  sudo mv kubecolor /usr/local/bin/

  # Update the coredns with github.com
  kubectl edit -n kube-system configmap coredns
  # Add to NodeHosts:
  #   140.82.113.3 github.com


  curl -s https://fluxcd.io/install.sh | sudo FLUX_VERSION=2.1.2 bash

  kubectl apply -f flux-system/namespace.yaml

  # make a fine-grained token and use it in the next step
  # don't need it here: kubectl create secret generic flux-github-token --from-literal=token=github_pat_my-token  -n flux-system
  # but we need it here:
  flux bootstrap github  --owner macetw --repository minicluster --private=false --personal=true  --token=$token --token-auth --version=v2.2.3

  curl https://get.helm.sh/helm-canary-linux-amd64.tar.gz
  tar -xzvf ~/Downloads/helm-canary-linux-amd64.tar.gz
  sudo cp linux-amd64/helm /usr/local/bin

  helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
  helm repo update
  helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack
    # Fail, cannot install to cluster.
```
