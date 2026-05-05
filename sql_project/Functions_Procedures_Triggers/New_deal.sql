--עדכון עסקה חדשה
--כאשר הלקוח מזדהה כלקוח חדש ונשלחים לפונקציה פרטים אישיים תזין הפרוצדורה את פרטי הלקוח בטבלת הלקוחות
-- ואת פרטי העסקה בטבלת ההשכרות
-- כאשר הלקוח מזדהה כלקוח חוזר ונשלחים לפונקציה רק פרטי העסקה החדשה 
-- ומעודכנים רק פרטי העסקה בטבלת ההשכרות
alter PROCEDURE Newdeal
    @CustomerID INT,
    @FirstName NVARCHAR(100)=null,
    @LastName NVARCHAR(100)=null,
    @Address NVARCHAR(100)=null,
    @Phone NVARCHAR(20)=null,
    @Email NVARCHAR(100)=null,
    @RentalID SMALLINT,
    @LicenseNumber SMALLINT, 
    @EndDate DATE
AS
BEGIN
 

    IF NOT EXISTS (
        SELECT 1 FROM [dbo].[Customers] WHERE [CustomerID] = @CustomerID
    )
    BEGIN
        INSERT INTO [dbo].[Customers] ([CustomerID], [FirstName], [LastName], [Address], [Phone], [Email])
        VALUES (@CustomerID, @FirstName, @LastName, @Address, @Phone, @Email);
    END
	declare @StartDate date
	set @StartDate=getdate()
	

    INSERT INTO [dbo].[Rentals] ([RentalID], [CustomerID], [LicenseNumber],StartDate, [EndDate])
    VALUES (@RentalID, @CustomerID, @LicenseNumber,@StartDate, @EndDate);
END
--------------הפעלה----------------
exec Newdeal 12345,'rivka','lutzkin','beitar',0548463032,'s4106697@gmail.com', 12,12345,'2025-06-20'