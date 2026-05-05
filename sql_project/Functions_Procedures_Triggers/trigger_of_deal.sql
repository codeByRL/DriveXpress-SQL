--בדרך כלל לפני ההזמנה נערך בירור האם הרכב זמין להשכרה או שהוא מושכר כרגע
--  אבל זמינות הרכב לא תלויה רק בהחזרתו לסניף לאחר ההשכרה האחרונה
-- לעיתים הרכב חוזר עם נזקים ובלאי  הדורשים  תיקון בן מספר ימים בהתאם לנזק שנגרם לו
-- טריגר זה בודק האם הרכב עליו מבצעים עסקה אכן זמין וגם אם הוא אכן מוכן להשכרה חוזרת
-- בהתאם למצב בו הוא חזר מהשכרתו האחרונה
create trigger trigger_OfNewDeal
on dbo.Rentals
after insert
as
begin
if exists (select [LicenseNumber] from [dbo].[Rentals] where [LicenseNumber]=(select [LicenseNumber]from inserted)
and RentalID NOT IN (select RentalID from inserted))
begin
RAISERROR(
  'RENTAL BLOCKED: This vehicle is currently in use and cannot be rented again until it is returned.',
  16, 1
)
rollback
end
else
begin
declare @d date, @c int
select top 1 @d=a.[EndDate] ,@c=r.[ConditionID]
from [dbo].[arcivRentals] a
join [dbo].[ReturnQualityCheck] r
on a.[RentalID]=r.[RentalID]
where a.[LicenseNumber]=(select [LicenseNumber] from inserted )
order by a.[EndDate] desc
declare @days int
set @days = 
    case @c
        WHEN 2 THEN 2
        WHEN 3 THEN 5 
        WHEN 4 THEN 10 
        ELSE 0         
    end 
	if datediff(day,getdate(),@d)<@days
	begin
	declare @s int
	set @s = @days- datediff(day, @d, getdate())
	RAISERROR(
  'RENTAL BLOCKED: The vehicle is still under maintenance. It will be available again in %d day(s).',
  16, 1, @s)
  rollback
  end
  end
  end






















