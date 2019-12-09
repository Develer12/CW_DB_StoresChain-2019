use STORES_CHAIN


--Watch all employees
go
Create Procedure SEmpl
	@end int,
	@start int
AS
Begin
	WITH num_row AS
	(
		SELECT row_number() OVER (ORDER BY Name_First) as nom , 		
		Id_Empl, Name_First, Name_Sec, Name_Father, t.Post, Sex, Age, Exp, Name_Store,County, d.Depart FROM EMPLOYEES p
		LEFT OUTER JOIN
		POSTS  t ON t.Post_Id = p.Id_Post
		LEFT OUTER JOIN
		STORES  s ON s.Id_Store = p.Id_Store
		LEFT OUTER JOIN
		DEPARTMENTS d ON d.Dep_Id = p.Id_Dep
	) 
	SELECT * FROM num_row
	WHERE nom BETWEEN @start AND @end;
End;


--Watch all Products
go
Create Procedure SProd
	@end int,
	@start int
AS
Begin
	WITH num_row AS
	(
		SELECT row_number() OVER (ORDER BY Prod_Name) as nom , 		
		Prod_Id, Prod_Name, Prod_Type,Depart,Price_Purchase,Price_Sell,Weight,Volume FROM PRODUCTS p
		LEFT OUTER JOIN
		PRODUCT_TYPE  t ON t.Prod_Type_Id = p.Type_Prod_Id
		LEFT OUTER JOIN
		DEPARTMENTS d ON d.Dep_Id = t.Id_Dep
	) 
	SELECT * FROM num_row
	WHERE nom BETWEEN @start AND @end;
End;


--Watch all Stores
go
Create Procedure SStore
	@end int,
	@start int
AS
Begin
	WITH num_row AS
	(
		SELECT row_number() OVER (ORDER BY p.Id_Store DESC) as nom , 		
		p.Id_Store, Name_Store, County, Town, Adress, Size, s.Type, count(Id_Empl) as Workers FROM STORES p
		LEFT OUTER JOIN
		TYPE_STORE  s ON s.Store_Type_Id = p.Id_Type
		LEFT OUTER JOIN
		EMPLOYEES  t ON t.Id_Store = p.Id_Type
		group by p.Id_Store, Name_Store, County, Town, Adress, Size, s.Type
	) 
	SELECT * FROM num_row
	WHERE nom BETWEEN @start AND @end;
End;


--Find Product by BarCode
go
Create Procedure FindProd
@BarC char(13),
	@end int,
	@start int
AS
Begin
	WITH num_row AS
	(
		SELECT row_number() OVER (ORDER BY Prod_Name) as nom , 		
		Prod_Id, Prod_Name, Prod_Type,Depart,Price_Purchase,Price_Sell,Weight,Volume FROM PRODUCTS p 
		LEFT OUTER JOIN
		PRODUCT_TYPE  t ON t.Prod_Type_Id = p.Type_Prod_Id
		LEFT OUTER JOIN
		DEPARTMENTS d ON d.Dep_Id = t.Id_Dep
		WHERE Prod_Id = @BarC
	) 
	SELECT * FROM num_row
	WHERE nom BETWEEN @start AND @end;
End;


--Watch all Users
go
Create Procedure SUser
	@end int,
	@start int
AS
Begin
	WITH num_row AS
	(
		SELECT row_number() OVER (ORDER BY Id_User DESC) as nom , 		
		Id_User, Name_First, Name_Sec,Name_Father,Sex,Age,Type_User,Sale_Size FROM USERS u
		LEFT OUTER JOIN
		USER_TYPE  t ON t.Type_User_Id = u.User_Type
	) 
	SELECT * FROM num_row
	WHERE nom BETWEEN @start AND @end;
End;


--Output user basket
go
Create Procedure OutBasket
	@User nvarchar(50),
	@end int,
	@start int
AS
Begin
	WITH num_row AS
	(
		SELECT row_number() OVER (ORDER BY Prod_Name) as nom , 		
		Prod_Id, Prod_Name, count(u.Product) as Count, Prod_Type,Depart,Price_Purchase,Price_Sell,Weight,Volume FROM PRODUCTS p 
		LEFT OUTER JOIN
		PRODUCT_TYPE  t ON t.Prod_Type_Id = p.Type_Prod_Id
		LEFT OUTER JOIN
		DEPARTMENTS d ON d.Dep_Id = t.Id_Dep
		Right OUTER JOIN
		USER_BASKET u ON u.Product = p.Prod_Num
		WHERE Id_User = @User
		group by Prod_Name, Prod_Id, Prod_Type,Depart,Price_Purchase,Price_Sell,Weight,Volume
	) 
	SELECT * FROM num_row
	WHERE nom BETWEEN @start AND @end;
End;


--Watch all Products by ORDER
go
Create Procedure SProdOrder
	@ord varchar(6),
	@end int,
	@start int
AS
Begin
	if @ord = 'byBar'
		WITH num_row AS
		(
			SELECT row_number() OVER (ORDER BY Prod_Id) as nom , 		
			Prod_Id, Prod_Name, Prod_Type,Depart,Price_Purchase,Price_Sell,Weight,Volume FROM PRODUCTS p 
			LEFT OUTER JOIN
			PRODUCT_TYPE  t ON t.Prod_Type_Id = p.Type_Prod_Id
			LEFT OUTER JOIN
			DEPARTMENTS d ON d.Dep_Id = t.Id_Dep
		) 
		SELECT * FROM num_row
		WHERE nom BETWEEN @start AND @end;


	else if @ord like 'byNam'
		WITH num_row AS
		(
			SELECT row_number() OVER (ORDER BY Prod_Name) as nom , 		
			Prod_Id, Prod_Name, Prod_Type,Depart,Price_Purchase,Price_Sell,Weight,Volume FROM PRODUCTS p 
			LEFT OUTER JOIN
			PRODUCT_TYPE  t ON t.Prod_Type_Id = p.Type_Prod_Id
			LEFT OUTER JOIN
			DEPARTMENTS d ON d.Dep_Id = t.Id_Dep
		) 
		SELECT * FROM num_row
		WHERE nom BETWEEN @start AND @end;


	else if @ord = 'byTyp'
		WITH num_row AS
		(
			SELECT row_number() OVER (ORDER BY Prod_Type) as nom , 		
			Prod_Id, Prod_Name, Prod_Type,Depart,Price_Purchase,Price_Sell,Weight,Volume FROM PRODUCTS p 
			LEFT OUTER JOIN
			PRODUCT_TYPE  t ON t.Prod_Type_Id = p.Type_Prod_Id
			LEFT OUTER JOIN
			DEPARTMENTS d ON d.Dep_Id = t.Id_Dep
		)
		SELECT * FROM num_row
		WHERE nom BETWEEN @start AND @end;


	else if @ord = 'byDep'
		WITH num_row AS
		(
			SELECT row_number() OVER (ORDER BY Depart) as nom , 		
			Prod_Id, Prod_Name, Prod_Type,Depart,Price_Purchase,Price_Sell,Weight,Volume FROM PRODUCTS p 
			LEFT OUTER JOIN
			PRODUCT_TYPE  t ON t.Prod_Type_Id = p.Type_Prod_Id
			LEFT OUTER JOIN
			DEPARTMENTS d ON d.Dep_Id = t.Id_Dep
		) 
		SELECT * FROM num_row
		WHERE nom BETWEEN @start AND @end;


	else if @ord = 'byPrP'
		WITH num_row AS
		(
			SELECT row_number() OVER (ORDER BY Price_Purchase) as nom , 		
			Prod_Id, Prod_Name, Prod_Type,Depart,Price_Purchase,Price_Sell,Weight,Volume FROM PRODUCTS p 
			LEFT OUTER JOIN
			PRODUCT_TYPE  t ON t.Prod_Type_Id = p.Type_Prod_Id
			LEFT OUTER JOIN
			DEPARTMENTS d ON d.Dep_Id = t.Id_Dep
		) 
		SELECT * FROM num_row
		WHERE nom BETWEEN @start AND @end;


	else if @ord = 'byPrS'
		WITH num_row AS
		(
			SELECT row_number() OVER (ORDER BY Price_Sell) as nom , 		
			Prod_Id, Prod_Name, Prod_Type,Depart,Price_Purchase,Price_Sell,Weight,Volume FROM PRODUCTS p 
			LEFT OUTER JOIN
			PRODUCT_TYPE  t ON t.Prod_Type_Id = p.Type_Prod_Id
			LEFT OUTER JOIN
			DEPARTMENTS d ON d.Dep_Id = t.Id_Dep
		) 
		SELECT * FROM num_row
		WHERE nom BETWEEN @start AND @end;


	else if @ord = 'byWei'
		WITH num_row AS
		(
			SELECT row_number() OVER (ORDER BY Weight) as nom , 		
			Prod_Id, Prod_Name, Prod_Type,Depart,Price_Purchase,Price_Sell,Weight,Volume FROM PRODUCTS p 
			LEFT OUTER JOIN
			PRODUCT_TYPE  t ON t.Prod_Type_Id = p.Type_Prod_Id
			LEFT OUTER JOIN
			DEPARTMENTS d ON d.Dep_Id = t.Id_Dep
		) 
		SELECT * FROM num_row
		WHERE nom BETWEEN @start AND @end;


	else if @ord = 'byVol'
		WITH num_row AS
		(
			SELECT row_number() OVER (ORDER BY Volume) as nom , 		
			Prod_Id, Prod_Name, Prod_Type,Depart,Price_Purchase,Price_Sell,Weight,Volume FROM PRODUCTS p 
			LEFT OUTER JOIN
			PRODUCT_TYPE  t ON t.Prod_Type_Id = p.Type_Prod_Id
			LEFT OUTER JOIN
			DEPARTMENTS d ON d.Dep_Id = t.Id_Dep
		) 
		SELECT * FROM num_row
		WHERE nom BETWEEN @start AND @end;

	if @ord = 'byBarD'
		WITH num_row AS
		(
			SELECT row_number() OVER (ORDER BY Prod_Id DESC) as nom , 		
			Prod_Id, Prod_Name, Prod_Type,Depart,Price_Purchase,Price_Sell,Weight,Volume FROM PRODUCTS p 
			LEFT OUTER JOIN
			PRODUCT_TYPE  t ON t.Prod_Type_Id = p.Type_Prod_Id
			LEFT OUTER JOIN
			DEPARTMENTS d ON d.Dep_Id = t.Id_Dep
		) 
		SELECT * FROM num_row
		WHERE nom BETWEEN @start AND @end;


	else if @ord = 'byVolD'
		WITH num_row AS
		(
			SELECT row_number() OVER (ORDER BY Volume DESC) as nom , 		
			Prod_Id, Prod_Name, Prod_Type,Depart,Price_Purchase,Price_Sell,Weight,Volume FROM PRODUCTS p 
			LEFT OUTER JOIN
			PRODUCT_TYPE  t ON t.Prod_Type_Id = p.Type_Prod_Id
			LEFT OUTER JOIN
			DEPARTMENTS d ON d.Dep_Id = t.Id_Dep
		) 
		SELECT * FROM num_row
		WHERE nom BETWEEN @start AND @end;


			else if @ord = 'byNamD'
		WITH num_row AS
		(
			SELECT row_number() OVER (ORDER BY Prod_Name DESC) as nom , 		
			Prod_Id, Prod_Name, Prod_Type,Depart,Price_Purchase,Price_Sell,Weight,Volume FROM PRODUCTS p 
			LEFT OUTER JOIN
			PRODUCT_TYPE  t ON t.Prod_Type_Id = p.Type_Prod_Id
			LEFT OUTER JOIN
			DEPARTMENTS d ON d.Dep_Id = t.Id_Dep
		) 
		SELECT * FROM num_row
		WHERE nom BETWEEN @start AND @end;


			else if @ord = 'byDepD'
		WITH num_row AS
		(
			SELECT row_number() OVER (ORDER BY Depart DESC) as nom , 		
			Prod_Id, Prod_Name, Prod_Type,Depart,Price_Purchase,Price_Sell,Weight,Volume FROM PRODUCTS p 
			LEFT OUTER JOIN
			PRODUCT_TYPE  t ON t.Prod_Type_Id = p.Type_Prod_Id
			LEFT OUTER JOIN
			DEPARTMENTS d ON d.Dep_Id = t.Id_Dep
		) 
		SELECT * FROM num_row
		WHERE nom BETWEEN @start AND @end;


			else if @ord = 'byTypD'
		WITH num_row AS
		(
			SELECT row_number() OVER (ORDER BY Prod_Type DESC) as nom , 		
			Prod_Id, Prod_Name, Prod_Type,Depart,Price_Purchase,Price_Sell,Weight,Volume FROM PRODUCTS p 
			LEFT OUTER JOIN
			PRODUCT_TYPE  t ON t.Prod_Type_Id = p.Type_Prod_Id
			LEFT OUTER JOIN
			DEPARTMENTS d ON d.Dep_Id = t.Id_Dep
		) 
		SELECT * FROM num_row
		WHERE nom BETWEEN @start AND @end;


			else if @ord = 'byPrPD'
		WITH num_row AS
		(
			SELECT row_number() OVER (ORDER BY Price_Purchase DESC) as nom , 		
			Prod_Id, Prod_Name, Prod_Type,Depart,Price_Purchase,Price_Sell,Weight,Volume FROM PRODUCTS p 
			LEFT OUTER JOIN
			PRODUCT_TYPE  t ON t.Prod_Type_Id = p.Type_Prod_Id
			LEFT OUTER JOIN
			DEPARTMENTS d ON d.Dep_Id = t.Id_Dep
		) 
		SELECT * FROM num_row
		WHERE nom BETWEEN @start AND @end;


			else if @ord = 'byPrSD'
		WITH num_row AS
		(
			SELECT row_number() OVER (ORDER BY Price_Sell DESC) as nom , 		
			Prod_Id, Prod_Name, Prod_Type,Depart,Price_Purchase,Price_Sell,Weight,Volume FROM PRODUCTS p 
			LEFT OUTER JOIN
			PRODUCT_TYPE  t ON t.Prod_Type_Id = p.Type_Prod_Id
			LEFT OUTER JOIN
			DEPARTMENTS d ON d.Dep_Id = t.Id_Dep
		) 
		SELECT * FROM num_row
		WHERE nom BETWEEN @start AND @end;


			else if @ord = 'byWeiD'
		WITH num_row AS
		(
			SELECT row_number() OVER (ORDER BY Weight DESC) as nom , 		
			Prod_Id, Prod_Name, Prod_Type,Depart,Price_Purchase,Price_Sell,Weight,Volume FROM PRODUCTS p 
			LEFT OUTER JOIN
			PRODUCT_TYPE  t ON t.Prod_Type_Id = p.Type_Prod_Id
			LEFT OUTER JOIN
			DEPARTMENTS d ON d.Dep_Id = t.Id_Dep
		) 
		SELECT * FROM num_row
		WHERE nom BETWEEN @start AND @end;
End;
