SELECT order_id, total_amount, status, note, user_id,
    CASE 
        WHEN total_amount > 4000000 THEN 'Nguy hiem'
        ELSE 'Binh thuong'
    END as Alert_Level
FROM Orders
WHERE total_amount BETWEEN 2000000 and 5000000
  and status <> 'CANCELLED'
  and (note LIKE '%gap%' OR user_id IS NULL)
ORDER BY total_amount DESC
LIMIT 20 OFFSET 40;

-- pagesize = 20, page = 3 => (3-1)*20 = 40