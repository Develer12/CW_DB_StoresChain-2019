use STORES_CHAIN

--Export xml
go
Create Procedure ExProdtoXml
AS
Begin
	SELECT Prod_Id, Prod_Name, Type_Prod_Id, Price_Purchase, Price_Sell, Weight, Volume from PRODUCTS
		FOR XML PATH('PRODUCT'), ROOT('PRODUCTS'); --Problem with Prod_Name, need to delete spaces

	--to use xp_cmdshell
	EXEC master.dbo.sp_configure 'show advanced options', 1
		RECONFIGURE WITH OVERRIDE
	EXEC master.dbo.sp_configure 'xp_cmdshell', 1
		RECONFIGURE WITH OVERRIDE;

	-- Save XML records to a file
	DECLARE @fileName nVARCHAR(100)
	DECLARE @sqlStr VARCHAR(1000)
	DECLARE @sqlCmd VARCHAR(1000)

	SET @fileName = 'D:\Subject\BD_COURSE\backups\STORES_CHAIN-Prod.xml'
	SET @sqlStr = 'USE STORES_CHAIN; SELECT Prod_Id, Prod_Name, Type_Prod_Id, Price_Purchase, Price_Sell, Weight, Volume from PRODUCTS FOR XML PATH(''PRODUCT''), ROOT(''PRODUCTS'') '
	SET @sqlCmd = 'bcp "' + @sqlStr + '" queryout ' + @fileName + ' -w -T'
	EXEC xp_cmdshell @sqlCmd;
End;


--Export DB
go
Create Procedure ExDB
AS
Begin
	--Backup to course project folder
	Backup database STORES_CHAIN 
		to disk = 'D:\Subject\BD_COURSE\backups\STORES_CHAIN.bak';
End;