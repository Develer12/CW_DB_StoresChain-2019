use STORES_CHAIN

go
Create procedure Login
	@log nvarchar(13),
	@pass nvarchar(30)
AS
Begin
	Declare @password nvarchar(30);
	set @password = (select Admin_Pass from STORE_ADMIN where Admin_Login= @log);
	if @password = @pass
		select 1 as login;
	else 
		select 0 as login;
End;