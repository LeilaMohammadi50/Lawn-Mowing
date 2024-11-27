USE [lawnproject]
GO

/****** Object:  StoredProcedure [dbo].[Set_Appointment]    Script Date: 11/22/2024 7:31:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Mohammadi
-- Create date: 2024-09-11
-- Description:	Set a new appointment
-- Example: 
-- =============================================
CREATE PROCEDURE [dbo].[Set_Appointment]
	@CustomersID		int, 
	@ServiceProviderID  int, 
	@Appointmentdate    date, 
	@AppointmentTime    time, 
	@Status		 NVARCHAR(50)

AS
BEGIN
	SET NOCOUNT ON;

    -- Cheking customer
	IF EXISTS (SELECT * FROM [dbo].Appointments
				WHERE [CustomersID] = @CustomersID AND [ServiceProviderID]=@ServiceProviderID AND [Appointmentdate]=@Appointmentdate AND [AppointmentTime]=@AppointmentTime AND Status = @Status)
	BEGIN 
		SELECT N'This is old record' AS InsertState, [CustomersID], [ServiceProviderID], [Appointmentdate], [AppointmentTime],CreatedDate
		FROM [dbo].Appointments
		WHERE [CustomersID] = @CustomersID AND [ServiceProviderID]=@ServiceProviderID AND [Appointmentdate]=@Appointmentdate AND [AppointmentTime]=@AppointmentTime AND Status = @Status
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].Appointments
           ([CustomersID]
           ,[ServiceProviderID]
           ,[Appointmentdate]
           ,[AppointmentTime]
		   ,[Status]
           )
		VALUES
           (@CustomersID,@ServiceProviderID,@Appointmentdate,@AppointmentTime,@Status)

		SELECT N'Added new record successful' AS InsertState, [CustomersID], [ServiceProviderID], [Appointmentdate], [AppointmentTime],CreatedDate,Status
		FROM [dbo].Appointments
		WHERE [CustomersID] = @CustomersID AND [ServiceProviderID]=@ServiceProviderID AND [Appointmentdate]=@Appointmentdate AND [AppointmentTime]=@AppointmentTime AND Status=@Status
	END
END
GO


