-- Write your PostgreSQL query statement below
WITH total_buy_sell AS (
    SELECT
        stock_name,
        SUM(CASE WHEN operation = 'Buy' THEN price ELSE 0 END) As buy_price,
        SUM(CASE WHEN operation = 'Sell' THEN price ELSE 0 END) As Sell_price
    FROM stocks
    GROUP BY stock_name
)
SELECT
    stock_name,
    (sell_price - buy_price) AS capital_gain_loss
FROM total_buy_sell

-- Second solution
SELECT
    stock_name,
    SUM(CASE WHEN operation = 'Buy' THEN -price ELSE price END) AS capital_gain_loss
FROM stocks
GROUP BY stock_name