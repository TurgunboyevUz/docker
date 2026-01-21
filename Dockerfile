FROM php:8.4-fpm-alpine

# Ishchi katalogni belgilash
WORKDIR /var/www

# Tizim paketlarini o'rnatish
RUN apk add --no-cache \
    curl \
    libpng-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    icu-dev \
    oniguruma-dev

# PHP kengaytmalarini o'rnatish
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd intl

# Composer-ni o'rnatish
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN composer install

# Foydalanuvchi huquqlarini sozlash
RUN addgroup -g 1000 www && adduser -u 1000 -G www -s /bin/sh -D www
USER www

EXPOSE 9000
CMD ["php-fpm"]