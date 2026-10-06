-- inner join
select * from orders
join customers
on orders.customer_id = customers.customer_id;

select order_id,first_name,last_name,orders.customer_id
from orders
join customers on orders.customer_id = customers.customer_id;

select order_id, first_name, last_name, o.customer_id
from orders o
join customers c 
	on o.customer_id = c.customer_id;
    
select * from order_items oi
join products p
	on oi.product_id = p.product_id;
    
-- joining across data bases
select * from order_items oi
join  sql_inventory.products p
	on oi.product_id = p.product_id;
    
-- self join
use sql_hr;
select * from employees e
join employees m
	on e.reports_to = m.employee_id;
    
select 
	e.employee_id,
    e.first_name,
    m.first_name as manager
from employees e
join employees m
	on e.reports_to = m.employee_id;
 
-- joining multiple tables
use sql_store;    
select 
	o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    os.name as status
from orders o
join customers c
	on o.customer_id = c.customer_id
join order_statuses os
	on o.status = os.order_status_id
order by o.order_id;

use sql_invoicing;
select 
	p.date,
    p.invoice_id,
    p.amount,
	c.name as client_name,
	pm.name as payment_method
from payments p
join payment_methods pm
	on p.payment_method = pm.payment_method_id
join clients c
	on p.client_id = c.client_id;

-- compound join conditions
use sql_store;    
select * from order_items oi
join order_item_notes oin
	on oi.order_id = oin.order_id
    and oi.product_id = oin.product_id;
    
-- implicit join syntax
select * 
from orders o, customers c
where o.customer_id = c.customer_id;

-- outer joins
select 
	p.product_id,
    p.name,
    oi.quantity
from products p
left join order_items oi
	on p.product_id = oi.product_id;
    
-- outer join between muliple tables
select 
	c.customer_id,
    c.first_name,
    o.order_id,
	sh.name as shipper
from customers c
left join orders o
	on c.customer_id = o.customer_id
left join shippers sh
	on o.shipper_id = sh.shipper_id
order by c.customer_id;

select 
	o.order_id,
	o.order_date,
    c.first_name,
    sh.name as shipper,
    os.name as status
from  orders o
join customers c
	on c.customer_id = o.customer_id
left join shippers sh
	on o.shipper_id = sh.shipper_id
join order_statuses os
	on o.status = os.order_status_id
order by os.order_status_id, o.order_id;

-- self outer join
use sql_hr;
select 
	e.employee_id,
    e.first_name,
    m.first_name as manager
from employees e
left join employees m
	on e.reports_to = m.employee_id;
    
-- using clasue
use sql_store;
select
	o.order_id,
    c.first_name,
    sh.name as shipper
from orders o
join customers c
	using (customer_id)
join shippers sh
	using (shipper_id);
    
select * 
from order_items oi
join order_item_notes oin
	using (order_id, product_id);
 
use sql_invoicing;
select 
	p.date,
    c.name as client,
    p.amount,
    pm.name as payment_method
from payments p
join clients c
	using(client_id)
join payment_methods pm
	on p.payment_method = pm.payment_method_id;

-- natural join
use sql_store;
select * from orders o
natural join customers c;

-- cross join
select * from customers c
cross join products p;

select * from customers c, products p;

select * from shippers sh, products p
order by sh.name;

select * from shippers sh
cross join products p;

-- union
use sql_store;
select 
	customer_id,
    first_name,
    points,
    'Bronze' as Type
from customers
where points < 2000
union
select 
	customer_id,
    first_name,
    points,
    'Silver' as Type
from customers
where points between 2000 and 3000
union
select 
	customer_id,
    first_name,
    points,
    'Gold' as Type
from customers
where points > 3000
order by first_name;

-- inserting rows
insert into customers (first_name,last_name,birth_date,adress,city,state)
values ('John', 'Smith', '1990-01-01','address','city','CA');

insert into shippers(name)
values('shipper 1'),('shipper 2'),('shipper 3');

insert into products (name,quanitity_in_stock,unit_price)
values('Product 1',10, 1.54),('Product 2',11, 1.72),('Product 3',12, 1.95);

-- copying tables
use sql_invoicing;
create table invoices_archived as
select 
	i.invoice_id,
    i.number,
	c.name as client_name,
    i.invoice_total,
	i.payment_total,
    i.invoice_date,
    i.due_date, 
    i.payment_date
from invoices i
join clients c
	using (client_id)
where payment_date is not NULL;

-- updating multiple rows
use sql_store;
update customers
set 
	points = points+50
where birth_date<'1990-01-01';

-- using subqueries in updates
update orders
set
	comments = 'Gold Customer'
where customer_id in
				(select * 
                from customers 
				where points > 3000);
