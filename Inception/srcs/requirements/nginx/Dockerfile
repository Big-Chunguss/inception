FROM debian:bookworm

RUN apt update && apt upgrade -y && \
    apt install -y nginx nano curl openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=agaroux.42.fr/UID=agaroux"

RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default /etc/nginx/sites-available/default

RUN rm -f /etc/nginx/sites-enabled/default && \
    ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

RUN chmod 755 /var/www/html

RUN chown -R www-data:www-data /var/www/html

# RUN nginx -t

CMD ["nginx", "-g", "daemon off;"]