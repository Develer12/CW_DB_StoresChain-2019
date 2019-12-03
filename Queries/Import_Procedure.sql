use STORES_CHAIN

--import from xml to server 
go
Create Procedure ImProdfromXml
AS
Begin
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
End;


--Restore DB
go
Create Procedure ImDB
AS
Begin
	RESTORE DATABASE STORES_CHAIN
		FROM disk = 'D:\Subject\BD_COURSE\backups\STORES_CHAIN.bak'
			WITH replace;
End;