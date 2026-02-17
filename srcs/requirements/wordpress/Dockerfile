FROM debian:bookworm

RUN apt update -y && apt upgrade -y
RUN apt install php-fpm php-mysqli curl default-mysql-client -y

COPY /conf/www.conf /etc/php/8.2/fpm/pool.d/.
COPY /conf/script.sh .
RUN chmod +x script.sh

CMD ["./script.sh"]
