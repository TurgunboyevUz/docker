FROM php:8.4-fpm-alpine

# Ishchi katalog
WORKDIR /var/www

# Tizim paketlari va PHP kengaytmalari
RUN apk add --no-cache \
    curl \
    libpng-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    icu-dev \
    oniguruma-dev \
    linux-headers

# Laravel 12 uchun kerakli PHP kengaytmalari
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd intl

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Git xavfsizlik sozlamasi (Sizdagi xatolikni oldini olish uchun)
RUN git config --global --add safe.directory /var/www

# Foydalanuvchi yaratish (Ruxsatlar muammosini kamaytirish uchun)
RUN addgroup -g 1000 www && adduser -u 1000 -G www -s /bin/sh -D www

# Huquqlarni sozlash
RUN chown -R www:www /var/www

USER www

EXPOSE 9000
CMD ["php-fpm"]