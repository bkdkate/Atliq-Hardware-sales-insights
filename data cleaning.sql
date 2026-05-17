select *
from transactions;

select distinct currency
from transactions;

-- 'INR' 'USD' 'INR\r' 'USD\r'

update transactions
set currency = replace(currency,'\r','');

select distinct currency
from transactions;

select *, row_number() over(partition by product_code, customer_code, market_code, order_date, sales_qty, sales_amount, currency) as row_num
from transactions;

with duplicate_cte as 
(
	select *, 
	row_number() over(
	partition by product_code, customer_code, market_code, order_date, sales_qty, sales_amount, currency) as row_num
	from transactions
)
select *
from duplicate_cte
where row_num > 1;

select *
from transactions
where product_code = 'Prod001' and customer_code = 'Cus001';

DROP TABLE IF EXISTS `transactions2`;
CREATE TABLE `transactions2` (
  `product_code` varchar(45) DEFAULT NULL,
  `customer_code` varchar(45) DEFAULT NULL,
  `market_code` varchar(45) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `sales_qty` int DEFAULT NULL,
  `sales_amount` double DEFAULT NULL,
  `currency` varchar(45) DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from transactions2;


insert into transactions2
select *, 
	row_number() over(
	partition by product_code, customer_code, market_code, order_date, sales_qty, sales_amount, currency) as row_num
from transactions;

delete 
from transactions2
where row_num > 1;


select *
from transactions2;


select *
from transactions2
where sales_qty <= 0;

select *
from transactions2
where sales_amount <= 0;


delete
from transactions2
where sales_amount <= 0;


alter table transactions2
drop column row_num;


select *
from transactions2;


select *
from markets;

delete 
from markets
where zone = '';