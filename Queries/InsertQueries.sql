use STORES_CHAIN;


--Insert inside Products 
go
Create Procedure SProdOrderAdd
		@Prod_Num int,
		@Prod_Id nvarchar(13),
		@Prod_Name nvarchar(50),
		@Type int,
		@Price_Purchase numeric(6,2),
		@Price_Sell numeric(6,2),
		@Weight int,
		@Volume int
AS
Begin
	Insert into PRODUCTS(Prod_Id, Prod_Name, Type_Prod_Id,Price_Purchase,Price_Sell,Weight,Volume)
	values(@Prod_Id, @Prod_Name, (select Prod_Type_Id from PRODUCT_TYPE where Prod_Type = @Type), @Price_Purchase, @Price_Sell, @Weight, @Volume);
End;


--Delete from Products 
go
Create Procedure SProdOrderDel
		@Prod_Num int
AS
Begin
	Delete from PRODUCTS where Prod_Id = @Prod_Num;
End;


--Insert inside Products 
go
Create Procedure SEmplAdd
    @Name_First nvarchar(50),
    @Name_Sec nvarchar(50),
    @Name_Father nvarchar(50),
    @Sex nchar(1), 
    @Age int,
    @Exp int,
    @Id_Post int,
    @Id_Store int,
    @Id_Dep int
AS
Begin
	Insert into EMPLOYEES(Name_First, Name_Sec,Name_Father,Sex,Age,Exp, Id_Post, Id_Store, Id_Dep)
	values(@Name_First, @Name_Sec, @Name_Father, @Sex, @Age, @Exp, (select Post_Id from POSTS where Post = @Id_Post), (select Store_Type_Id from TYPE_STORE where Type = @Id_Store), (select Dep_Id from DEPARTMENTS where Depart = @Id_Dep));
End;