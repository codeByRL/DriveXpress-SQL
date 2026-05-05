-- כאשר הלקוח מעוניין בסוג רכב מסוים במיידי
-- פונקיה המקבלת גודל רכב רצוי ורמת איכות רצויה ומחזיר טבלת הצעות ללקוח של רכבים פנויים ורכבים שיהיו פנויים למחרת 
create function Car_search(@sizID smallint,@QualityLevelID smallint)returns table
as 
return(
 with AvailableCars AS (
select LicenseNumber,comp.Name,300*((AdditionalCost/100)+1)*((SeatCount/100)+1) as Final_price
, 'free' AS AvailabilityStatus
from [dbo].[Cars] C 
join [dbo].[Companies] comp
on comp.CompanyID=C.CompanyID
join [dbo].[QualityLevels] q
on q.QualityLevelID=C.QualityLevelID
join [dbo].[CarSizes] z
on z.SizeID=C.SizeID
where z.SizeID=@sizID and C.QualityLevelID=@QualityLevelID and not exists (select 1 from [dbo].Rentals r where r.LicenseNumber=C.LicenseNumber)
),
returningtomorrow as (
    select 
        c.licensenumber,
        comp.name,
        300 * ((additionalcost / 100.0) + 1) * ((seatcount / 100.0) + 1) as final_price,
        ' will return tomorrow' as availabilitystatus
    from [dbo].[rentals] r
    join [dbo].[cars] c on r.licensenumber = c.licensenumber
    join [dbo].[companies] comp on comp.companyid = c.companyid
    join [dbo].[qualitylevels] q on q.qualitylevelid = c.qualitylevelid
    join [dbo].[carsizes] z on z.sizeid = c.sizeid
    where z.sizeid = @sizid 
      and c.qualitylevelid = @qualitylevelid
      and cast(r.[EndDate] as date) = cast(getdate() + 1 as date)
)


select * from availablecars
union
select * from returningtomorrow
)
----------------חיפוש רכבים ללקוח במיידי-------------------
select * from dbo.Car_search(1,1)




