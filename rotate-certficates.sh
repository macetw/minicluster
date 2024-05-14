#!/bin/sh

#  Taken from: https://docs.k3s.io/cli/certificate

# Create the target directory for cert generation.
sudo mkdir -p /var/lib/rancher/k3s/server/tls

# Copy your root CA cert and intermediate CA cert+key into the correct location for the script.
# For the purposes of this example, we assume you have existing root and intermediate CA files in /etc/ssl.
# If you do not have an existing root and/or intermediate CA, the script will generate them for you.
sudo cp /etc/ssl/certs/root-ca.pem /etc/ssl/certs/intermediate-ca.pem /etc/ssl/private/intermediate-ca.key /var/lib/rancher/k3s/server/tls

# Generate custom CA certs and keys.
curl -sL https://github.com/k3s-io/k3s/raw/master/contrib/util/generate-custom-ca-certs.sh | sudo bash -
