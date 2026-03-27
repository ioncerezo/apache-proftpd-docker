FROM ubuntu:22.04 AS builder
RUN apt-get update && apt-get install -y git openssh-client
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh

# La clave
COPY id_rsa_anonimo /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

# uso mkdir para que no se bloquee al clonar
RUN git clone git@github.com:deaw-birt/UD3-ftp_anonimo.git /repo_anonimo || mkdir /repo_anonimo

FROM ubuntu:22.04

LABEL version="1.0" description="cerezo_valero_ion_DEAW03_TareaEvaluativa02" maintainer="Ion Cerezo"
ENV DEBIAN_FRONTEND=noninteractive

# Instalacion inicial
RUN apt-get update && \
    apt-get install -y nano apache2 proftpd proftpd-mod-crypto openssh-server openssl && \
    rm -rf /var/lib/apt/lists/*

# Activar TLS en ProFTPD
RUN sed -i 's/#\s*LoadModule mod_tls.c/LoadModule mod_tls.c/' /etc/proftpd/modules.conf

RUN mkdir -p /var/www/html/sitioprimero /var/www/html/sitiosegundo /var/run/sshd /srv/ftp_anonimo

# Copiar las webs base
COPY index1.html /var/www/html/sitioprimero/index.html
COPY index2.html /var/www/html/sitiosegundo/index.html

# Copiar configuraciones y certificados
COPY sitio1.conf /etc/apache2/sites-available/sitioprimero.conf
COPY sitio2.conf /etc/apache2/sites-available/sitiosegundo.conf
COPY sitio1.key /etc/ssl/private/sitioprimero.key
COPY sitio1.cer /etc/ssl/certs/sitioprimero.cer

# Configurar ProFTPD
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/proftpd.key \
    -out /etc/ssl/certs/proftpd.crt \
    -subj "/C=ES/ST=PV/L=Ermua/O=BirtLH/CN=Ion Cerezo"

COPY proftpd.conf /etc/proftpd/proftpd.conf
COPY tls.conf /etc/proftpd/tls.conf

# Copiar el repositorio de la etapa anterior al contenedor
COPY --from=builder /repo_anonimo /srv/ftp_anonimo/

# Crear usuarios
RUN useradd -d /var/www/html/sitioprimero -s /usr/sbin/nologin icerezo1 && \
    echo "icerezo1:icerezo1" | chpasswd

RUN useradd -d /var/www/html/sitiosegundo -s /bin/bash icerezo2 && \
    echo "icerezo2:icerezo2" | chpasswd
RUN echo "icerezo2" >> /etc/ftpusers

# Permisos
RUN chown -R icerezo1:icerezo1 /var/www/html/sitioprimero && \
    chown -R icerezo2:icerezo2 /var/www/html/sitiosegundo && \
    chown -R ftp:nogroup /srv/ftp_anonimo

# Habilitar Apache y script de arranque
COPY start.sh /start.sh
RUN chmod +x /start.sh
RUN a2enmod ssl && a2ensite sitioprimero.conf sitiosegundo.conf

EXPOSE 80 443 21 22 60000-60010
CMD ["/start.sh"]