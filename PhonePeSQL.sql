CREATE DATABASE phonepe_db;
USE phonepe_db;

create table aggregated_transaction (
    state varchar(100),
    year int,
    quarter int,
    transaction_count bigint,
    transaction_amount bigint,
    transaction_type_Financial_Services int,
	transaction_type_Merchant_payments int,
	transaction_type_Others int,
    transaction_type_Peer_to_peer_payments int,
    transaction_type_Recharge_bill_payments int,
    avg_amount_per_transaction float,
    amount_scaled float,
    count_scaled float,
    principal_component_1 FLOAT,
    principal_component_2 FLOAT
);

-- Total transactions and total amount per year
  SELECT 
    year, 
    SUM(transaction_count) AS total_transactions,
    SUM(transaction_amount) AS total_amount
FROM aggregated_transaction
GROUP BY year
ORDER BY year;

-- Highest transaction amount state-wise (latest year only)
  SELECT 
    state, 
    SUM(transaction_amount) AS total_amount
FROM aggregated_transaction
WHERE year = (SELECT MAX(year) FROM aggregated_transaction)
GROUP BY state
ORDER BY total_amount DESC
LIMIT 10;

-- Year-on-Year growth in transaction count
  SELECT 
    year, 
    SUM(transaction_count) AS total_transactions,
    LAG(SUM(transaction_count)) OVER (ORDER BY year) AS previous_year_transactions,
    ROUND(
        (SUM(transaction_count) - LAG(SUM(transaction_count)) OVER (ORDER BY year)) * 100.0 
        / LAG(SUM(transaction_count)) OVER (ORDER BY year), 2
    ) AS yoy_growth_percentage
FROM aggregated_transaction
GROUP BY year;

-- Top 5 states with highest total transaction count
SELECT 
    state, 
    SUM(transaction_count) AS total_transactions
FROM aggregated_transaction
GROUP BY state
ORDER BY total_transactions DESC
LIMIT 5;

-- State-wise average amount per transaction
	SELECT 
		state,
		ROUND(SUM(transaction_amount) * 1.0 / SUM(transaction_count), 2) AS avg_amount
	FROM aggregated_transaction
	GROUP BY state
	ORDER BY avg_amount DESC;
    
-- Correlation Check with PCA Features
   SELECT
    (AVG(transaction_amount * principal_component_1) - AVG(transaction_amount) * AVG(principal_component_1)) /
    (STDDEV_POP(transaction_amount) * STDDEV_POP(principal_component_1)) AS corr_amt_pca1,

    (AVG(transaction_count * principal_component_2) - AVG(transaction_count) * AVG(principal_component_2)) /
    (STDDEV_POP(transaction_count) * STDDEV_POP(principal_component_2)) AS corr_cnt_pca2
FROM aggregated_transaction;


    

