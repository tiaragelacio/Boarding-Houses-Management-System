# Use official PHP Apache image
FROM php:8.2-apache

# Install required PHP extensions (pdo, pdo_mysql, curl for Resend API)
RUN apt-get update \
    && apt-get install -y --no-install-recommends libcurl4-openssl-dev \
    && docker-php-ext-install pdo pdo_mysql curl \
    && rm -rf /var/lib/apt/lists/*

# Enable Apache rewrite module
RUN a2enmod rewrite

# Configure PHP settings for file uploads and timezone
RUN echo "upload_max_filesize = 15M\n\
post_max_size = 20M\n\
memory_limit = 128M\n\
date.timezone = Asia/Manila\n" > /usr/local/etc/php/conf.d/bms-custom.ini

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY . /var/www/html/

# Ensure uploads directories exist and have proper permissions
RUN mkdir -p /var/www/html/uploads/rooms /var/www/html/uploads/payment_proofs \
    && chown -R www-data:www-data /var/www/html/uploads \
    && chmod -R 775 /var/www/html/uploads

# Expose web port
EXPOSE 80

CMD ["apache2-foreground"]
