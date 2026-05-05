-- כאשר הלקוח מסוים מעוניין ברכב מסוים
-- הפונקציה מקבלת מספר רישוי של רכב ומספר ימי שכירות וכן מספר לקוח לצורך בדיקת זכאות לקופון ובודקת האם הרכב זמין
-- אם הרכב זמין היא מחזירה את העלות  שלה
-- נעשה שימוש בחיפוש זכאות לקופון
--זה מורכב מעט כי הזכאות היא אחת לחמש השכרות אבל פה עליי לבדוק האם הפעם הבאה הוא יהיה זכאי כי מדובר 
--בהצעובהצעתת מחיר בלבד ולא תשלום אחרי ביצוע עסקה
-- במידה והרכ בלא זמין, היא מדפיסה הודעה על אי זמינות
create procedure carIsInpoundNaw_(@num int,@days int,@id int)
as
begin
declare @sum decimal(10,2)
declare @st varchar (30)
select @st= CouponStatus from CustomerCoupon where CustomerID=@id
if (@st='Eligible on next rental')
set @days=@days-1
if not exists(select 1 from [dbo].[Rentals] where [LicenseNumber]=@num)
begin
 set @sum=@days*dbo.dailyprice(@num) 
select @sum as price
end
else
begin
 select 'The car is not available' as message
end
end
-----------------הפעלת חישוב על רכב מסוים ובדיקת זמינותו---------------------
exec carIsInpoundNaw_ 1324435,2,1225