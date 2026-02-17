FROM debian:bookworm

RUN apt update -y && apt upgrade -y

RUN apt install mariadb-server gettext-base -y

COPY /conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY /tools/init.sql /etc/mysql/init.sql
COPY /tools/script.sh .

RUN mkdir /run/mysqld && chmod +x script.sh

CMD ["./script.sh"]