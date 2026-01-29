FROM debian:bookworm

RUN apt update -y && apt upgrade -y
RUN apt install -y wget
RUN apt install -y php php-fpm php-mysql mariadb-client

RUN wget -P /var/www https://fr.wordpress.org/wordpress-6.9-fr_FR.tar.gz
RUN cd /var/www && tar -xzf wordpress-6.9-fr_FR.tar.gz && rm wordpress-6.9-fr_FR.tar.gz

RUN chown -R www-data:www-data /var/www/wordpress

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY conf/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod +x /usr/local/bin/auto_config.sh

WORKDIR /var/www/wordpress

EXPOSE 9000

ENTRYPOINT [ "/usr/local/bin/auto_config.sh" ]
