# FTP con Vagrant y Ansible

Autor: Pablo Molina Calvente

Repositorio: https://github.com/pmolcal/ftp-vagrant-ansible

## Objetivo

Se van a construir tres maquinas virtuales con Debian, creadas con Vagrant: un servidor DNS, un servidor web con apache y FTP seguro, y una maquina que usa Ansible para configurar las otras dos.

El objetivo es practicar como montar un servidor FTP seguro con usuarios y permisos distintos y conexión cifrada, todo instalado de forma automática.

## Herramientas

- GitHub: web donde se guarda el proyecto y las tareas
- Git: programa que guarda las versiones del proyecto
- Vagrant: crea las máquinas virtuales
- VirtualBox: programa que hace funcionar las máquinas virtuales
- Ansible: configura los servidores automáticamente
- BIND9: servidor DNS (traduce nombres a IP)
- Apache: servidor web
- vsftpd: servidor FTP
- FileZilla o WinSCP: cliente para conectarse por FTP

## Instrucciones de uso

### Requisitos

- Git
- VirtualBox
- Vagrant

### Pasos básicos

1. Clonar el repositorio: `git clone https://github.com/pmolcal/ftp-vagrant-ansible.git`
2. Entrar en la carpeta: `cd ftp-vagrant-ansible`
3. Crear las máquinas virtuales: `vagrant up`. Al crear la máquina `ansible` se configuran solos el DNS, la web y el FTP.
4. Comprobar que están creadas: `vagrant status`
5. Poner `192.168.57.5` como servidor DNS del ordenador para poder usar los nombres `www.pablo.test` y `ftp.pablo.test`.
6. Abrir la web en `http://www.pablo.test` y conectarse por FTP a `ftp.pablo.test` (FTP explícito sobre TLS) con los usuarios `ana` o `juan`.

Si se cambia algún fichero, se vuelve a aplicar todo con `vagrant provision ansible`.

## Documentación

El proceso completo, paso a paso y con capturas, está en [doc/README.md](doc/README.md).
