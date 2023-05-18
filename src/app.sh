#!/bin/bash
composer install --no-dev
chown -R www-data:www-data .
chmod -R 755 .
php artisan key:generate