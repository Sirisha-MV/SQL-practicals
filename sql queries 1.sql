use sql_store;
select * from customers order by first_name;

select first_name, last_name from customers;

select
	last_name, 
	first_name, 
    points,
    (points+10) * 100 as 'discount factor'
from customers;

select distinct state from customers;

select 
	name,
    unit_price,
    unit_price*1.1 as 'new price'
from products;

select * from customers where points >3000;

select * from customers where state ='VA';

select * from customers where birth_date > '1990-01-01';

select * from orders where order_date >= '2026-01-01';

select * from customers
where birth_date>'1990-01-01' and points >1000;

select * from customers 
where birth_date>'1990-01-01' or points >1000;

select * from customers
where birth_date > '1990-01-01' or (points > 1000 and state = 'VA');

select * from customers
where not (birth_date > '1990-01-01' or points>1000);

select * from order_items
where order_id = 6 and unit_price * quantity > 30;

select * from customers
where state = 'VA' or state ='GA' or state = 'FL';

select * from customers
where state in ('VA','FL','GA');

select * from customers
where state not in ('VA','FL','GA');

select * from products
where quantity_in_stock in (49 ,38 ,72);

select * from customers
where birth_date between '1990-01-01' and '2000-01-01';

select * from customers
where last_name like '%y';

select * from customers
where last_name like 'b____y';

select * from customers
where address like '%trail' or address like '%avenue';

select * from customers
where phone like '%9';

select * from customers where last_name regexp'field';

select * from customers where last_name regexp '^field|mac|rose';

select * from customers where last_name regexp '[gim]e';

select * from customers where last_name regexp 'e[gim]';

select * from customers where last_name regexp '[a-h]e';

select * from customers where first_name regexp 'elka|ambur';
select * from customers where last_name regexp 'ey$|on$';
select * from customers where last_name regexp '^my|se';
select * from customers where last_name regexp 'b[ru]';

select * from customers where phone is null;

select * from customers where phone is not null;

select * from orders where shipper_id is null;

select * from customers order by first_name;
select * from customers order by first_name desc;

select * from customers order by state, first_name;

select first_name, last_name from customers order by birth_date;

select first_name, last_name, 10 as points from customers order by points, first_name;

select * from order_items
where order_id =2
order by quantity * unit_price desc;

select *, quantity * unit_price as total_price from order_items
where order_id =2
order by quantity * unit_price desc;

select * from customers limit 3;
select * from customers limit 6,3;

select * from customers
order by points desc
limit 3;