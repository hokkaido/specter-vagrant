
#!/usr/bin/env bash

# install git
apt-get update
apt-get install git

# install go
if [ ! -f /tmp/go1.3.3.linux-amd64.tar.gz ]; then
  wget -O /tmp/go1.3.3.linux-amd64.tar.gz https://storage.googleapis.com/golang/go1.3.3.linux-amd64.tar.gz
  tar -C /usr/local -xzf /tmp/go1.3.3.linux-amd64.tar.gz
fi

su vagrant <<'EOF'

grep '^export GOPATH' ~/.bashrc || echo export GOPATH=~/go >> ~/.bashrc
grep '^export PATH' ~/.bashrc || echo export PATH=\$PATH:/usr/local/go/bin:~/go/bin >> ~/.bashrc
GOPATH=~/go go get github.com/tools/godep

mkdir -p ~/go/src/github.com/hokkaido
git clone https://github.com/hokkaido/specter.git ~/go/src/github.com/hokkaido/specter

grep ^cd ~/.bashrc || echo cd ~/go/src/github.com/hokkaido/specter >> ~/.bashrc

EOF