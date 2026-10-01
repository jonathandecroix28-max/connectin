FROM php:8.4-cliy

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN apt-get update && apt-get install -y git unzip default-mysql-client curl \
 && install-php-extensions pdo_mysql mbstring zip gd intl bcmath exif opcache \
 && rm -rf /var/lib/apt/lists/*

# Installer Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /app

# Copier les fichiers de dépendances
COPY composer.json composer.lock* ./

# Copier tout le code de l'application
COPY . .

# Réutiliser vendor/ si le dépôt l'embarque déjà, sinon installer les dépendances
RUN if [ ! -d vendor ]; then composer install --no-scripts --no-autoloader --no-interaction --prefer-dist; fi

# Finir l'installation Composer (générer l'autoloader et exécuter les scripts)
RUN composer dump-autoload --optimize && composer run-script post-autoload-dump --no-interaction || true

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
