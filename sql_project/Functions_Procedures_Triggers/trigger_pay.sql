-- לאחר תשלום וסיום עסקה, בדיקת תקינות וקופון הנחה
--אחת ל5 השכרות זכאי הלקוח  ליום השכרה חינם
--  יוכל הטריגר לבדוק האם הלקוח זכאי לקופון  "CustomerCoupon" weiw  על ידי ה
-- מחשב על פי זה את הסכום לפי ימים בצורה מדויקת כולל אגורות
-- המחשבת מחיר יומי לרכב לפי מזהה רכבdaily_priceנעזר בפונקציה
-- בודק האם הסכום שהוזן בטבלה תואם לסכום שחושב
-- בודק האם מצב הרכב נרשם בטבלת הבקרה
-- אם הכול תקין מועברים כל פרטי העסקה לטבלת הארכיון
-- כך שבטבלת ההשכרות יהיו רק השכרות פעילות

--SELECT * INTO arcivRentals
--FROM [dbo].[Rentals]
--WHERE 1 = 0

CREATE TRIGGER to__arciv
ON dbo.Rentals
AFTER  update
as
begin
DECLARE @sum decimal(10,2)
declare @days smallint
select @days=datediff(day,[StartDate],[EndDate])from inserted
if exists (
  select 1 
  from CustomerCoupon 
  where CustomerID = (SELECT CustomerID FROM inserted)
)
begin
  set @days = @days - 1
  print 'You earned a coupon! One rental day is free this time!'
end
declare @numCar int
select @numCar= [LicenseNumber]from inserted
 set @sum=@days* dbo.daily_price(@numCar)
set @sum=round(@sum,2)
if ( not exists(select 1 from dbo.ReturnQualityCheck where  RentalID=(select RentalID from inserted)))
begin
print'It is not possible to calculate the amount to be paid without updating the status in which the vehicle was returned in the control table. Please update the control table for optimal calculation!'
rollback
return
end
if ((select PaymentAmount from inserted)!=@sum)
begin
print 'The amount entered does not match the transaction cost, the correct amount is' +CAST(@sum AS varchar)
rollback
return
end
insert into arcivRentals(RentalID,CustomerID,LicenseNumber,PaymentAmount,StartDate,EndDate,Note)
select [RentalID],[CustomerID],[LicenseNumber],[PaymentAmount],[StartDate],[EndDate],[Note]
from [dbo].[Rentals]
WHERE RentalID =(select RentalID from inserted)
delete from [dbo].[Rentals] where RentalID=(select RentalID from inserted)
end