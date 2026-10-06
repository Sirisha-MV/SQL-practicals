use sql_hr;
select *,
sum(salary)
over (order by salary) as running_sum
from employees;

use sql_store;
select *, 
row_number()
over(partition by order_id) as rn
from order_items;

use sql_hr;
select *,
rank() over (order by salary) as emp_rank
from employees;

select *,
sum(salary) over ln as running_sum,
avg(salary) over ln as running_avg,
count(salary) over ln as running_count
from employees
window ln as (order by last_name);

select *,
lead(salary) over (order by last_name) as lead_sal,
lag(salary) over (order by last_name) as lag_sal
from employees;

select *,
ntile(3) over (order by last_name) as L
from employees;

select * from employees
where salary > (select avg(salary) from employees);

select *,
salary-(select avg(salary) from employees) as difference
 from employees;
 
 -- using subquery
 use sql_store;
 select product_id,name, total_qty
 from(select
		product_id,name,sum(quantity_in_stock) as total_qty
        from products
        group by product_id,name)p
where total_qty>50;

-- using CTE
with siri as
(
select
		product_id,name,sum(quantity_in_stock) as total_qty
        from products
        group by product_id,name)
(
select product_id,name, total_qty
from siri
where total_qty>50);

-- triggers
-- creating employee_audit table
use sql_hr;
create table employees_audit(
	emp_id int,
    action_type varchar(20),
    action_time datetime);

-- creating tirgger for employee audit table when ever we insert any new data in employees table
-- after insert trigger
Delimiter //
create trigger after_employee_insert
after insert on employees
for each row
begin
	insert into employees_audit (emp_id, action_type, action_time)
    values(new.employee_id, 'Insert', now());
    
end//
Delimiter ;

insert into employees values(99660, 'teja','raja ravi', 'ehs manager', 90000, 37270, 6);
select * from employees_audit;

-- before update trigger
delimiter //
create trigger before_salary_update
before update on employees
for each row
begin
	if new.salary < 30000 then
		set new.salary = 30000;
	end if;
end //
delimiter ;

update employees
set salary = 20000
where employee_id = 99660;

select * from employees;

-- after delete trigger
Delimiter //
create trigger after_employee_delete
after delete on employees
for each row
begin
	insert into employees_audit (emp_id, action_type, action_time)
    values(old.employee_id, 'Delete', now());
end//
Delimiter ;

delete from employees
where employee_id = 99660;

select * from employees_audit;

show triggers;

-- case statements

select *,
case
when salary <= 50000 then "Low Scale"
when salary > 50000 and salary<=100000 then "Medium Scale"
when salary > 100000 then "High Scale" 
end as comment
from employees

-- stored procedures
delimiter //
create procedure select_users()
begin
	select * from employees where salary>50000;
    select * from employees;
end //
delimiter ;

call select_users();

-- stored procedure with parameters
delimiter //
create procedure GetEmployeesBySalary(in min_salary int)
begin
	select * from employees
    where salary >= min_salary;
end //
delimiter ;

call GetEmployeesBySalary(95000);

-- stored procedures with multiple parameters;
delimiter //
create procedure GetEmployeesbyOfficeSalary(
	in emp_office int,
    in emp_salary int
)
begin
	select * from employees
    where office_id = emp_office
    and salary >= emp_salary; 
end //
delimiter ;

call GetEmployeesbyOfficeSalary(4,50000);

-- stored procedure with insert
delimiter //
create procedure AddEmployee(
	in employee_id int,
    in first_name varchar(50),
    in last_name varchar(50),
    in title varchar(50),
    in salary int,
    in reports_to int,
    in office_id int
)
begin
	insert into employees
    values(employee_id,first_name,last_name,title,salary,reports_to,office_id);
end //
delimiter ;

call AddEmployee(99660,'Teja','Rajaravi','EHS Manager',90000,37270,5);

call select_users();

-- stored procedure with update
delimiter //
create procedure UpdateSalary(
	in emp_id int,
    in new_salary int
)
begin
	update employees
    set salary = new_salary
    where employee_id = emp_id;
end //
delimiter ;

call UpdateSalary(99660,100000);

select * from employees where employee_id = 99660;

-- stored procedure with out parameter
delimiter //
create procedure GetEmployeeCount(out total int)
begin
	select count(*) into total
    from employees;
end //
delimiter ;

call GetEmployeeCount(@count);

select @count;

-- stored procedure with inout parameter
delimiter //
create procedure IncreaseSalary( inout sal int)
begin
	set sal = sal+5000;
end //
delimiter ;

set @salary = 50000;
call IncreaseSalary(@salary);
select @salary;





