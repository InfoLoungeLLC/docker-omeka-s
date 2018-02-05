FROM php:7.1-apache
WORKDIR /var/www/html

# Omeka S Version
ENV OMEKA_S_VERSION v1.0.1

ENV DEBIAN_FRONTEND noninteractive

# install packages
RUN apt-get -qq update
RUN apt-get -qq -y --no-install-recommends install \
    libxml2-dev \
    git \
    gnupg \
    zlibc

# install node.js and npm
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
  && apt-get -qq -y --no-install-recommends install \
    nodejs

# install php modules
RUN docker-php-ext-install -j$(nproc) pdo pdo_mysql xml

# prepare omeka-s
RUN mkdir -p /tmp/omeka-s \
  && cd /tmp/omeka-s \
  && git clone https://github.com/omeka/omeka-s.git . \
  && git checkout $OMEKA_S_VERSION \
  && npm install \
  && npm install --global gulp-cli \
  && gulp init

# enable mod_rewrite (AllowOverride is already set to All on php:7.1-apache)
RUN a2enmod rewrite

# add entrypoint
COPY omeka-setup.sh /usr/local/bin
RUN chmod +x /usr/local/bin/omeka-setup.sh

ENTRYPOINT ["omeka-setup.sh"]
CMD ["apache2-foreground"]
