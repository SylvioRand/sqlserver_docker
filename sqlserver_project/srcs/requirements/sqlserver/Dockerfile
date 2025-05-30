FROM mcr.microsoft.com/mssql/server:2019-latest

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=YourStrong!Passw0rd
ENV MSSQL_PID=Developer

COPY --chmod=+x script.sh /tmp/script.sh
COPY init.sql /tmp/init.sql

EXPOSE 1433

CMD ["/tmp/script.sh"]
