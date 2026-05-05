--- אחת לשנה מתבצעת ספירת מלאי
--לצורך בדיקה האם צריך לקנות רכבים חדשים
-- הפונקציה מחזירה טבלה בצורה של פיוואט את מספר הרכבים בגדלים השונים
create function getcarscountbysize()
returns table
as
return (
    with carcounts as (
        select sizeid
        from cars
    )
    select [1] as small, [2] as medium, [3] as large
    from carcounts
    pivot (
        count(sizeid)
        for sizeid in ([1], [2], [3])
    ) as pivottable
)
-------------ספירת המלאי בפועל מתבצעת---------------
select * from dbo.getcarscountbysize()

