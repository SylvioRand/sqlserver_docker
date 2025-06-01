FROM mcr.microsoft.com/mssql/server:2019-latest

# Variables obligatoires
ENV ACCEPT_EULA=Y

ENV MSSQL_PID=Developer
# Installation des outils
USER root
RUN apt-get update && \
    apt-get install -y mssql-tools unixodbc-dev && \
    ln -sf /opt/mssql-tools/bin/sqlcmd /usr/bin/sqlcmd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*  # Nettoyage pour réduire la taille de l'image

USER mssql

# Copie des fichiers
COPY --chmod=755 script.sh generate_sql.sh /tmp/
#COPY init.sql.template /tmp/

EXPOSE 1433

# Point d'entrée (version améliorée)
CMD ["/bin/bash", "-c", "set -e && /tmp/generate_sql.sh && /tmp/script.sh"]
