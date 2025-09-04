SELECT employee_id, department_id
FROM (
    SELECT 
        employee_id,
        department_id,
        ROW_NUMBER() OVER (
            PARTITION BY employee_id
            ORDER BY 
                CASE WHEN primary_flag = 'Y' THEN 1 ELSE 2 END
        ) AS rn
    FROM Employee
) t
WHERE rn = 1;
