--טריגר שמופעל כל יום בשע שמונה בערב ושולח מייל לכל ההשכרות שצפויות להסתיים מחר 
--בהודעה הלקוח מקבל תזכורת,סבר אודות התשלום
--ובקשה להוספת הערה בזמן מההחזרה
create procedure PremiumRentalHandler
as
begin
declare @EmailList varchar(max)
SELECT @EmailList = STRING_AGG(Email, ',')
FROM (
    SELECT DISTINCT Email
	from  [dbo].[Customers] c
	join [dbo].[Rentals] r
	on c.CustomerID=r.CustomerID
	where datediff(day,getdate(),r.EndDate)=1
	)as t
	if(@EmailList is not null)
	begin



	EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'RentalCompanyProfile',
    @recipients = @EmailList,
    @subject = 'Important Update',
    @body = 'Dear customer,
Your rental time is about to expire tomorrow,
Please return the vehicle to the branch where you received it no later than 10 pm.
When returning it, you must bring full payment,
We will be happy to receive complaints or comments from you upon return to improve the service.
Thank you for driving with driveXspress!!'
,
    @body_format = 'Text'
end

end
--------------הפעלת הפרוצדורה לשליחת המייל לתזכורת-------------
--------------כל יום בשמונה בערב מתבצע שליחת התזכורות לשוכרים שהשכרתם מסתיימת מחר-------------
waitfor time '20:00'
exec PremiumRentalHandler