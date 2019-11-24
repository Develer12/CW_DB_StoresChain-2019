go
Create DataBase STORES_CHAIN;

go
use STORES_CHAIN;

Create Table TYPE_ADMIN
(
	Type_Id int identity(1,1) constraint TYPE_ADMIN_PK PRIMARY KEY,
	Admin_Type nvarchar(30)
);

Create Table USER_TYPE
(
    Type_User_Id int identity(1,1) constraint TYPE_USER_PK PRIMARY KEY,
	Type_User nvarchar(20),
    Sale_Size numeric(2,2) check((Sale_Size)<1)
);

Create Table USERS
(
	Id_User int identity(1,1) constraint USER_PK PRIMARY KEY,
    Name_First nvarchar(50),
    Name_Sec nvarchar(50),
    Name_Father nvarchar(50),
    Sex nchar(1) check(Sex = 'M' or Sex = 'F'), 
    Age int,
	User_Type int constraint TYPE_USER_FK foreign key references USER_TYPE(Type_User_Id)
);

Create Table TYPE_STORE
(
	Store_Type_Id int identity(1,1) constraint TYPE_STORE_PK PRIMARY KEY,
    Type nvarchar(30)
);

Create Table STORES
(
	Id_Store int identity(1,1) constraint STORE_PK PRIMARY KEY,
    Name_Store char(30),
    County nvarchar(30),
    Town nvarchar(30),
    Adress nvarchar(50),
    Id_Type int constraint TYPE_STORE_FK foreign key references TYPE_STORE(Store_Type_Id),
	Size int
);

Create Table DEPARTMENTS
(
	Dep_Id int identity(1,1) constraint POST_PK PRIMARY KEY,
    Depart nvarchar(30)
);

Create Table POSTS
(
	Post_Id int identity(1,1) constraint POST_ID_PK PRIMARY KEY,
    Post nvarchar(50)
);

Create Table EMPLOYEES
(
	Id_Empl int identity(1,1) constraint EMPL_PK PRIMARY KEY,
    Name_First nvarchar(50),
    Name_Sec nvarchar(50),
    Name_Father nvarchar(50),
    Sex nchar(1), 
    Age int,
    Exp int,
    Id_Post int constraint POST_ID_FK foreign key references POSTS(Post_Id),
    Id_Store int constraint STORE_ID_FK foreign key references STORES(Id_Store),
    Id_Dep int constraint DEP_ID_FK foreign key references DEPARTMENTS(Dep_Id)
);

Create Table STORE_ADMIN
(	
	Admin_Id int identity(1,1) constraint ADMIN_ID_PK PRIMARY KEY,
	Admin_Login nvarchar(13) unique,
    Admin_Pass nvarchar(30),
    Admin_Type_Id int constraint TYPE_ADMIN_FK foreign key references TYPE_ADMIN(Type_Id),
	EMPL_Id int constraint EMPL_ADMIN_FK foreign key references EMPLOYEES(Id_Empl)
);

Create Table PRODUCT_TYPE
(
	Prod_Type_Id int identity(1,1) constraint PROD_TYPE_PK PRIMARY KEY,
	Prod_Type nvarchar(50),
	Id_Dep int constraint PRODUCT_DEP_ID_FK foreign key references DEPARTMENTS(Dep_Id)
);

Create Table PRODUCTS
(	
	Prod_Num int identity(1,1) constraint PROD_PK PRIMARY KEY,
	Prod_Id nvarchar(13) check(LEN(Prod_Id) = 13) unique,
	Prod_Name nvarchar(50),
	Type_Prod_Id int constraint PRODUCT_TYPE_ID_FK foreign key references PRODUCT_TYPE(Prod_Type_Id),
	Price_Purchase numeric(6,2),
	Price_Sell numeric(6,2),
	Weight int,
	Volume int
);

Create Table USER_BASKET
(
	Id_Item int identity(1,1) constraint Item_PK PRIMARY KEY,
	Id_User int constraint USER_FK foreign key references USERS(Id_User),
	Product int constraint PROD_FK foreign key references PRODUCTS(Prod_Num)
);


/* MAYBE DELETE IT
Create Table SI_SIZE
(
	SI int identity(1,1) constraint SI_SIZE_PK PRIMARY KEY,
	SI_Name nvarchar(2)
);

Create Table PRODUCT_SIZE
(
	Id_Prod nvarchar(13) constraint PRODUCT_ID_FK foreign key references PRODUCTS(Prod_Id),
	Size_SI int constraint PROD_SIZE_FK foreign key references SI_SIZE(SI),
	Size_Height int,
	Size_Depth int,
	Size_Width int
);

Create Table SI_VOL
(
	SI int identity(1,1) constraint SI_VOL_PK PRIMARY KEY,
	SI_Name nvarchar(2)
);

Create Table PRODUCT_VOL
(
	Id_Prod nvarchar(13) constraint PRODUCT_ID2_FK foreign key references PRODUCTS(Prod_Id) ,
	Vol_SI int constraint PROD_VOL_FK foreign key references SI_VOL(SI),
	Volume int
);

Create Table SI_W
(
	SI int identity(1,1) constraint SI_W_PK PRIMARY KEY,
	SI_Name nvarchar(2)
);

Create Table PRODUCT_W
(
	Id_Prod nvarchar(13) constraint PRODUCT_ID3_FK foreign key references PRODUCTS(Prod_Id),
	W_SI int constraint PROD_W_FK foreign key references SI_W(SI),
	Weight int
); 
*/