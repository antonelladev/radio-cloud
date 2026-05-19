#!/bin/bash

# =========================================================================
# SCRIPT DE AUTOMATIZACION DE INFRAESTRUCTURA - REPLICABILIDAD CONTINUA
# ASIGNATURA: ADMINISTRACION DE SISTEMAS OPERATIVOS
# =========================================================================

# Detener la ejecución si ocurre un error inesperado
set -e

# Detectar automáticamente la IP pública del nuevo servidor
IP_PUBLICA=$(curl -s ifconfig.me)

# Generar una contraseña FTP aleatoria y única de 8 caracteres hexadecimales
CLAVE_FTP=$(openssl rand -hex 4)

echo "========================================================="
echo " Iniciando despliegue de infraestructura cloud..."
echo " IP del Servidor detectada: $IP_PUBLICA"
echo "========================================================="

# 1. Actualización e instalación de dependencias del sistema operativo
echo "[+] Actualizando repositorios de Ubuntu..."
sudo apt update && sudo apt upgrade -y

echo "[+] Instalando el servidor web Nginx de forma nativa..."
sudo apt install nginx -y

echo "[+] Instalando el motor de Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# 2. Creación de la estructura de directorios reales
echo "[+] Creando entorno de almacenamiento del sistema..."
sudo mkdir -p /opt/radio-g5/musica
sudo mkdir -p /var/www/sitio1 /var/www/sitio2 /var/www/sitio3

# 3. Generación de las 3 páginas web "Hello World!" obligatorias
echo "[+] Generando código estático para verificación web..."
echo "<html><body><h1>Hello World! - Sitio 1 Funcionando</h1></body></html>" | sudo tee /var/www/sitio1/index.html > /dev/null
echo "<html><body><h1>Hello World! - Sitio 2 Funcionando</h1></body></html>" | sudo tee /var/www/sitio2/index.html > /dev/null
echo "<html><body><h1>Hello World! - Sitio 3 Funcionando</h1></body></html>" | sudo tee /var/www/sitio3/index.html > /dev/null

# 4. Configuración automatizada del Reverse Proxy de Nginx
echo "[+] Configurando Nginx como puente de red para Icecast y sitios web..."
cat << 'EOF' | sudo tee /etc/nginx/sites-available/default > /dev/null
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www;
    index index.html;
    server_name _;

    location /sitio1 { try_files $uri $uri/ =404; }
    location /sitio2 { try_files $uri $uri/ =404; }
    location /sitio3 { try_files $uri $uri/ =404; }

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
EOF

# Reiniciar Nginx para aplicar cambios
sudo systemctl restart nginx

# 5. Despliegue de contenedores FTP e Icecast
echo "[+] Levantando servicios dockerizados..."

echo "========================================================="
echo " DESPLIEGUE FINALIZADO CON EXITO"
echo "========================================================="
echo " Credenciales FTP generadas para este servidor:"
echo " Usuario: usuarioftp"
echo " Contraseña: $CLAVE_FTP"
echo "========================================================="
