--Default Inserting--

use STORES_CHAIN
go

----------POST----------

Insert into POSTS(Post)
	values('Administrator'),
		  ('Cleaner'),
		  ('Salesman'),
		  ('Cashier'),
		  ('Assistanse'),
		  ('Adviser'),
		  ('Manager'),
		  ('Vice president'),
		  ('President'),
		  ('DB Admin');
--COMPLITED!!


----------Department----------
Insert into DEPARTMENTS(Depart)
	values('Stock'),
	      ('Office'),
		  ('Meet'),
		  ('Milk'),
		  ('Fruit|Vegetable'),
		  ('Alcohol'),
		  ('Electronic'),
		  ('Bakery'),
		  ('Drinks'),
		  ('Grocery'),
		  ('Sweets'),
		  ('Child Food'),
		  ('For Children'),
		  ('For Animals'),
		  ('Cosmetics'),
		  ('For Home'),
		  ('For Garden'),
		  ('For Office');
--COMPLITED!!


----------Product Type----------

Insert into PRODUCT_TYPE(Prod_Type, Id_Dep)
	values('Eggs', (select Dep_Id from DEPARTMENTS where Depart = 'Meet')),
		  ('MilkShake', (select Dep_Id from DEPARTMENTS where Depart = 'Milk')),
		  ('Sour-milk products', (select Dep_Id from DEPARTMENTS where Depart = 'Milk')),
		  ('Cheese', (select Dep_Id from DEPARTMENTS where Depart = 'Milk')),
		  ('Butter', (select Dep_Id from DEPARTMENTS where Depart = 'Milk')),
		  ('Curd products', (select Dep_Id from DEPARTMENTS where Depart = 'Milk')),
		  ('Sour cream', (select Dep_Id from DEPARTMENTS where Depart = 'Milk')),
		  ('Ice Cream', (select Dep_Id from DEPARTMENTS where Depart = 'Milk')),
		  ('Yogurt', (select Dep_Id from DEPARTMENTS where Depart = 'Milk')),
		  ('Bread', (select Dep_Id from DEPARTMENTS where Depart = 'Bakery')),
		  ('Confectionery', (select Dep_Id from DEPARTMENTS where Depart = 'Bakery')),
		  ('Pork', (select Dep_Id from DEPARTMENTS where Depart = 'Meet')),
		  ('Bird', (select Dep_Id from DEPARTMENTS where Depart = 'Meet')),
		  ('Beef', (select Dep_Id from DEPARTMENTS where Depart = 'Meet')),
		  ('Fish and seafood', (select Dep_Id from DEPARTMENTS where Depart = 'Meet')),
		  ('Other meet', (select Dep_Id from DEPARTMENTS where Depart = 'Meet')),
		  ('Prefabricated chilled', (select Dep_Id from DEPARTMENTS where Depart = 'Meet')),
		  ('Prefabricated frozen', (select Dep_Id from DEPARTMENTS where Depart = 'Meet')),
		  ('Sausages', (select Dep_Id from DEPARTMENTS where Depart = 'Meet')),
		  ('Vegetables', (select Dep_Id from DEPARTMENTS where Depart = 'Fruit|Vegetable')),
		  ('Fruits', (select Dep_Id from DEPARTMENTS where Depart = 'Fruit|Vegetable')),
		  ('Mushrooms', (select Dep_Id from DEPARTMENTS where Depart = 'Fruit|Vegetable')),
		  ('Berries', (select Dep_Id from DEPARTMENTS where Depart = 'Fruit|Vegetable')),
		  ('Greenery', (select Dep_Id from DEPARTMENTS where Depart = 'Fruit|Vegetable')),
		  ('Pickles and pickles', (select Dep_Id from DEPARTMENTS where Depart = 'Fruit|Vegetable')),
		  ('Wine', (select Dep_Id from DEPARTMENTS where Depart = 'Fruit|Vegetable')),
		  ('Vodka', (select Dep_Id from DEPARTMENTS where Depart = 'Alcohol')),
		  ('Beer', (select Dep_Id from DEPARTMENTS where Depart = 'Alcohol')),
		  ('Whiskey', (select Dep_Id from DEPARTMENTS where Depart = 'Alcohol')),
		  ('Tinctures', (select Dep_Id from DEPARTMENTS where Depart = 'Alcohol')),
		  ('Bourbon', (select Dep_Id from DEPARTMENTS where Depart = 'Alcohol')),
		  ('Cognac', (select Dep_Id from DEPARTMENTS where Depart = 'Alcohol')),
		  ('Liquor', (select Dep_Id from DEPARTMENTS where Depart = 'Alcohol')),
		  ('Other alcohol', (select Dep_Id from DEPARTMENTS where Depart = 'Alcohol')),
		  ('Phones', (select Dep_Id from DEPARTMENTS where Depart = 'Electronic')),
		  ('Computer', (select Dep_Id from DEPARTMENTS where Depart = 'Electronic')),
		  ('For kitchen', (select Dep_Id from DEPARTMENTS where Depart = 'Electronic')),
		  ('For home', (select Dep_Id from DEPARTMENTS where Depart = 'Electronic')),
		  ('For sport', (select Dep_Id from DEPARTMENTS where Depart = 'Electronic')),
		  ('Audio', (select Dep_Id from DEPARTMENTS where Depart = 'Electronic')),
		  ('TV', (select Dep_Id from DEPARTMENTS where Depart = 'Electronic')),
		  ('Foto and Video', (select Dep_Id from DEPARTMENTS where Depart = 'Electronic')),
		  ('For auto', (select Dep_Id from DEPARTMENTS where Depart = 'Electronic')),
		  ('For construction', (select Dep_Id from DEPARTMENTS where Depart = 'Electronic')),
		  ('For game', (select Dep_Id from DEPARTMENTS where Depart = 'Electronic')),
		  ('Water', (select Dep_Id from DEPARTMENTS where Depart = 'Drinks')),
		  ('Juices', (select Dep_Id from DEPARTMENTS where Depart = 'Drinks')),
		  ('Energy drinks', (select Dep_Id from DEPARTMENTS where Depart = 'Drinks')),
		  ('Coffee', (select Dep_Id from DEPARTMENTS where Depart = 'Drinks')),
		  ('Tea', (select Dep_Id from DEPARTMENTS where Depart = 'Drinks')),
		  ('Other drinks', (select Dep_Id from DEPARTMENTS where Depart = 'Drinks')),
		  ('Flour', (select Dep_Id from DEPARTMENTS where Depart = 'Grocery')),
		  ('Spices', (select Dep_Id from DEPARTMENTS where Depart = 'Grocery')),
		  ('Pasta', (select Dep_Id from DEPARTMENTS where Depart = 'Grocery')),
		  ('Groats and Legumes', (select Dep_Id from DEPARTMENTS where Depart = 'Grocery')),
		  ('Cereal', (select Dep_Id from DEPARTMENTS where Depart = 'Grocery')),
		  ('Vegetable oil', (select Dep_Id from DEPARTMENTS where Depart = 'Grocery')),
		  ('Sauces', (select Dep_Id from DEPARTMENTS where Depart = 'Grocery')),
		  ('Nuts, dried fruits', (select Dep_Id from DEPARTMENTS where Depart = 'Grocery')),
		  ('Canned products', (select Dep_Id from DEPARTMENTS where Depart = 'Grocery')),
		  ('Other grocery', (select Dep_Id from DEPARTMENTS where Depart = 'Grocery')),
		  ('Chocolate', (select Dep_Id from DEPARTMENTS where Depart = 'Sweets')),
		  ('Bars', (select Dep_Id from DEPARTMENTS where Depart = 'Sweets')),
		  ('Lollipops', (select Dep_Id from DEPARTMENTS where Depart = 'Sweets')),
		  ('Caramel', (select Dep_Id from DEPARTMENTS where Depart = 'Sweets')),
		  ('Candy', (select Dep_Id from DEPARTMENTS where Depart = 'Sweets')),
		  ('Marshmallows', (select Dep_Id from DEPARTMENTS where Depart = 'Sweets')),
		  ('Marmalade', (select Dep_Id from DEPARTMENTS where Depart = 'Sweets')),
		  ('Chewing gum', (select Dep_Id from DEPARTMENTS where Depart = 'Sweets')),
		  ('Other sweets', (select Dep_Id from DEPARTMENTS where Depart = 'Sweets')),
		  ('Porridge', (select Dep_Id from DEPARTMENTS where Depart = 'Child Food')),
		  ('Dry mixes', (select Dep_Id from DEPARTMENTS where Depart = 'Child Food')),
		  ('Juices', (select Dep_Id from DEPARTMENTS where Depart = 'Child Food')),
		  ('Fruit and vegetable purees', (select Dep_Id from DEPARTMENTS where Depart = 'Child Food')),
		  ('Canned meat', (select Dep_Id from DEPARTMENTS where Depart = 'Child Food')),
		  ('Canned fish, fish and vegetables', (select Dep_Id from DEPARTMENTS where Depart = 'Child Food')),
		  ('Water', (select Dep_Id from DEPARTMENTS where Depart = 'Child Food')),
		  ('Biscuit', (select Dep_Id from DEPARTMENTS where Depart = 'Child Food')),
		  ('Other child food', (select Dep_Id from DEPARTMENTS where Depart = 'Child Food')),
		  ('Toys', (select Dep_Id from DEPARTMENTS where Depart = 'For Children')),
		  ('Books', (select Dep_Id from DEPARTMENTS where Depart = 'For Children')),
		  ('Baby care', (select Dep_Id from DEPARTMENTS where Depart = 'For Children')),
		  ('Washing', (select Dep_Id from DEPARTMENTS where Depart = 'For Children')),
		  ('Feeding and care', (select Dep_Id from DEPARTMENTS where Depart = 'For Children')),
		  ('Other products for child', (select Dep_Id from DEPARTMENTS where Depart = 'For Children')),
		  ('Feed', (select Dep_Id from DEPARTMENTS where Depart = 'For Animals')),
		  ('Animal care', (select Dep_Id from DEPARTMENTS where Depart = 'For Animals')),
		  ('Other products for animals', (select Dep_Id from DEPARTMENTS where Depart = 'For Animals')),
		  ('Hygiene', (select Dep_Id from DEPARTMENTS where Depart = 'Cosmetics')),
		  ('Hair care', (select Dep_Id from DEPARTMENTS where Depart = 'Cosmetics')),
		  ('Hand and foot care', (select Dep_Id from DEPARTMENTS where Depart = 'Cosmetics')),
		  ('Face care', (select Dep_Id from DEPARTMENTS where Depart = 'Cosmetics')),
		  ('Body care', (select Dep_Id from DEPARTMENTS where Depart = 'Cosmetics')),
		  ('Other cosmetic', (select Dep_Id from DEPARTMENTS where Depart = 'Cosmetics')),
		  ('Interior', (select Dep_Id from DEPARTMENTS where Depart = 'For Home')),
		  ('Tableware', (select Dep_Id from DEPARTMENTS where Depart = 'For Home')),
		  ('Laundry Detergents', (select Dep_Id from DEPARTMENTS where Depart = 'For Home')),
		  ('For bathroom and toilet', (select Dep_Id from DEPARTMENTS where Depart = 'For Home')),
		  ('For kitchen', (select Dep_Id from DEPARTMENTS where Depart = 'For Home')),
		  ('For cleaning', (select Dep_Id from DEPARTMENTS where Depart = 'For Home')),
		  ('Goods for holiday', (select Dep_Id from DEPARTMENTS where Depart = 'For Home')),
		  ('Other products for home', (select Dep_Id from DEPARTMENTS where Depart = 'For Home')),
		  ('Seeds', (select Dep_Id from DEPARTMENTS where Depart = 'For Garden')),
		  ('Soils, fertilizers, pesticides', (select Dep_Id from DEPARTMENTS where Depart = 'For Garden')),
		  ('Other garden products', (select Dep_Id from DEPARTMENTS where Depart = 'For Garden')),
		  ('Paper products', (select Dep_Id from DEPARTMENTS where Depart = 'For Office')),
		  ('Stationery', (select Dep_Id from DEPARTMENTS where Depart = 'For Office')),
		  ('Products for child', (select Dep_Id from DEPARTMENTS where Depart = 'For Office')),
		  ('Goods for school', (select Dep_Id from DEPARTMENTS where Depart = 'For Office')),
		  ('Other office products', (select Dep_Id from DEPARTMENTS where Depart = 'For Office'));
--COMPLITED!!


----------User Type----------

Insert into USER_TYPE(Type_User, Sale_Size)
	values('Student_Schl', 0.02),
		  ('Student_Univ', 0.03),
		  ('Student_Coll', 0.01),
		  ('Default', 0.01),
		  ('Pensioner', 0.03),
		  ('Invalid', 0.03);
--COMPLITED!!


----------Store Type----------
Insert into TYPE_STORE(Type)
	values('HyperMarket'),
		  ('SupreMarket'),
		  ('MiniMarket'),
		  ('Department'),
		  ('Discount'),
		  ('GroserMarket');
--COMPLITED!!


----------Admin Type----------
Insert into TYPE_ADMIN(Admin_Type)
	values('Main'),
		  ('Admin_St'),
		  ('Cashier');
--COMPLITED!!

insert into EMPLOYEES(Name_First)
	values('Admin');

----------Standart admin account----------
Insert into STORE_ADMIN(Admin_Login, Admin_Pass, Admin_Type_Id, EMPL_Id)
	values('Admin', 'Admin', 1, 1);
--COMPLITED!!

