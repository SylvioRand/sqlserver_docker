#!/bin/bash
# Génère init.sql à partir des variables d'environnement

cat > /tmp/init.sql <<EOF
-- Création des logins
CREATE LOGIN $MSSQL_APP_LOGIN WITH PASSWORD = '$(cat "$MSSQL_APP_PASSWORD_FILE")';
CREATE LOGIN $MSSQL_DEV_LOGIN WITH PASSWORD = '$(cat "$MSSQL_DEV_PASSWORD_FILE")';
GO

-- Création de la base
CREATE DATABASE $MSSQL_DATABASE_NAME;
GO

-- Configuration utilisateurs
USE $MSSQL_DATABASE_NAME;
GO
CREATE USER $MSSQL_APP_LOGIN FOR LOGIN $MSSQL_APP_LOGIN;
CREATE USER $MSSQL_DEV_LOGIN FOR LOGIN $MSSQL_DEV_LOGIN;
GO

-- Permissions
EXEC sp_addrolemember 'db_datareader', '$MSSQL_APP_LOGIN';
EXEC sp_addrolemember 'db_datawriter', '$MSSQL_APP_LOGIN';
EXEC sp_addrolemember 'db_owner', '$MSSQL_DEV_LOGIN';
GO
EOF
