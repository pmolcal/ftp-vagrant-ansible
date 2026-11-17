&#x20;FTP con Vagrant y Ansible



* Objetivo



Se van a construir tres maquinas virtuales con Debian, creadas con Vagrant: un servidor DNS, un servidor web con apache y FTP seguro, y una maquina que usa Ansible para configurar las otras dos.



El objetivo es practicar como montar un servidor FTP seguro con usuarios y permisos distintos y conexión cifrada , todo instalado de forma automática.



* Herramientas



\- GitHub: web donde se guarda el proyecto y las tareas

\- Git: programa que guarda las versiones del proyecto

\- Vagrant:crea las máquinas virtuales

\- VirtualBox:programa que hace funcionar las máquinas virtuales

\- Ansible:configura los servidores automáticamente

\- BIND9:servidor DNS (traduce nombres a IP)

\- Apache: servidor web

\- vsftpd:servidor FTP

\- FileZilla o WinSCP:cliente para conectarse por FTP





Instrucciones de uso



* Requisitos



\- Git:

\- VirtualBox:

\- Vagrant:



* Pasos básicos



1\. Clonar el repositorio: `git clone https://github.com/pmolcal/ftp-vagrant-ansible.git`

2\. Crear las máquinas virtuales: `vagrant up`

3\. Comprobar que están creadas: `vagrant status`

4\. Entrar en la máquina de Ansible: `vagrant ssh ansible`

5\. Configurar los servidores desde ahí: `ansible-playbook -i inventory.yml dns/dns.yml`, y lo mismo con `web/web.yml` y `ftp/ftp.yml`

