SELECT DISTINCT num
FROM (
    SELECT 
        num,
        LAG(num, 1) OVER (ORDER BY id) as prev_num,
        LAG(num, 2) OVER (ORDER BY id) as prev_num2
FROM numbers
) t

WHERE num = prev_num and num = prev_num2;