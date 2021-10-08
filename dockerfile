FROM node:12 as gulp
WORKDIR /app
COPY . .
ENV NODE_ENV=production
RUN yarn && yarn add gulp && yarn global add gulp-cli 
RUN gulp build:release

FROM composer as composer

WORKDIR /app 
COPY --from=gulp /app /app


# Run composer install to install the dependencies
RUN composer install \
  --optimize-autoloader \
  --no-interaction \
  --no-progress

FROM trafex/php-nginx

COPY --chown=nginx --from=composer /app/lib /var/www/html/lib
COPY --chown=nginx --from=composer /app/public /var/www/html/public
COPY --chown=nginx --from=composer /app/vendor /var/www/html/vendor
COPY --chown=nginx --from=composer /app/init.php /var/www/html/init.php
USER root
RUN chmod -R 777 /var/log
# RUN apt-get install php-opcache php-fpm -y
# RUN rm -rf src .editorconfig .env .gitignore docker* gulp* package* webpack* yarn*
# RUN echo "opcache.enable=1 \
#   opcache.memory_consumption=128\
#   opcache.max_accelerated_files=3000\
#   opcache.revalidate_freq=200" >> /etc/php/7.4/fpm/php.ini

USER nobody