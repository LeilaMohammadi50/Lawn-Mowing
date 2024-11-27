USE [lawnproject]
GO

/****** Object:  StoredProcedure [dbo].[Set_Address]    Script Date: 11/22/2024 7:32:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Set_Address]
	-- Add the parameters for the stored procedure here
	@CustomersID int,
	@Housenumber nvarchar(100),
	@Street		 nvarchar(100),
	@City		 nvarchar(100), 
	@State		 nvarchar(100), 
	@ZipCode	 nvarchar(100)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Parameter validation
	IF NOT EXISTS (	SELECT * FROM Addresses
					WHERE [CustomersID]= @CustomersID AND 
						  [Housenumber]= @Housenumber AND
						  [Street]=@Street AND
						  [City]=@City AND
						  [State]=@State AND
						  [ZipCode]=@ZipCode)
	BEGIN
		-- Insert statements for procedure here
		INSERT INTO Addresses ( [CustomersID], [Housenumber], [Street], [City], [State], [ZipCode] )
		VALUES(@CustomersID,@Housenumber,@Street,@City,@State,	@ZipCode)

	SELECT N'Added new record successful' AS InsertState, [CustomersID], [Housenumber], [Street], [City], [State], [ZipCode] FROM Addresses
	WHERE [CustomersID]= @CustomersID AND 
		  [Housenumber]= @Housenumber AND
		  [Street]=@Street AND
		  [City]=@City AND
		  [State]=@State AND
		  [ZipCode]=@ZipCode
	END
	ELSE
	BEGIN
		SELECT N'This is old record' AS InsertState, [CustomersID], [Housenumber], [Street], [City], [State], [ZipCode] FROM Addresses
		WHERE [CustomersID]= @CustomersID AND 
			  [Housenumber]= @Housenumber AND
			  [Street]=@Street AND
			  [City]=@City AND
			  [State]=@State AND
			  [ZipCode]=@ZipCode
	END
	
END
GO


