FROM jenkins/jenkins:lts

# We want install some stuff, we must swap to root user.
USER root
RUN apt-get update && apt-get install -y php7.1 php7.1-fpm php7.1-xml php7.1-gd php7.1-json php7.1-mbstring php7.1-soap php7.1-zip php7.1-opcache php7.1-mcrypt php7.1-curl php7.1-pgsql php7.1-mysql php7.1-intl php-xdebug php-redis php7.1-intl
RUN chmod +x install-composer.sh && ./install-composer.sh

# Swap again to this user.
USER jenkins

# Install Plugins
RUN /usr/local/bin/install-plugins.sh docker-slaves blueocean