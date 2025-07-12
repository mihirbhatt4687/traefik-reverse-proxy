FROM ubuntu:22.04

RUN apt-get update -y

#Installing apache in non-interactive mode
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get install apache2 -y

RUN a2enmod rewrite

ARG PHP_VERSION=8.3

ARG TERM=linux

# RUN apt-get update -y && apt install nodejs -y && \
#     apt install npm -y

# RUN npm -v

# Install Node.js and npm via NodeSource
RUN apt-get update && \
    apt-get install -y curl gnupg2 ca-certificates build-essential && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    # Clean up
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Verify versions
RUN node -v && npm -v

#Installing PHP
RUN apt-get update -y && apt-get -y install software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update -y && \
    apt-get -y install php$PHP_VERSION

#Install required PHP extensions
RUN apt-get install -y php$PHP_VERSION-bcmath php$PHP_VERSION-fpm php$PHP_VERSION-xml php$PHP_VERSION-mysql php$PHP_VERSION-zip php$PHP_VERSION-intl php$PHP_VERSION-ldap php$PHP_VERSION-gd php$PHP_VERSION-cli php$PHP_VERSION-bz2 php$PHP_VERSION-curl php$PHP_VERSION-mbstring php$PHP_VERSION-pgsql php$PHP_VERSION-opcache php$PHP_VERSION-soap php$PHP_VERSION-cgi

RUN apt install curl -y

WORKDIR /

RUN /bin/bash -c "$(curl -fsSL https://php.new/install/linux/8.4)"

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]