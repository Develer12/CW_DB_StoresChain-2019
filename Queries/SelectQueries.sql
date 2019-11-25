use STORES_CHAIN


--Watch all employees
go
Create Procedure SEmpl
AS
Begin
	SELECT * FROM EMPLOYEES;
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