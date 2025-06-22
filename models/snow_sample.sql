

WITH order_list AS (         
    SELECT
        o_custkey  AS customer_id,
        SUM(o_totalprice) AS item_price,
        MIN(o_orderdate)  AS initial_order_date,
        MAX(o_orderdate)  AS last_order_date,
        MIN(o_clerk)     AS clerk_id
    FROM tpch_sf1.orders
    GROUP BY o_custkey
),
customer_list AS (          
    SELECT
        c_custkey AS customer_id,
        c_name  AS customer_name,
        c_address AS customer_address,
        c_phone AS customer_phone,
        c_acctbal  AS customer_account_balance,
        c_comment AS customer_feedback
    FROM tpch_sf1.customer
),
customer_index AS (
    SELECT
        c.customer_id,
        c.customer_name,
        (o.item_price + c.customer_account_balance) AS total_payment,
        o.item_price,
        c.customer_account_balance,
        o.clerk_id,
        o.initial_order_date,
        o.last_order_date,
        c.customer_address,
        c.customer_phone,
        c.customer_feedback
    FROM customer_list  c
    LEFT JOIN order_list o
           ON c.customer_id = o.customer_id
)
SELECT * FROM customer_index LIMIT 50;