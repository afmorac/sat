#!/usr/bin/env bash

# Verificación del shell
if [ "$SHELL" != "/bin/bash" ] && [ "$SHELL" != "/bin/zsh" ]; then
    echo "Este script está optimizado para Bash y Zsh. Cambie su shell si es necesario."
    exit 1
fi

# Verificar si el script está siendo ejecutado con permisos de superusuario (sudo)
if [ "$(id -u)" -ne 0 ]; then
    echo "Este script debe ejecutarse con permisos de superusuario. Use 'sudo'."
    exit 1
fi

# Descargar el archivo ejecutable 's' desde el repositorio de GitHub
echo "Descargando el archivo ejecutable 's'..."
curl -sSL https://raw.githubusercontent.com/afmorac/holbertonschool-low_level_programming/master/sat/s -o /tmp/s

# Verificar si la descarga fue exitosa
if [ ! -f /tmp/s ]; then
    echo "Error: No se pudo descargar el archivo 's'."
    exit 1
fi

# Mover el archivo descargado a /usr/local/bin para que sea accesible globalmente
echo "Moviendo el archivo 's' a /usr/local/bin..."
sudo mv /tmp/s /usr/local/bin/s

# Darle permisos de ejecución
sudo chmod +x /usr/local/bin/s

# Confirmación de instalación
echo "Shell Automation Tool (SAT) instalado correctamente. Ahora puede usarlo globalmente con el comando 's'."

