-- אחת לתקופה מתבצעים פעולות שימור על הרכבים בחברה
-- שימור המכוניות יופעל בסדר הבא
-- מעל 10 השכרות עבור רכב מאיכות נמוכה מחייבת בדיקה וטיפול  במנוע החלש
-- במצבים אחרים שבהם הרמה טובה יותר הסדר הוא כך
-- בין 5 ל 3 השכרות עובר הרכב בדיקה בלבד
-- בין 6 ל 30 השכרות עובר הרכב שיקום חיצוני
-- מעל 30 השכרות עובר הרכב חידוש כללי
alter procedure processCarMaintenance
as
begin
declare @carid int, @rentalcount int, @qualitylevel int

declare car_cursor cursor for
select c.[LicenseNumber], count(r.[RentalID]) as rentalcount, c.[QualityLevelID]
from [dbo].[arcivRentals] r
join cars c on r.[LicenseNumber] = c.[LicenseNumber]
group by c.[LicenseNumber], c.[QualityLevelID]

open car_cursor
fetch next from car_cursor into @carid, @rentalcount, @qualitylevel

while @@fetch_status = 0
begin
    if @qualitylevel = 1 and @rentalcount > 10
            print 'car ' + cast(@carid as varchar) + ' requires urgent engine maintenance - low quality and over 10 rentals'
        else if @rentalcount between 3 and 5
            print 'car ' + cast(@carid as varchar) + ' requires a periodic check-up'
        else if @rentalcount between 6 and 30
            print 'car ' + cast(@carid as varchar) + ' requires external renovation'
        else if @rentalcount > 30
            print 'car ' + cast(@carid as varchar) + ' requires full upgrade/renewal'
    
    fetch next from car_cursor into @carid, @rentalcount, @qualitylevel
end

close car_cursor
deallocate car_cursor
end
-----------------רשימת התיקונים הדרושים לכל רכב----------------
exec processCarMaintenance



