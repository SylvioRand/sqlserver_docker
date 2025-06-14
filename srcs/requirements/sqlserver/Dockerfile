FROM mcr.microsoft.com/mssql/server:2019-latest

# Variables obligatoires
ENV ACCEPT_EULA=Y
ENV MSSQL_PID=Developer

# Installation des outils
USER root
RUN apt-get update && \
    apt-get install -y mssql-tools unixodbc-dev openssl && \
    ln -sf /opt/mssql-tools/bin/sqlcmd /usr/bin/sqlcmd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 🔧 Créer le dossier pour les certificats
RUN mkdir -p /var/opt/mssql/certs && \
    chown mssql /var/opt/mssql/certs && \
    chmod 700 /var/opt/mssql/certs

# 🔐 Générer les certificats SSL
RUN openssl req -x509 -nodes -newkey rsa:2048 \
    -subj '/CN=sqlserver' \
    -keyout /var/opt/mssql/certs/mssql.key \
    -out /var/opt/mssql/certs/mssql.pem -days 365 && \
    chmod 600 /var/opt/mssql/certs/mssql.*

# 🛠️ Configurer SQL Server pour utiliser SSL
RUN echo "[network]" > /var/opt/mssql/mssql.conf && \
    echo "tlscert = /var/opt/mssql/certs/mssql.pem" >> /var/opt/mssql/mssql.conf && \
    echo "tlskey = /var/opt/mssql/certs/mssql.key" >> /var/opt/mssql/mssql.conf && \
    echo "forceencryption = 1" >> /var/opt/mssql/mssql.conf

USER mssql

# Copie des fichiers
COPY --chmod=755 script.sh generate_sql.sh /tmp/

EXPOSE 1433

# Lancement
CMD ["/bin/bash", "-c", "set -e && /tmp/generate_sql.sh && /tmp/script.sh"]

