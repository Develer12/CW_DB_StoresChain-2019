use STORES_CHAIN;


go
Create Procedure OptProdType
	@dep nvarchar(50)
AS
Begin
	SELECT Prod_Type FROM PRODUCT_TYPE where Id_Dep = (select Dep_Id from DEPARTMENTS where Depart = @dep)
End;


go
Create Procedure OptDepart
AS
Begin
	SELECT Depart FROM DEPARTMENTS
End;


go
Create Procedure OptPost
AS
Begin
	SELECT Post FROM POSTS
End;


go
Create Procedure OptStoreType
AS
Begin
	SELECT * FROM TYPE_STORE
End;


go
Create Procedure OptUserType
AS
Begin
	SELECT Type_User FROM USER_TYPE
End;


go
Create Procedure OptAdminType
AS
Begin
	SELECT Admin_Type FROM TYPE_ADMIN
End;

go
Create Procedure OptCountry
AS
Begin
	SELECT distinct County FROM STORES;
End;