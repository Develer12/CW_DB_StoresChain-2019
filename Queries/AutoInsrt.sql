Use STORES_CHAIN


go
--------------------Random name alghorythm-----------------------
--COMPLETED!!
Create Procedure CreateName
	@size integer,
	@Name char(50) OUTPUT
AS
Begin
	SET @Name = (
	SELECT
		c1 AS [text()]
	FROM
		(
		SELECT TOP (@size) c1
		FROM
		  (
		VALUES
		  ('A'), ('B'), ('C'), ('D'), ('E'), ('F'), ('G'), ('H'), ('I'), ('J'),
		  ('K'), ('L'), ('M'), ('N'), ('O'), ('P'), ('Q'), ('R'), ('S'), ('T'),
		  ('U'), ('V'), ('W'), ('X'), ('Y'), ('Z')
		  ) AS T1(c1)
		ORDER BY ABS(CHECKSUM(NEWID()))
		) AS T2
	FOR XML PATH('')
	);
End;


go
--------------------Random BarCode alghorythm-----------------------
--COMPLETED!!
Create Procedure CreateBarcode
	@BarC char(13) OUTPUT
AS
Begin
	SET @BarC = (
	SELECT
		c1 AS [text()]
	FROM
		(
		SELECT TOP (13) c1
		FROM (VALUES ('0'), ('1'), ('2'), ('3'), ('4'), ('5'), ('6'), ('7'), ('8'), ('9'),
		('0'), ('1'), ('2'), ('3'), ('4'), ('5'), ('6'), ('7'), ('8'), ('9')) AS T1(c1)
			ORDER BY ABS(CHECKSUM(NEWID()))
		) AS T2
	FOR XML PATH('')
	);
End;
--------------------|AI USERS|-----------------------
--COMPLETED!!
go
Create Procedure AI_USER AS
Begin
DECLARE @str1 char(50),
		@str2 char(50),
		@str3 char(50),
		@sx char(1),
		@number INT;

SET @number = 1;

While @number <= 100000
	BEGIN
	exec CreateName 10, @str1 OUTPUT;
	exec CreateName 10, @str2 OUTPUT;
	exec CreateName 10, @str3 OUTPUT;
	SET @sx = (
	SELECT
		c1 AS [text()]
	FROM
		(
		SELECT TOP (1) c1
		FROM (VALUES ('M'), ('F')) AS T1(c1) ORDER BY ABS(CHECKSUM(NEWID()))
		) AS T2
	FOR XML PATH('')
	);
	Insert into USERS(Name_First, Name_Sec, Name_Father, Age, Sex, User_Type)
		values(@str1, @str2, @str3, ABS(CHECKSUM(NEWID()) % 70) + 10, @sx,ABS(CHECKSUM(NEWID()) % 6) + 1);
	SET @number = @number + 1;
	END;
End;



go
--------------------|AI STORES|-----------------------
--COMPLETED!!
Create Procedure AI_STORE AS
Begin
DECLARE @str1 char(30),
		@cntry char(30),
		@str2 char(30),
		@str3 char(30),
		@number INT;

SET @number = 1;

While @number <= 100000
	BEGIN
	exec CreateName 10, @str1 OUTPUT;
	SET @cntry = (
		SELECT
			c1 AS [text()]
		FROM
			(
			SELECT TOP (1) c1
			FROM (VALUES ('Belarus'), ('Russia'), ('Poland'), ('Germany'), ('France')) AS T1(c1) ORDER BY ABS(CHECKSUM(NEWID()))
			) AS T2
		FOR XML PATH('')
	);
	exec CreateName 10, @str2 OUTPUT;
	exec CreateName 10, @str3 OUTPUT;
	Insert into STORES(Name_Store, County, Town, Adress, Id_Type, Size)
		values(@str1, @cntry, @str2, @str3, ABS(CHECKSUM(NEWID()) % 6) + 1,ABS(CHECKSUM(NEWID()) % 2900) + 100);
	SET @number = @number + 1;
	END;
End;



go
--------------------|AI PRODUCTS|-----------------------
--COMPLITED!!
Create Procedure AI_PROD AS
Begin
DECLARE @str1 char(50),
		@str2 char(20),
		@number INT,
		@price numeric(6,2);

SET @number = 1;

While @number <= 100000
	BEGIN
	exec CreateName 13, @str1 OUTPUT;
	exec CreateBarcode @str2 OUTPUT;
	SET @price = CAST(((ABS(CHECKSUM(NEWID()) % 600*100) + 1*100)/100) as numeric(6,2));
	Insert into PRODUCTS(Prod_Id, Prod_Name,Type_Prod_Id,Price_Purchase,Price_Sell,Weight,Volume)
		values(@str2, @str1, 
		ABS(CHECKSUM(NEWID()) % 110) + 1, @price,
		 CAST((@price * 1.5) as numeric(6,2)),
		 ABS(CHECKSUM(NEWID()) % 2000) + 100,
		 ABS(CHECKSUM(NEWID()) % 2000) + 100);
	SET @number = @number + 1;
	END;
End;



go
--------------------|AI BASKET|-----------------------
--COMPLITED!!
Create Procedure AI_BASKET AS
Begin
DECLARE @number INT;

SET @number = 1;

While @number <= 100000
	BEGIN
	Insert into USER_BASKET(Id_User,Product)
		values(ABS(CHECKSUM(NEWID()) % (Select count(Id_User) from USERS)) + 1, ABS(CHECKSUM(NEWID()) % (Select count(Prod_Num) from PRODUCTS)) + 1);
	SET @number = @number + 1;
	END;
End;



go
--------------------|AI EMPLOYEES|-----------------------
--COMPLITED!!
Create Procedure AI_EMPLOYEES AS
Begin
DECLARE @str1 char(50),
		@str2 char(50),
		@str3 char(50),
		@sx char(1),
		@age int,
		@number INT;

SET @number = 1;

While @number <= 100000
	BEGIN
	exec CreateName 10, @str1 OUTPUT;
	exec CreateName 10, @str2 OUTPUT;
	exec CreateName 10, @str3 OUTPUT;
	SET @sx = (
	SELECT
		c1 AS [text()]
	FROM
		(
		SELECT TOP (1) c1
		FROM (VALUES ('M'), ('F')) AS T1(c1) ORDER BY ABS(CHECKSUM(NEWID()))
		) AS T2
	FOR XML PATH('')
	);
	SET @age = ABS(CHECKSUM(NEWID()) % 47) + 18;
	Insert into EMPLOYEES(Name_First, Name_Sec, Name_Father, Sex, Age, Exp, Id_Post,Id_Store,Id_Dep)
		values(@str1, @str2, @str3, @sx, @age, ABS(CHECKSUM(NEWID()) % (@age - 18)), 
			   ABS(CHECKSUM(NEWID()) % (Select count(Post) from POSTS)) + 1,
			   ABS(CHECKSUM(NEWID()) % (Select count(Id_Store) from STORES)) + 1,
			   ABS(CHECKSUM(NEWID()) % (Select count(Dep_Id) from DEPARTMENTS)) + 1);
	SET @number = @number + 1;
	END;
End;