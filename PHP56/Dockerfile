# Use the official PHP 5.6 Apache image
FROM php:5.6-apache

# Enable Apache modules
RUN a2enmod rewrite

# Update debian stretch repo
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list

# Install MySQL and PostgreSQL client libraries and PHP extensions
RUN apt-get update \
    && apt-get install -y \
        libpq-dev \
        default-libmysqlclient-dev \
    && docker-php-ext-install pdo_mysql pdo_pgsql mysqli

# Copy the Apache configuration file with changes
COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

# Set the working directory to /var/www/html
WORKDIR /var/www/html

# Copy the contents of the host directory into the container
COPY . /var/www/html
