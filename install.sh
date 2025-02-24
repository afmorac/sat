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

# Descargar el archivo ejecutable 's' y moverlo a /usr/local/bin para que sea accesible globalmente
echo "Descargando y moviendo el archivo ejecutable 's' a /usr/local/bin..."
curl -sSL https://raw.githubusercontent.com/afmorac/holbertonschool-low_level_programming/sat/s -o /usr/local/bin/s

# Darle permisos de ejecución
chmod +x /usr/local/bin/s

# Confirmación de instalación
echo "Shell Automation Tool (SAT) instalado correctamente. Ahora puede usarlo globalmente con el comando 's'."

