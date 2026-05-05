-- סקר שביעות רצון
--כאשר לקוח צפוי להחזיר רכב הוא מקבל על כך תזכורת במייל ושם הוא מתבקש לציין בהחזרתו את ההערותיו
-- התוצאות יוצגו לפי הפרמטר שנשלח 
-- אם נשלחה הספרה 0 ישלפו כל ההערות שאינן תלונות
-- אם נשלחה הספרה 1 ישלפו כל ההערות המכילות תלונות
-- אם נשלחה הספרה 2 יחזרו כל ההערות הריקות לצורך יצירת קשר לסקר טלפוני
alter function getNotesByType (@type int)
returns table
as
return
    select 
	[RentalID], [Note],[Phone]
    from [dbo].[arcivRentals] a
	join [dbo].[Customers] c
	on c.CustomerID=a.CustomerID
    where
	      
        (@type = 1 and [Note] like '%תלונה%')
        or
        (@type = 0 and ([Note] not like '%תלונה%'))
		or
		(@type = 2 and ([Note] is null))


		-----------------שימוש בפונקציית בקרת שביעות רצון---------------------------
	--	select * from dbo.getnotesbytype(1) רוצה לראות את כל התלונות
		--	select * from dbo.getnotesbytype(0)  רוצה לראות את כל התודות או הערות שאינן תלונות
			--	select * from dbo.getnotesbytype(2)רוצה לראות מי הם הלקוחות שיש להם השכרה ללא הערה כלל בכדי לשאול אותם לדעתם  
	---
