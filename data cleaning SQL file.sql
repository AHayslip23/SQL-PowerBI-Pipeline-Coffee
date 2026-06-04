SELECT * FROM coffeesales;

--drop transaction_id column 
ALTER TABLE coffeesales
DROP COLUMN transaction_id;

--change data type for quantity to integer 
--set all values not numeric to null
UPDATE coffeesales
SET quantity = null
WHERE quantity IN ('UNKNOWN', 'ERROR', '[null]');

ALTER TABLE coffeesales 
ALTER COLUMN quantity TYPE INT using quantity::integer;

--price per unit
--set column data type to float
--turn error and unknown into float
UPDATE coffeesales
SET price_per_unit = null
WHERE price_per_unit IN ('UNKNOWN', 'ERROR', '[null]');

ALTER TABLE coffeesales 
ALTER COLUMN price_per_unit TYPE float using price_per_unit::float;

--total spent convert data type to float 
UPDATE coffeesales
SET total_spent = null
WHERE total_spent IN ('UNKNOWN', 'ERROR', '[null]');

ALTER TABLE coffeesales 
ALTER COLUMN total_spent TYPE float using total_spent::float;

--payment_method 
UPDATE coffeesales
SET payment_method = 'Unknown'
WHERE payment_method IN ('UNKNOWN', 'ERROR', '[null]');

UPDATE coffeesales
SET payment_method = 'Unknown'
WHERE payment_method is null;

--sort date time convetions with the transaction date column
UPDATE coffeesales
SET transaction_date = null
WHERE transaction_date IN ('UNKNOWN', 'ERROR', '[null]');

SELECT ROUND(AVG(CASE WHEN transaction_date IS NULL
THEN 100.0 ELSE 0.0 END), 2) AS null_percentage
FROM coffeesales;


DELETE FROM coffeesales
where transaction_date is null;

ALTER TABLE coffeesales
ALTER COLUMN transaction_date TYPE date using transaction_date::date;

--add new column for year as an integer value 
--add new column for month_year as a character 
ALTER TABLE coffeesales
ADD column year int,
ADD column month_year VARCHAR(50);

UPDATE coffeesales 
SET 
year = extract(year from transaction_date::TIMESTAMP),
month_year = TO_CHAR(transaction_date::TIMESTAMP, 'FMMonth YYYY');

--update data types for item, transaction_type and payment_method to varchar
ALTER table coffeesales
ALTER COLUMN item TYPE VARCHAR(10)  using item::VARCHAR(10),
ALTER COLUMN transaction_type TYPE VARCHAR(25) using transaction_type::VARCHAR(25),
ALTER COLUMN payment_method TYPE VARCHAR(25) using payment_method::VARCHAR(25),
ALTER COLUMN month_year TYPE VARCHAR(25) using month_year::VARCHAR(50);

UPDATE coffeesales
SET total_spent = price_per_unit * quantity
where total_spent is null;

UPDATE coffeesales 
SET quantity = total_spent / price_per_unit
WHERE quantity is null;

UPDATE coffeesales 
SET price_per_unit = total_spent / quantity 
WHERE price_per_unit is null;

