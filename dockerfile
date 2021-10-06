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

COPY --chown=nginx --from=composer /app /var/www/html
USER root
RUN chmod -R 777 /var/log
# RUN rm -rf src .editorconfig .env .gitignore docker* gulp* package* webpack* yarn*

USER nobody