# Use the official PHP image with FPM
FROM php:8.0-fpm

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    curl \
    vim  \
    supervisor \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd sockets \
    && apt-get install --reinstall -y python3-pkg-resources
# Install PHP-FPM configuration files if missing
RUN if [ ! -f /usr/local/etc/php-fpm.d/www.conf ]; then \
    mkdir -p /usr/local/etc/php-fpm.d/; \
    cp /usr/local/etc/php-fpm.conf.default /usr/local/etc/php-fpm.conf; \
    cp /usr/local/etc/php-fpm.d/www.conf.default /usr/local/etc/php-fpm.d/www.conf; \
    fi

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy existing application directory contents
COPY . /var/www

# Copy existing application directory permissions
RUN chown -R www-data:www-data /var/www

# Change PHP-FPM listening port to 9001
RUN sed -i 's/listen = 9000/listen = 9001/' /usr/local/etc/php-fpm.d/www.conf

# Add Supervisor configuration file
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Create necessary directories for Supervisor
RUN mkdir -p /var/run /var/log/supervisor /var/log/php-fpm

# Expose necessary ports and start Supervisor
EXPOSE 9001
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Expose port 9001 and start Supervisor
EXPOSE 9001
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

