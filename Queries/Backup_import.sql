USE STORES_CHAIN
GO

--Backup to course project folder(next do backup of data and log)
Backup database STORES_CHAIN 
	to disk = 'D:\Subject\BD_COURSE\backups\STORES_CHAIN.bak';

--Backup to disk C
Backup database STORES_CHAIN 
	to disk = 'C:\Backups\STORES_CHAIN.bak';

USE master
GO
--Restore (not working)
RESTORE DATABASE FILELISTONLY
    FROM disk = 'D:\Subject\BD_COURSE\backups\STORES_CHAIN.bak'
		WITH replace;

------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------

--Sql query to xml
SELECT * from PRODUCTS
	FOR XML PATH('PRODUCT'), ROOT('PRODUCTS'); --Problem with Prod_Name, need to delete spaces

--to use xp_cmdshell
GO
EXEC master.dbo.sp_configure 'show advanced options', 1
	RECONFIGURE WITH OVERRIDE
EXEC master.dbo.sp_configure 'xp_cmdshell', 1
	RECONFIGURE WITH OVERRIDE;

-- Save XML records to a file
DECLARE @fileName VARCHAR(50)
DECLARE @sqlStr VARCHAR(1000)
DECLARE @sqlCmd VARCHAR(1000)

SET @fileName = 'D:\Subject\BD_COURSE\backups\STORES_CHAIN-Prod.xml'
SET @sqlStr = 'USE STORES_CHAIN; SELECT * from PRODUCTS FOR XML PATH(''PRODUCT''), ROOT(''PRODUCTS'') '
SET @sqlCmd = 'bcp "' + @sqlStr + '" queryout ' + @fileName + ' -w -T'
EXEC xp_cmdshell @sqlCmd;


--import from xml to server 
INSERT INTO PRODUCTS (Prod_Id, Prod_Name, Type_Prod_Id, Price_Purchase, Price_Sell, Weight, Volume)
SELECT
   MY_XML.PRODUCT.query('Prod_Id').value('.', 'NVARCHAR(13)'),
   MY_XML.PRODUCT.query('Prod_Name').value('.', 'VARCHAR(50)'),
   MY_XML.PRODUCT.query('Type_Prod_Id').value('.', 'INT'),
   MY_XML.PRODUCT.query('Price_Purchase').value('.', 'numeric(6,2)'),
   MY_XML.PRODUCT.query('Price_Sell').value('.', 'numeric(6,2)'),
   MY_XML.PRODUCT.query('Weight').value('.', 'INT'),
   MY_XML.PRODUCT.query('Volume').value('.', 'INT')

FROM (SELECT CAST(MY_XML AS xml)
      FROM OPENROWSET(BULK 'D:\Subject\BD_COURSE\backups\Import.xml', SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
      CROSS APPLY MY_XML.nodes('PRODUCTS/PRODUCT') AS MY_XML (PRODUCT);


select * from PRODUCTS where Prod_Id = '1111111111111' or Prod_Id = '1111111111112'
delete from PRODUCTS where Prod_Id = '1111111111111' or Prod_Id = '1111111111112'
