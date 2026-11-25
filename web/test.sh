#!/usr/bin/env bash
#
# Prueba con curl de la pagina web de pablo.test

URL=http://www.pablo.test
TEXTO="Servidor web de pablo.test"

# -s no muestra el progreso; -o /dev/null descarta el contenido;
# -w "%{http_code}" escribe solo el codigo de respuesta (200 = correcto)
CODIGO=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
CONTENIDO=$(curl -s "$URL")

if [ "$CODIGO" = "200" ] && echo "$CONTENIDO" | grep -q "$TEXTO"; then
    echo "OK: $URL responde 200 y contiene: $TEXTO"
    exit 0
else
    echo "FALLO: codigo $CODIGO en $URL"
    exit 1
fi