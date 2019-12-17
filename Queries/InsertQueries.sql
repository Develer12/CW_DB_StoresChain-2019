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


--Update Products 
go
Create Procedure SProdOrderUpdate
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
	Update PRODUCTS
	set Prod_Name = @Prod_Name,
	Type_Prod_Id = (select Prod_Type_Id from PRODUCT_TYPE where Prod_Type = @Type and Id_Dep = (select Dep_Id from DEPARTMENTS where Depart = @Depart)),
	Price_Purchase = @Price_Purchase,
	Price_Sell = @Price_Sell,
	Weight = @Weight,
	Volume = @Volume
	where Prod_Id = @Prod_Id;
End;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

--Insert inside Employees 
go
Create Procedure SEmplAdd
    @Name_First nvarchar(50),
    @Name_Sec nvarchar(50),
    @Name_Father nvarchar(50),
	@Id_Post nvarchar(50),
    @Sex nchar(1), 
    @Age int,
    @Exp int,
    @Id_Store int,
    @Id_Dep nvarchar(30)
AS
Begin
	Insert into EMPLOYEES(Name_First, Name_Sec,Name_Father,Sex,Age,Exp, Id_Post, Id_Store, Id_Dep)
	values(@Name_First, @Name_Sec, @Name_Father, @Sex, @Age, @Exp, (select Post_Id from POSTS where Post = @Id_Post), @Id_Store, (select Dep_Id from DEPARTMENTS where Depart = @Id_Dep));
End;


--Delete from Employees 
go
create Procedure SEmplDel
		@Empl int
AS
Begin
	Delete from STORE_ADMIN where EMPL_Id = @Empl;
	Delete from EMPLOYEES where Id_Empl = @Empl;
End;

--Update Employee
go
Create Procedure SEmplUpdate
	@Empl int,
    @Name_First nvarchar(50),
    @Name_Sec nvarchar(50),
    @Name_Father nvarchar(50),
	@Id_Post nvarchar(50),
    @Sex nchar(1), 
    @Age int,
    @Exp int,
    @Id_Store int,
    @Id_Dep nvarchar(30)
AS
Begin
	Update EMPLOYEES
	SET Name_First = @Name_First,
	Name_Sec = @Name_Sec,
	Name_Father = @Name_Father,
	Sex = @Sex,
	Age = @Age,
	Exp = @Exp,
	Id_Post = (select Post_Id from POSTS where Post = @Id_Post),
	Id_Store = @Id_Store,
	Id_Dep = (select Dep_Id from DEPARTMENTS where Depart = @Id_Dep)
	where Id_Empl = @Empl;
End;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

--Insert inside Stores 
go
Create Procedure SStoreAdd
    @Name_Store nvarchar(30),
	@Country nvarchar(30),
  	@Town nvarchar(30),
	@Addr nvarchar(50),
	@Id_Type nvarchar(30),
	@Size int
AS
Begin
	Insert into STORES(Name_Store, County,Town,Adress,Id_Type,Size)
	values(@Name_Store, @Country, @Town, @Addr, (select Store_Type_Id from TYPE_STORE where Type = @Id_Type), @Size);
End;


--Delete from Stores 
go
create Procedure SStoreDel
		@St int
AS
Begin
	Delete from EMPLOYEES where Id_Store = @St;
	Delete from STORES where Id_Store = @St;
End;

--Update Stores
go
Create Procedure SStoreUpdate
	@St int,
    @Name_Store nvarchar(30),
	@Country nvarchar(30),
  	@Town nvarchar(30),
	@Addr nvarchar(50),
	@Id_Type nvarchar(30),
	@Size int
AS
Begin
	Update STORES
	SET Name_Store = @Name_Store,
	County = @Country,
	Town = @Town,
	Adress = @Addr,
	Size = @Size,
	Id_Type = (select Store_Type_Id from TYPE_STORE where Type = @Id_Type)
	where Id_Store = @St;
End;


----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

--Insert inside Users 
go
Create Procedure SUserAdd
    @Name_First nvarchar(50),
    @Name_Sec nvarchar(50),
    @Name_Father nvarchar(50),
    @Sex nchar(1), 
    @Age int,
    @User_Type nvarchar(20)
AS
Begin
	Insert into USERS(Name_First, Name_Sec,Name_Father,Sex,Age,User_Type)
	values(@Name_First, @Name_Sec, @Name_Father, @Sex, @Age, (select Type_User_Id from USER_TYPE where Type_User = @User_Type));
End;


--Delete from Users 
go
create Procedure SUserDel
		@Id int
AS
Begin
	Delete from USER_BASKET where Id_User = @Id;
	Delete from USERS where Id_User = @Id;
End;

--Update User
go
Create Procedure SUserUpdate
	@Id int,
    @Name_First nvarchar(50),
    @Name_Sec nvarchar(50),
    @Name_Father nvarchar(50),
    @Sex nchar(1), 
    @Age int,
    @User_Type nvarchar(20)
AS
Begin
	Update USERS
	SET Name_First = @Name_First,
	Name_Sec = @Name_Sec,
	Name_Father = @Name_Father,
	Sex = @Sex,
	Age = @Age,
	User_Type = (select Type_User_Id from USER_TYPE where Type_User = @User_Type)
	where Id_User = @Id;
End;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

--Insert inside Basket 
go
Create Procedure OutBasketAdd
	@User int,
	@Id nvarchar(13)
AS
Begin
	Insert into USER_BASKET(Id_User, Product, Date_Buy)
	values(@User, (select Prod_Num from PRODUCTS where Prod_Id = @Id), CAST(GETDATE() AS DATE));
End;


--Delete from Basket 
go
create Procedure OutBasketDel
		@User int,
		@Id nvarchar(13)
AS
Begin
	Delete from USER_BASKET where Id_Item = (select top(1) Id_Item from USER_BASKET where 
			Product = (select Prod_Num from PRODUCTS where Prod_Id = @Id) 
			and Id_User = @User order by Date_Buy desc);
End;


----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

--Insert inside Admin 
go
Create Procedure SAdminAdd
    @Login nvarchar(13),
    @Pass nvarchar(30),
    @Type nvarchar(30),
    @EmplId int
AS
Begin
	Insert into STORE_ADMIN(Admin_Login, Admin_Pass,Admin_Type_Id,EMPL_Id)
	values(@Login, @Pass, (select Type_Id from TYPE_ADMIN where Admin_Type = @Type), @EmplId);
End;


--Delete from Admin 
go
create Procedure SAdminDel
		@Id int
AS
Begin
	Delete from STORE_ADMIN where Admin_Id = @Id;
End;

--Update User
go
Create Procedure SAdminUpdate
	@Id int,
    @Login nvarchar(13),
    @Pass nvarchar(30),
    @Type nvarchar(30),
    @EmplId int
AS
Begin
	Update STORE_ADMIN
	SET Admin_Login = @Login,
	Admin_Pass = @Pass,
	Admin_Type_Id = (select Type_Id from TYPE_ADMIN where Admin_Type = @Type),
	EMPL_Id = @EmplId
	where Admin_Id = @Id;
End;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------