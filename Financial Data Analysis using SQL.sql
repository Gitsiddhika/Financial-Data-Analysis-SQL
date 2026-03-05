use finance;

-- 1. Total Transaction Amount per Customer
select 
c.customer_id, c.customer_name, sum(t.amount) as total_transaction_amount 
from customers c
inner join accounts a 
on c.customer_id = a.customer_id 
inner join transactions t 
on t.account_id = a.account_id
group by c.customer_id, c.customer_name;

-- 2. City-Wise Total Transaction Amount
select 
c.city, sum(t.amount) as total_transaction 
from customers c 
inner join accounts a 
on c.customer_id = a.customer_id
inner join transactions t 
on t.account_id = a.account_id
group by c.city;

-- 3. Credit vs Debit Transaction Amount
select 
transaction_type, sum(amount) as transaction_amount 
from transactions
group by transaction_type;

-- 4. Customers Having More Than One Account
select 
c.customer_id, c.customer_name, count(a.account_id) as total_account
from customers c
inner join accounts a 
on a.customer_id = c.customer_id 
group by c.customer_id, c.customer_name
having total_account > 1;

-- 5. Average Transaction Amount per Account
select 
account_id, avg(amount) as avg_amount 
from transactions
group by account_id;

-- 6. Top 5 Highest Transactions
select * from transactions 
order by amount DESC 
limit 5;

-- 7. Monthly Transaction Amount Trend
select 
year(transaction_date) as year, month(transaction_date) as month, sum(amount) as transaction_amount 
from transactions
group by year(transaction_date), month(transaction_date)
order by year, month;

-- 8. Customers with Only Debit Transactions
select 
c.customer_id, c.customer_name, t.transaction_type 
from customers c 
inner join accounts a 
on c.customer_id = a.customer_id
inner join transactions t 
on a.account_id = t.account_id 
where transaction_type = 'Debit';

-- 9. Highest Transaction Amount per City
select 
c.city, max(t.amount) as highest_amount
from customers c 
inner join accounts a 
on a.customer_id = c.customeSr_id 
inner join transactions t 
on t.account_id = a.account_id 
group by c.city;

-- 10. Customers with Transactions in Last 30 Days
select distinct
c.customer_id, c.customer_name
from customers c
inner join accounts a on c.customer_id = a.customer_id
inner join transactions t on a.account_id = t.account_id
where t.transaction_date >= CURDATE() - INTERVAL 30 DAY;

-- 11. Total Balance by Account Type
select 
account_type, sum(balance) as total_balance 
from accounts
group by account_type;

-- 12. Customers Whose Average Transaction > Overall Average
select 
c.customer_id, c.customer_name, avg(t.amount)
from customers c
inner join accounts a 
on c.customer_id = a.customer_id 
inner join transactions t 
on t.account_id = a.account_id 
group by c.customer_id, c.customer_name 
having avg(t.amount) > (select avg(amount) from transactions);

-- 13. Number of Transactions per Customer
select 
c.customer_id, c.customer_name, count(t.transaction_id) as total_transactions 
from customers c 
inner join accounts a 
on c.customer_id = a.customer_id 
inner join transactions t 
on t.account_id = t.account_id 
group by c.customer_id, c.customer_name;

