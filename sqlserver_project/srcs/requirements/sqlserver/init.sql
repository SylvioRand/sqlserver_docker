-- Création des logins
CREATE LOGIN ACApp WITH PASSWORD = 'AppPassword!';
CREATE LOGIN ACDev WITH PASSWORD = 'DevPassword!';
GO

-- Création de la base de données
CREATE DATABASE AwesomeCompany;
GO

-- Configuration des utilisateurs
USE AwesomeCompany;
GO
CREATE USER ACApp FOR LOGIN ACApp;
CREATE USER ACDev FOR LOGIN ACDev;
GO

-- Attribution des permissions
EXEC sp_addrolemember 'db_datareader', 'ACApp';
EXEC sp_addrolemember 'db_datawriter', 'ACApp';
GO

EXEC sp_addrolemember 'db_owner', 'ACDev';
GO
