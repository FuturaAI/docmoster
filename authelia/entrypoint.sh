#!/bin/sh
set -e

# Sostituisci la variabile d'ambiente con l'hash reale nel file di configurazione
sed -i "s|\${ADMIN_PW}|$ADMIN_PW|g" /config/users_database.yml

# Esegui Authelia con i parametri originali
exec /app/authelia $@