FROM php:7.4-alpine

RUN apk add --no-cache --virtual .build-deps \
  $PHPIZE_DEPS \
  curl-dev \
  imagemagick-dev \
  libtool \
  libxml2-dev \
  postgresql-dev \
  sqlite-dev

RUN apk add --no-cache \
    bash \
    curl \
    freetype-dev \
    g++ \
    gcc \
    git \
    imagemagick \
    libc-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libzip-dev \
    make \
    mysql-client \
    oniguruma-dev \
    openssh-client \
    postgresql-libs \
    rsync \
    zlib-dev \
    libgcc \
    libstdc++ \
    libx11 \
    glib \
    libxrender \
    libxext \
    libintl \
    ttf-dejavu \
    ttf-droid \
    ttf-freefont \
    ttf-liberation \
    ttf-ubuntu-font-family \
    wkhtmltopdf

RUN pecl install \
    imagick \
    xdebug

RUN docker-php-ext-enable \
    imagick \
    xdebug

RUN docker-php-ext-configure gd --with-freetype --with-jpeg

RUN docker-php-ext-install \
    bcmath \
    calendar \
    curl \
    exif \
    gd \
    iconv \
    mbstring \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pdo_sqlite \
    pcntl \
    tokenizer \
    xml \
    zip

ENV COMPOSER_HOME /composer
ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

RUN composer global require "squizlabs/php_codesniffer=*"

RUN apk del -f .build-deps

WORKDIR /var/www