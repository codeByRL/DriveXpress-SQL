-- תשלום וסיום עסקה
-- לאחר שהלקוח משלם והרכב עובר בקרת איכות החזרה
-- מעודכן הסכום ששולם בטבלת ההשכרות
-- ומצב ההחזרה מעודכן בטבלת בקרת החזרה
go
ALTER PROCEDURE CompleteDeal (
    @sum decimal(10,2),
    @QualityLevelID smallint,
    @CustomerID smallint,
    @n varchar(255)
)
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @RentalID smallint
    SELECT  @RentalID = RentalID 
    FROM dbo.Rentals 
    WHERE CustomerID = @CustomerID;

    IF @RentalID IS NULL
    BEGIN
        PRINT 'No active rental found for this customer.';
        RETURN;
    END
    IF NOT EXISTS (
        SELECT 1 FROM dbo.ReturnQualityCheck WHERE RentalID = @RentalID
    )
    BEGIN
        INSERT INTO dbo.ReturnQualityCheck(RentalID, ConditionID)
        VALUES (@RentalID, @QualityLevelID);
    END
    ELSE
    BEGIN
        
        UPDATE dbo.ReturnQualityCheck
        SET ConditionID = @QualityLevelID
        WHERE RentalID = @RentalID;
    END

   
    UPDATE dbo.Rentals
    SET PaymentAmount = @sum,
        Note = @n
    WHERE RentalID = @RentalID;
END
------------סיום עסקה------------------
exec CompleteDeal 600,1,322,'very good!'





















