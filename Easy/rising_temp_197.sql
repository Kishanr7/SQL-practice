-- # FIRST Write your MySQL query statement below
SELECT 
    e1.id
FROM 
    weather e1, weather e2 
WHERE DATEDIFF(e1.recordDate, e2.recordDate) = 1
AND e1.temperature >  e2.temperature;

-- Second with lag 

SELECT 
    id
FROM 
    (SELECT 
        id,
        temperature,
        LAG(recordDate, 1) OVER (ORDER BY recordDate) AS prev_date,
        LAG(temperature, 1) OVER (ORDER BY recordDate) AS prev_temp
    FROM 
        weather) AS t
WHERE 
    temperature > prev_temp and recordDate = prev_date + INTERVAL 1 DAY;
