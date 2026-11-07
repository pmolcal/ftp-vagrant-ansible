\# FTP con Vagrant y Ansible



\## Objetivo



Se van a construir tres maquinas virtuales con Debian, creadas con Vagrant: un servidor DNS, un servidor web con apache y FTP seguro, y una maquina que usa Ansible para configurar las otras dos.



El objetivo es practicar como montar un servidor FTP seguro con usuarios y permisos distintos y conexión cifrada , todo instalado de forma automática.



\## Herramientas



\- GitHub: web donde se guarda el proyecto y las tareas

\- Git: programa que guarda las versiones del proyecto

\- Vagrant:crea las máquinas virtuales

\- VirtualBox:programa que hace funcionar las máquinas virtuales

\- Ansible:configura los servidores automáticamente

\- BIND9:servidor DNS (traduce nombres a IP)

\- Apache: servidor web

\- vsftpd:servidor FTP

\- FileZilla o WinSCP:cliente para conectarse por FTP

