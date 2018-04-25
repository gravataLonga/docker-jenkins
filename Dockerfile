FROM jenkins/jenkins:lts

# We want install some stuff, we must swap to root user.
USER root
RUN apt-get update && apt-get install -y php7.2 php7.2-fpm php7.2-xml php7.2-gd php7.2-json php7.2-mbstring php7.2-soap php7.2-zip php7.2-opcache php7.2-mcrypt php7.2-curl php7.2-pgsql php7.2-mysql php7.2-intl php-xdebug php-redis php7.2-intl
RUN chmod +x install-composer.sh && ./install-composer.sh

# Swap again to this user.
USER jenkins

# Install Plugins
RUN /usr/local/bin/install-plugins.sh docker-slaves blueocean