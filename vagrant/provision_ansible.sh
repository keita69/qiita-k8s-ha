sudo tee -a /home/vagrant/.ssh/config << EOS
Host 172.16.*.*
StrictHostKeyChecking no
UserKnownHostsFile=/dev/null
EOS
sudo chmod 600 /home/vagrant/.ssh/config
sudo chown vagrant:vagrant /home/vagrant/.ssh/config

sudo yum install -y epel-release
sudo yum install -y ansible

sudo ln -s /vagrant/ansible ansible

