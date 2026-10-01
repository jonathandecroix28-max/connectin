FROM php:8.3-cli

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    default-mysql-client \
    libonig-dev \
    libzip-dev \
    curl \
 && docker-php-ext-install pdo pdo_mysql mbstring zip

# Installer Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /app

# Copier les fichiers de dépendances
COPY composer.json composer.lock* ./

# Installer les dépendances PHP (sans scripts ni autoloader)
RUN composer install --no-scripts --no-autoloader --no-interaction --prefer-dist

# Copier tout le code de l'application
COPY . .

# Finir l'installation Composer (générer l'autoloader et exécuter les scripts)
RUN composer dump-autoload --optimize && composer run-script post-autoload-dump --no-interaction || true

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
