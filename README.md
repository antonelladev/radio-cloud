Radio Cloud - Infrastructure Automation

Este repositorio contiene el script de automatización para levantar un servidor de radio online dockerizado y un servidor web Nginx con 3 páginas de prueba independientes en un VPS Linux Ubuntu 24.04 LTS.

Instrucciones en Español

Despliegue
Para replicar este proyecto en un servidor limpio, conéctate por SSH como usuario root y ejecuta el siguiente comando:

curl -sSL https://raw.githubusercontent.com/antonelladev/radio-cloud/main/instalar_radio.sh | bash

Credenciales FTP
Servidor (Host): La dirección IP pública de tu propio servidor.
Usuario: usuarioftp
Contraseña: ATENCION: La contraseña se genera de forma aleatoria y única para cada servidor por motivos de seguridad. Al finalizar la instalación, la verás impresa en las últimas líneas de la consola negra. Cópiala de inmediato.

Verificación de Servicios
Sitios Web: http://TU_IP/sitio1, http://TU_IP/sitio2, http://TU_IP/sitio3
Streaming de Radio (VLC/Web): http://TU_IP/live

English Instructions

Deployment
To replicate this project on a clean server, connect via SSH as root and run the following command:

curl -sSL https://raw.githubusercontent.com/antonelladev/radio-cloud/main/instalar_radio.sh | bash

FTP Credentials
Server (Host): Your server's public IP address.
Username: usuarioftp
Password: WARNING: The password is generated randomly and uniquely for each server for security reasons. Once the installation finishes, it will be printed in the last lines of your terminal. Copy it immediately.

Verification
Websites: http://YOUR_IP/sitio1, http://YOUR_IP/sitio2, http://YOUR_IP/sitio3
Streaming: http://YOUR_IP/live
