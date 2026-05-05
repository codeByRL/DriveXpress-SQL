--פונקציה סקלארית המחזירה מחיר יומי של רכב
-- בא לשימוש בתחזית מחיר ללקוח וחישוב
--התשלום בפעול וכן לטריגר לבדיקת תשלום נכון
create function dailyprice(@license_number int)
returns decimal(10,2)
as
begin
    declare @price decimal(10,2)

    select @price = (300*((AdditionalCost/100)+1)*(([ExtraPercentage]/100)+1))
    from dbo.cars c
    join dbo.qualitylevels q 
	on q.qualitylevelid = c.qualitylevelid
	join [dbo].[CarSizes] a
	on a.SizeID=c.SizeID
    where c.licensenumber = @license_number

    return round(@price, 2)
end
select dbo.dailyprice(435552433)as toPayDay