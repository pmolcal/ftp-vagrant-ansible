#!/usr/bin/env bash
# 
# Configura el servidor como un nodo de control de Ansible
# 
set -xeu

# Instalar ansible
apt-get update
apt-get install -y ansible ansible-lint

# Copiar las claves SSH de Vagrant a una carpeta propia con permisos correctos
mkdir -p /home/vagrant/claves
cp -vf /vagrant/.vagrant/machines/dns/virtualbox/private_key /home/vagrant/claves/dns_key
cp -vf /vagrant/.vagrant/machines/negocio/virtualbox/private_key /home/vagrant/claves/negocio_key
chown -R vagrant:vagrant /home/vagrant/claves
chmod 700 /home/vagrant/claves
chmod 600 /home/vagrant/claves/*

# Copiar ficheros de ansible y playbooks
# Descomentar las siguientes líneas según vayamos teniendo los ficheros y
# hacer `vagrant provision ansible`
cp -vf /vagrant/ansible.cfg .              
cp -vf /vagrant/inventory.yml .            
cp -vf /vagrant/requirements.yml .         
cp -vrf /vagrant/dns .
cp -vrf /vagrant/web .
cp -vrf /vagrant/ftp .
chown -R vagrant:vagrant ./ftp

# Copiar contraseña del vault
cp -vf /vagrant/vault_pass.txt ./.vault_pass.txt
chown vagrant:vagrant ./.vault_pass.txt
chmod 600 ./.vault_pass.txt

# Instalar dependencias de Ansible
ansible-galaxy collection install -r requirements.yml     

# Provisionar con Ansible
# ansible-playbook dns/dns.yml
# ansible-playbook web/web.yml
# ansible-playbook ftp/ftp.yml
# ansible-playbook ftp/ftp.yml