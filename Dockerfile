FROM jenkins/jenkins:lts

# We want install some stuff, we must swap to root user.
USER root

# Install the latest PHP version.
RUN apt-get update
RUN apt-get install -y apt-transport-https 
RUN apt-get install -y lsb-release
RUN apt-get install -y ca-certificates
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt-get update && apt-get install -y php7.2 php7.2-cli php7.2-fpm php7.2-xml php7.2-gd php7.2-json php7.2-mbstring php7.2-soap php7.2-zip php7.2-opcache php7.2-curl php7.2-pgsql php7.2-mysql php7.2-intl php-xdebug php-redis php7.2-intl php7.2-sqlite3

# Swap again to this user.
# USER jenkins

WORKDIR /
ADD .
RUN chmod +x install-composer.sh && ./install-composer.sh
RUN mv composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

# Install Plugins
RUN /usr/local/bin/install-plugins.sh docker-slaves blueocean