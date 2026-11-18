#!/usr/bin/env bash
#
# Pruebas de los registros DNS de pablo.test
# Se ejecuta en una maquina que llegue al servidor DNS

SERVIDOR=192.168.57.5
FALLOS=0

# probar NOMBRE TIPO RESPUESTA_ESPERADA
probar() {
    RESPUESTA=$(dig +short @$SERVIDOR "$1" "$2")
    if echo "$RESPUESTA" | grep -q "$3"; then
        echo "OK     $1 ($2) -> $3"
    else
        echo "FALLO  $1 ($2): se esperaba $3 y salio: $RESPUESTA"
        FALLOS=$((FALLOS + 1))
    fi
}

# probar_inversa IP NOMBRE_ESPERADO
probar_inversa() {
    RESPUESTA=$(dig +short @$SERVIDOR -x "$1")
    if echo "$RESPUESTA" | grep -q "$2"; then
        echo "OK     $1 (PTR) -> $2"
    else
        echo "FALLO  $1 (PTR): se esperaba $2 y salio: $RESPUESTA"
        FALLOS=$((FALLOS + 1))
    fi
}

echo "== Zona directa =="
probar dns.pablo.test A 192.168.57.5
probar negocio.pablo.test A 192.168.57.7
probar www.pablo.test CNAME negocio.pablo.test.
probar ftp.pablo.test CNAME negocio.pablo.test.

echo "== Zona inversa =="
probar_inversa 192.168.57.5 dns.pablo.test.
probar_inversa 192.168.57.7 negocio.pablo.test.

if [ "$FALLOS" -eq 0 ]; then
    echo "Todas las pruebas han ido bien"
    exit 0
else
    echo "Hay $FALLOS pruebas que han fallado"
    exit 1
fi