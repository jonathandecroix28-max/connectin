#!/bin/sh

cd /app

# Installer les dépendances si vendor n'existe pas
if [ ! -d "vendor" ]; then
    echo "Installation des dépendances PHP..."
    composer install
fi

# Gérer le fichier .env
if [ ! -f .env ]; then
    echo "Création du fichier .env..."
    cp .env.example .env
fi

if [ ! -f config/cors.php ]; then
    echo "Publication de la configuration CORS..."
    php artisan config:publish cors
fi

# Sécurité : Générer la clé seulement si elle n'est pas fournie par l'environnement
if [ -z "$APP_KEY" ]; then
    php artisan key:generate --no-interaction --force
else
    echo "APP_KEY déjà fournie, conservation de la clé existante."
fi

# Nettoyage des caches (vital pour Docker)
echo "Nettoyage des caches Laravel..."
php artisan config:clear
php artisan cache:clear

# La base de données est externe (TiDB Cloud) ; on ne bloque pas le démarrage sur un wait loop.
# L'application utilisera directement la configuration MySQL avec SSL.

echo "Lancement des migrations..."
php artisan config:cache
php artisan migrate --force --database="${DB_CONNECTION:-mysql}"
php artisan storage:link

PORT_NUMBER="${PORT:-10000}"
echo "Lancement de Laravel sur le port ${PORT_NUMBER}..."
php artisan serve --host=0.0.0.0 --port="${PORT_NUMBER}"