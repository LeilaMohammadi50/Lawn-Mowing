USE [lawnproject]
GO

/****** Object:  StoredProcedure [dbo].[Set_Invoice]    Script Date: 11/22/2024 7:29:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Mohammadi
-- Create date: 2024-08-30
-- Description:	Set a new invoice
-- Example: 
-- =============================================
CREATE PROCEDURE [dbo].[Set_Invoice]
	@CustomersID   INT, 
	@AppointmentID INT, 
	@InvoiceDate   datetime, 
	@TotalAmount   decimal(10,2), 
	@Status NVARCHAR(50)

AS
BEGIN
	SET NOCOUNT ON;

    -- Cheking customer
	IF EXISTS (SELECT * FROM [dbo].Invoice
				WHERE [CustomersID] = @CustomersID AND [AppointmentID]=@AppointmentID AND [InvoiceDate]=@InvoiceDate AND [TotalAmount]=@TotalAmount AND [Status]=@Status)
	BEGIN 
		SELECT N'This is old record' AS InsertState, [CustomersID], [AppointmentID], [InvoiceDate], [TotalAmount], [Status]
		FROM [dbo].Invoice
		WHERE [CustomersID] = @CustomersID AND [AppointmentID]=@AppointmentID AND [InvoiceDate]=@InvoiceDate AND [TotalAmount]=@TotalAmount AND [Status]=@Status
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].Invoice
           ([CustomersID],[AppointmentID],[InvoiceDate],[TotalAmount],[Status])
		VALUES
           (@CustomersID,@AppointmentID,@InvoiceDate,@TotalAmount,@Status)

		SELECT N'Added new record successful' AS InsertState, [CustomersID], [AppointmentID], [InvoiceDate], [TotalAmount], [Status]
		FROM [dbo].Invoice
		WHERE [CustomersID] = @CustomersID AND [AppointmentID]=@AppointmentID AND [InvoiceDate]=@InvoiceDate AND [TotalAmount]=@TotalAmount AND [Status]=@Status
	END
END
GO


