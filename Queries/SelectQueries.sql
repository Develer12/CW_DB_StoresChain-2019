use STORES_CHAIN


--Watch all employees
go
Create Procedure SEmpl
AS
Begin
	SELECT Name_First, Name_Sec, Name_Father, t.Post, Sex, Age, Exp, Name_Store,County, Town, Adress FROM EMPLOYEES p
	LEFT OUTER JOIN
	POSTS  t ON t.Post_Id = p.Id_Post
	LEFT OUTER JOIN
	STORES  s ON s.Id_Store = p.Id_Store
	LEFT OUTER JOIN
	DEPARTMENTS d ON d.Dep_Id = p.Id_Dep;
End;


--Watch all Products
go
Create Procedure SProd
AS
Begin
	SELECT Prod_Id, Prod_Name, Prod_Type,Depart,Price_Purchase,Price_Sell,Weight,Volume FROM PRODUCTS p
	LEFT OUTER JOIN
	PRODUCT_TYPE  t ON t.Prod_Type_Id = p.Type_Prod_Id
	LEFT OUTER JOIN
	DEPARTMENTS d ON d.Dep_Id = t.Id_Dep;
End;


--Watch all Stores
go
Create Procedure SStore
AS
Begin
	Select Name_Store, County, Town, Adress, Size, s.Type, count(Id_Empl) as Workers FROM STORES p
	LEFT OUTER JOIN
	TYPE_STORE  s ON s.Store_Type_Id = p.Id_Type
	LEFT OUTER JOIN
	EMPLOYEES  t ON t.Id_Store = p.Id_Type
	group by Name_Store, County, Town, Adress, Size, s.Type;
End;


--Find Product by BarCode
go
Create Procedure FindProd
@BarC char(13)
AS
Begin
	SELECT Prod_Id, Prod_Name, Prod_Type,Depart,Price_Purchase,Price_Sell,Weight,Volume FROM PRODUCTS p 
	LEFT OUTER JOIN
	PRODUCT_TYPE  t ON t.Prod_Type_Id = p.Type_Prod_Id
	LEFT OUTER JOIN
	DEPARTMENTS d ON d.Dep_Id = t.Id_Dep
	WHERE Prod_Id = @BarC;
End;


--Output user basket
go
Create Procedure OutBasket
	@User nvarchar(50)
AS
Begin
	SELECT Prod_Id, Prod_Name, Prod_Type,Depart,Price_Purchase,Price_Sell,Weight,Volume FROM PRODUCTS p 
	LEFT OUTER JOIN
	PRODUCT_TYPE  t ON t.Prod_Type_Id = p.Type_Prod_Id
	LEFT OUTER JOIN
	DEPARTMENTS d ON d.Dep_Id = t.Id_Dep
	Right OUTER JOIN
	USER_BASKET u ON u.Product = p.Prod_Num
	WHERE Id_User = @User;
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
		WHERE nom BETWEEN @start AND @end
		order by Prod_Id;
	else if @ord = 'byName'
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
		WHERE nom BETWEEN @start AND @end
		order by Prod_Name;
	else if @ord = 'byType'
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
		WHERE nom BETWEEN @start AND @end
		order by Prod_Type;
	else if @ord = 'byDepart'
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
		WHERE nom BETWEEN @start AND @end
		order by Depart;
	else if @ord = 'byPr_P'
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
		WHERE nom BETWEEN @start AND @end
		order by Price_Purchase;
	else if @ord = 'byPr_S'
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
		WHERE nom BETWEEN @start AND @end
		order by Price_Sell;
	else if @ord = 'byWeight'
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
		WHERE nom BETWEEN @start AND @end
		order by Weight;
	else if @ord = 'byVolume'
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
		WHERE nom BETWEEN @start AND @end
		order by Volume;
End;