# FTP con Vagrant y Ansible

Autor: Pablo Molina Calvente

Repositorio: https://github.com/pmolcal/ftp-vagrant-ansible

En esta práctica creo tres máquinas virtuales y las configuro de forma automática con Ansible:

- dns (192.168.57.5): traduce los nombres de la práctica, como `www.pablo.test` o `ftp.pablo.test`.
- ansible (192.168.57.6): desde aquí configuro las otras dos.
- negocio (192.168.57.7): tiene la página web y el servidor FTP.

---

## 1. Herramientas

Compruebo que tengo instalados Git, Vagrant y VirtualBox.

![Herramientas instaladas](img/captura01_herramientas.png)

---

## 2. GitHub y tablero de tareas

Creo el repositorio en GitHub.

![Repositorio creado](img/captura02_repositorio.png)

Añado al profesor como colaborador.

![Profesor añadido](img/captura03_colaborador.png)

Creo el tablero del proyecto.

![Tablero recién creado](img/FTP%20con%20Vagrant%20y%20Ansible.png)

Pongo las columnas en español (Por hacer, En progreso y Hecho) y creo la primera tarea.

![Columnas y primera tarea](img/Licencia.png)

Creo todas las tareas de la práctica, 40 en total.

![Las 40 tareas](img/captura04_tablero.png)

Cada tarea la muevo a "En progreso" cuando la empiezo, y cuando la termino se cierra sola con el commit.

---

## 3. Licencia y README

Añado la licencia MIT, que deja usar y modificar el proyecto citando al autor.

![Licencia terminada](img/captura05_licencia.png)

Escribo el README principal con el objetivo, las herramientas y cómo arrancar el proyecto.

![README terminado](img/captura06_readme.png)

---

## 4. Las máquinas virtuales

Con el Vagrantfile creo las tres máquinas y compruebo que están encendidas.

![Las tres máquinas encendidas](img/captura07_vagrant_status.png)

---

## 5. Ansible

Configuro Ansible para que sepa qué máquinas tiene que gestionar y compruebo que puede conectarse a ellas.

![Ansible conecta con las dos máquinas](img/captura08_ansible_ping.png)

---

## 6. Servidor DNS

Instalo y configuro el servidor DNS con Ansible.

![Instalación del DNS](img/captura09_playbook_dns.png)

Compruebo que los nombres de la práctica se resuelven bien.

![Pruebas de nombres](img/captura10_dns_pruebas.png)

Creo un pequeño script que hace todas las pruebas de golpe.

![Script de pruebas DNS](img/captura11_test_dns.png)

Hago que mi ordenador use este DNS para poder entrar por nombre desde el navegador y desde FileZilla.

![Mi ordenador usando el DNS](img/captura12_dns_equipo.png)

---

## 7. Servidor web

Instalo Apache con Ansible. La primera vez falla por una instalación que se había quedado a medias; la reparo y a la segunda funciona.

![Instalación de Apache](img/captura13_playbook_web.png)

La página se ve en `http://www.pablo.test`.

![Página web](img/captura14_web_navegador.png)

Hago también una prueba automática que comprueba que la página responde.

![Prueba de la web](img/captura15_curl_web.png)

---

## 8. Servidor FTP

Los requisitos del FTP son:

- Sin acceso anónimo: solo entran usuarios con su contraseña.
- Dos usuarios: juan y ana.
- juan solo puede ver su carpeta.
- ana puede subir la página web.
- La conexión va cifrada.

### Contraseñas

Genero las contraseñas de juan y ana en el formato que necesita Ansible.

![Contraseñas generadas](img/captura16_hashes_mkpasswd.png)

Las guardo en un fichero protegido con contraseña para que no se puedan leer en GitHub. En este primer intento se me olvida poner las contraseñas de verdad, y luego me da problemas (lo cuento en el apartado 11).

![Creando el fichero protegido](img/captura17_vault_view.png)

Así se ve el fichero ya protegido: no se puede leer nada.

![Fichero protegido](img/captura18_vault_cifrado.png)

### Configuración del servidor

Relleno la configuración del FTP: sin anónimos, solo usuarios del sistema, juan encerrado en su carpeta, ana entrando directamente en la carpeta de la web y conexión cifrada.

![Configuración del FTP](img/captura19_vsftpd_conf.png)

### Instalación

Copio los ficheros del FTP a la máquina ansible.

![Copia de los ficheros](img/captura20_provision_ftp.png)

Compruebo que el fichero de instalación no tiene errores.

![Comprobación sin errores](img/captura21_ftp_syntax_check.png)

Lanzo la instalación del FTP y termina sin fallos.

![Instalación del FTP](img/captura22_playbook_ftp.png)

### Comprobaciones

El servidor FTP está funcionando y solo escucha por IPv4.

![FTP funcionando](img/captura23_puertos_ipv4.png)

juan y ana están creados, y ana tiene permiso para cambiar la web.

![Usuarios y permisos](img/captura24_usuarios_permisos.png)

El servidor tiene su certificado para cifrar la conexión.

![Certificado](img/captura25_certificado.png)

Si intento entrar sin usuario, el servidor no me deja.

![Anónimo rechazado](img/captura26_anonimo_rechazado.png)

Con un usuario que no existe, tampoco.

![Usuario falso rechazado](img/captura27_usuario_rechazado.png)

---

## 9. Pruebas con FileZilla

### ana

Creo la conexión de ana en FileZilla usando el nombre `ftp.pablo.test`, no la IP, y con conexión cifrada.

![Conexión de ana](img/captura28_filezilla_sitio_ana.png)

FileZilla pregunta si quiero guardar las contraseñas.

![Guardar contraseñas](img/captura29.png)

ana entra y aparece directamente en la carpeta de la web (`/var/www/html`).

![ana en la carpeta de la web](img/captura30_ana_conectada_var_www_html.png)

Subo una página modificada y la subida sale bien.

![Subida correcta](img/captura31_ana_subida.png)

Al abrir `http://www.pablo.test` ya se ve la página nueva.

![Web modificada](img/captura32_web_modificada.png)

### juan

Creo la conexión de juan.

![Conexión de juan](img/captura33_filezilla_sitio_juan.png)

juan entra y solo ve su propia carpeta.

![juan en su carpeta](img/captura34_juan_enjaulado.png)

Si intenta ir a la carpeta de la web, el servidor no le deja.

![juan no puede salir](img/captura35_juan_no_sale.png)

En su carpeta sí puede subir ficheros.

![juan sube un fichero](img/captura36_juan_subida_home.png)

---

## 10. Final

Dejo el proyecto preparado para que las tres instalaciones (DNS, web y FTP) se hagan solas de una vez.

![Instalación completa](img/captura37_provision_completa.png)

Todas las tareas del tablero quedan en "Hecho".

![Tablero terminado](img/captura38_tablero_final.png)

---

## 11. Problemas que me encuentro

- Los usuarios no pueden entrar por FTP. El servidor dice que la contraseña es incorrecta. El fallo está en las contraseñas que guardo: la primera vez se me olvida ponerlas y la segunda se cuela algún carácter. Las genero de nuevo con cuidado y ya funciona.
- Mi ordenador no encuentra `www.pablo.test`. Lo configuro para que los nombres de la práctica los pregunte al DNS de la práctica.
- Me quedo sin espacio en el disco y las máquinas se pausan. Borro máquinas viejas de otras prácticas.
- Las máquinas se quedan con la hora atrasada o sin internet después de una pausa. Reiniciándolas se arregla.
- El Bloc de notas a veces no guarda bien los ficheros o les añade `.txt`. Me acostumbro a comprobarlos siempre.

---

## 12. Conclusión

Con esta práctica aprendo a montar un DNS, una web y un FTP seguro sin configurar nada a mano en los servidores: todo lo hace Ansible. También aprendo a comprobar que cada cosa funciona y a buscar la causa de los errores.

La última prueba del enunciado es borrar todo y volver a crearlo desde el repositorio. La intento, pero la máquina negocio se queda bloqueada a mitad y no consigo terminarla.
