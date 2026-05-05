SELECT name as Ten_Khach_Hang,
    CASE
        WHEN total_orders IS NULL THEN 'Chua co don'
        WHEN total_orders > 500 THEN 'Kim Cuong'
        WHEN total_orders BETWEEN 100 and 500 THEN 'Vang'
        WHEN total_orders < 100 THEN 'Bac'
    END as Xep_Hang
FROM Users;