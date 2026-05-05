--בדיקת תקינות על ערכי לקוח ועסקה
create trigger triggerOfNewDeal
on dbo.Rentals
after insert
begin
if(datediff(day,@EndDate,@StartDate)<1)
print 'Incorrect date, please update the transaction again correctly'
rollback
end