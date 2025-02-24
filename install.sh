#!/usr/bin/env bash

# Verificación del shell
if [[ "$SHELL" != "/bin/bash" && "$SHELL" != "/bin/zsh" ]]; then
    echo "Este script está optimizado para Bash y Zsh. Cambie su shell si es necesario."
    exit 1
fi

# Verificar si el script está siendo ejecutado con permisos de superusuario (sudo)
if [[ $(id -u) -ne 0 ]]; then
    echo "Este script debe ejecutarse con permisos de superusuario. Use 'sudo'."
    exit 1
fi

# Definir URL del ejecutable
EXECUTABLE_URL="https://raw.githubusercontent.com/afmorac/holbertonschool-low_level_programming/master/sat/s"
INSTALL_PATH="/usr/local/bin/s"

# Descargar el archivo ejecutable 's'
echo "Descargando el ejecutable..."
curl -sSL "$EXECUTABLE_URL" -o "$INSTALL_PATH"

# Verificar si la descarga fue exitosa
if [[ ! -f "$INSTALL_PATH" ]]; then
    echo "Error: No se pudo descargar el ejecutable. Verifique la URL y su conexión a internet."
    exit 1
fi

# Dar permisos de ejecución
chmod +x "$INSTALL_PATH"

# Confirmación de instalación
echo "Shell Automation Tool (SAT) instalado correctamente. Ahora puede usarlo globalmente con el comando 's'."

