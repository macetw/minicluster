#!/usr/bin/sh -ex

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
kubectl krew install ns ctx

# Install k9s
wget https://github.com/derailed/k9s/releases/download/v0.32.4/k9s_linux_amd64.deb
sudo dpkg --install ./k9s_linux_amd64.deb

# Install kubecolor
wget https://github.com/kubecolor/kubecolor/releases/download/v0.3.2/kubecolor_0.3.2_linux_amd64.tar.gz
tar -zxvf kubecolor_0.3.2_linux_amd64.tar.gz kubecolor
sudo mv kubecolor /usr/local/bin/

