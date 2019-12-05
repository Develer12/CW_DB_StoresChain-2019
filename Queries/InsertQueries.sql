use STORES_CHAIN;


--Insert inside Products 
go
Create Procedure SProdOrderAdd
		@Prod_Id nvarchar(13),
		@Prod_Name nvarchar(50),
		@Type nvarchar(50),
		@Depart nvarchar(30), 
		@Price_Purchase numeric(6,2),
		@Price_Sell numeric(6,2),
		@Weight int,
		@Volume int
AS
Begin
	Insert into PRODUCTS(Prod_Id, Prod_Name, Type_Prod_Id,Price_Purchase,Price_Sell,Weight,Volume)
	values(@Prod_Id, @Prod_Name, (select Prod_Type_Id from PRODUCT_TYPE where Prod_Type = @Type and Id_Dep = (select Dep_Id from DEPARTMENTS where Depart = @Depart)), @Price_Purchase, @Price_Sell, @Weight, @Volume);
End;


--Delete from Products 
go
create Procedure SProdOrderDel
		@Prod_Num nvarchar(13)
AS
Begin
	Delete from USER_BASKET where Product = (select Prod_Num from PRODUCTS where Prod_Id = @Prod_Num);
	Delete from PRODUCTS where Prod_Id = @Prod_Num;
End;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

--Insert inside Emploees 
go
Create Procedure SEmplAdd
    @Name_First nvarchar(50),
    @Name_Sec nvarchar(50),
    @Name_Father nvarchar(50),
	@Id_Post nvarchar(50),
    @Sex nchar(1), 
    @Age int,
    @Exp int,
    @Id_Store nvarchar(30),
	@Country nvarchar(30),
    @Id_Dep nvarchar(30)
AS
Begin
	Insert into EMPLOYEES(Name_First, Name_Sec,Name_Father,Sex,Age,Exp, Id_Post, Id_Store, Id_Dep)
	values(@Name_First, @Name_Sec, @Name_Father, @Sex, @Age, @Exp, (select Post_Id from POSTS where Post = @Id_Post), (select Id_Store from STORES where Name_Store = @Id_Store and County = @Country), (select Dep_Id from DEPARTMENTS where Depart = @Id_Dep));
End;


--Delete from Products 
go
create Procedure SEmplDel
		@Empl int
AS
Begin
	Delete from STORE_ADMIN where EMPL_Id = @Empl;
	Delete from EMPLOYEES where Id_Empl = @Empl;
End;