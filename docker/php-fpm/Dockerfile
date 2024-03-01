ARG PHP_VERSION=8.2

FROM php:$PHP_VERSION-fpm

# Packages
RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update && apt-get install -yq --no-install-recommends \
    dialog \
    apt-utils \
    wget \
    curl \
    acl \
    libonig-dev \
    \
    libpq-dev \
    libsqlite3-dev \
    libicu-dev \
    libxslt-dev \
    libzip-dev \
    libbz2-dev \
    libxml2-dev

# Extentions
RUN docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd && \
    docker-php-ext-install -j$(nproc) \
    iconv \
    exif \
    bcmath \
    opcache \
    sockets \
    mbstring \
    \
    pdo_mysql \
    pdo_pgsql \
    pdo_sqlite \
    intl \
    xsl \
    zip \
    bz2 \
    xml \
    soap

ARG XDEBUG_VERSION=3.3.1
RUN \
    # Install Xdebug
    pecl install xdebug-$XDEBUG_VERSION && \
    docker-php-ext-enable xdebug && \
    \
    # Install Composer
    COMPOSER_ALLOW_SUPERUSER=1 && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer -q && \
    \
    # Install NodeJS с NPM
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    \
    # Install Yarn
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y yarn && \
    \
    # Install Symfony CLI
    curl -sS https://get.symfony.com/cli/installer | bash && \
    mv /root/.symfony5/bin/symfony /usr/local/bin/symfony && \
    echo 'alias c="php bin/console"' >> /root/.bashrc

# Install Git
ARG GIT_EMAIL=symfony@example.com
ARG GIT_USER=symfony
RUN apt-get update && apt-get install -y git && \
    git config --global user.email "$GIT_EMAIL" && \
    git config --global user.name "$GIT_USER"

# Install Midnight Commander (tmp)
RUN apt-get update && apt-get -y install mc

# Clean
RUN apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Config PHP
#RUN cp $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini
COPY ./conf.d $PHP_INI_DIR/conf.d

WORKDIR /app
