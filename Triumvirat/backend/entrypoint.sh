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

# Attendre la base si elle est définie
if [ -n "$DB_HOST" ]; then
    echo "Attente de la base de données sur $DB_HOST..."
    until php -r "new PDO('mysql:host=' . getenv('DB_HOST') . ';port=' . getenv('DB_PORT') . ';dbname=' . getenv('DB_DATABASE'), getenv('DB_USERNAME'), getenv('DB_PASSWORD'));" 2>/dev/null; do
        echo "Attente de la base de données..."
        sleep 2
    done
fi

# Exécution des migrations
echo "Lancement des migrations..."
# On ajoute config:cache pour forcer Laravel à lire le .env tout juste créé/modifié
php artisan config:cache
php artisan migrate --force --database="${DB_CONNECTION:-mysql}"
php artisan storage:link

# Lancement du serveur
echo "Lancement de Laravel sur le port 8000..."
php artisan serve --host=0.0.0.0 --port=8000