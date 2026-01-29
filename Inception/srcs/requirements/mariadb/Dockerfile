FROM debian:bookworm

RUN apt update -y && apt upgrade -y

RUN apt install mariadb-server gettext-base -y

COPY conf/50-server.conf /etc/mysql/mariadb.conf.d/50-server.conf

# Ensure bind-address is set correctly
RUN sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf || true

COPY tools/entrypoint.sh /tools/entrypoint.sh
COPY tools/init.sql /tools/init.sql

RUN chmod +x /tools/entrypoint.sh

ENTRYPOINT [ "/tools/entrypoint.sh" ]