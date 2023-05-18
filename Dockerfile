# Use the official PHP-FPM 8.2 base image
FROM php:8.2-fpm

# Set working directory
WORKDIR /var/www/

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy the project files to the working directory
RUN usermod -u 1000 www-data

COPY ./src .
# # Install Laravel dependencies
# RUN composer install --no-dev
RUN chown -R www-data:www-data .
# Set permissions
# RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# # Generate the Laravel application key
# RUN php artisan key:generate
# Expose port 9000 (PHP-FPM)
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]

# ENTRYPOINT [ "sh" ,"/var/www/app.sh" ]
