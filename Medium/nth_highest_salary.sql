CREATE OR REPLACE FUNCTION NthHighestSalary(N INT) RETURNS TABLE (Salary INT) AS $$
BEGIN
  RETURN QUERY (
    -- Write your PostgreSQL query statement below.
    SELECT DISTINCT ranked.salary
    FROM (
        SELECT e.salary, DENSE_RANK() OVER (ORDER BY e.salary DESC) as rnk
        FROM employee e
    ) ranked
    where ranked.rnk = N
  );
END;
$$ LANGUAGE plpgsql;