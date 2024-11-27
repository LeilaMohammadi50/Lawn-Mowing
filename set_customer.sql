USE [lawnproject]
GO

/****** Object:  StoredProcedure [dbo].[Set_Customer]    Script Date: 11/22/2024 7:30:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Mohammadi
-- Create date: 2024-08-11
-- Description:	Set a new customer
-- Example: EXEC [dbo].[Set_Customer] @Firstname = N'Ali', @Middlename = N'Syed', @Lastname = N'Amiri', @Email = N'Ali.Amiri@gmail.com', @Phonenumber = N'+989121212123'
-- =============================================
CREATE PROCEDURE [dbo].[Set_Customer]
	@Firstname   NVARCHAR(50), 
	@Middlename  NVARCHAR(50), 
	@Lastname    NVARCHAR(50), 
	@Email       NVARCHAR(50), 
	@Phonenumber NVARCHAR(50)

AS
BEGIN
	SET NOCOUNT ON;

    -- Cheking customer
	IF EXISTS (SELECT * FROM [dbo].[Customers]
				WHERE [Firstname] = @Firstname AND [Middlename]=@Middlename AND [Lastname]=@Lastname AND [Email]=@Email AND [Phonenumber]=@Phonenumber)
	BEGIN 
		SELECT N'This is old record' AS InsertState, [Firstname], [Middlename], [Lastname], [Email], [Phonenumber]
		FROM [dbo].[Customers]
		WHERE [Firstname] = @Firstname AND [Middlename]=@Middlename AND [Lastname]=@Lastname AND [Email]=@Email AND [Phonenumber]=@Phonenumber
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[Customers]
           ([Firstname]
           ,[Middlename]
           ,[Lastname]
           ,[Email]
           ,[Phonenumber])
		VALUES
           (@Firstname,@Middlename,@Lastname,@Email,@Phonenumber)

		SELECT N'Added new record successful' AS InsertState, [Firstname], [Middlename], [Lastname], [Email], [Phonenumber]
		FROM [dbo].[Customers]
		WHERE [Firstname] = @Firstname AND [Middlename]=@Middlename AND [Lastname]=@Lastname AND [Email]=@Email AND [Phonenumber]=@Phonenumber
	END
END
GO


