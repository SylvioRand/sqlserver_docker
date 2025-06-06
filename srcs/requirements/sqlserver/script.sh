#!/bin/bash

# Start SQL Server
/opt/mssql/bin/sqlservr &

# Wait for SQL Server to start
sleep 30

# Read SA password from file
SA_PASSWORD=$(cat "$MSSQL_SA_PASSWORD_FILE" )

# Run initialization script
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -i /tmp/init.sql

wait
