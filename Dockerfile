FROM php:8.2-apache

WORKDIR /var/www/html

# Mod Rewrite
RUN a2enmod rewrite

# Linux Library and PHP Extentions required for Laravel
RUN apt-get update && apt-get install -y \
		git curl freetype-dev libjpeg-turbo-dev libpng-dev libxml2-dev zip unzip nodejs npm libzip-dev zip oniguruma-dev icu-dev \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-configure intl \
	&& docker-php-ext-install -j$(nproc) pdo pdo_mysql intl mbstring exif pcntl bcmath gd zip	mysqli

RUN docker-php-ext-configure intl
# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer