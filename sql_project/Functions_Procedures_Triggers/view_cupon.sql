 -- קופון הנחה ניתן אחת לחמש השכרות
-- זה נעשה שימוש גם במהלך התשלום wiew ב
--שליפת לקוחות הזכאים לקופון הנחה

ALTER VIEW CustomerCoupon AS
SELECT 
    CustomerID,
    COUNT(*) AS RentalCount,
    CASE 
        WHEN (COUNT(*) + 1) % 5 = 0 THEN 'Eligible on next rental'
        WHEN COUNT(*) % 5 = 0 THEN ' Eligible'
        ELSE ' not Eligible'
    END AS CouponStatus
FROM arcivRentals
GROUP BY CustomerID;

