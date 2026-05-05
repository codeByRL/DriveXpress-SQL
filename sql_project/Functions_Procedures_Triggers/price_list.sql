-- מחירון ללקוח מתעניין או לפרסום מחירים כללי
-- הפונקציה תחזיר מחירון כללי של כל סוגי הרכבים על רמות האיכות השונות 
-- עבור הגודל שנבחר על ידי המשתמש
-- הפונקציה אינה בודקת זמינות אלא מהווה מחירון כללי
alter function price_list(@sizID smallint)returns table
as

return(select LicenseNumber,comp.Name,dbo.dailyprice(LicenseNumber)as Finalprice
from [dbo].[Cars] C 
join [dbo].[Companies] comp
on comp.CompanyID=C.CompanyID
join [dbo].[QualityLevels] q
on q.QualityLevelID=C.QualityLevelID
join [dbo].[CarSizes] z
on z.SizeID=C.SizeID
where z.SizeID=@sizID)
-------------------הפעלת הפונקציה להצגת מחירון פר גודל רכב-------------------
select * from price_list(2) ---------הצגת כל פרטי הרכבים מכל הסוגים והחברות שהם בגודל 2
