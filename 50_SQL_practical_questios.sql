use sql_hr;
create table worker(
	WORKER_ID int not null primary key,
    FIRST_NAME	varchar(35),
    LAST_NAME varchar(35),
    SALARY int,
    JOINING_DATE datetime,
    DEPARTMENT varchar(35)
);

insert into worker(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT)
values 
	(1, 'Monika', 'Arora', 100000, '2021-02-20 09:00:00', 'HR'),
    (2, 'Niharika', 'Verma', 80000, '2021-06-11 09:00:00', 'Admin'),
    (3, 'Vishal', 'Singhal', 300000, '2021-02-20 09:00:00', 'HR'),
    (4, 'Amitabh', 'Singh', 500000, '2021-02-20 09:00:00', 'Admin'),
    (5, 'Vivek', 'Bhati', 500000, '2021-06-11 09:00:00', 'Admin'),
    (6, 'Vipul', 'Diwan', 200000, '2021-06-11 09:00:00', 'Account'),
    (7, 'Satish', 'Kumar', 75000, '2021-01-20 09:00:00', 'Account'),
    (8, 'Geetika', 'Chauhan', 90000, '2021-04-11 09:00:00', 'Admin');
    
select * from worker;

CREATE TABLE Bonus (
    WORKER_REF_ID INT,
    BONUS_AMOUNT INT,
    BONUS_DATE DATETIME,
    FOREIGN KEY (WORKER_REF_ID) REFERENCES Worker(WORKER_ID) ON DELETE CASCADE
);

INSERT INTO Bonus (WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) 
VALUES
    (1, 5000, '2023-02-20'),
    (2, 3000, '2023-06-11'),
    (3, 4000, '2023-02-20'),
    (1, 4500, '2023-02-20'),
    (2, 3500, '2023-06-11');

CREATE TABLE Title (
    WORKER_REF_ID INT,
    WORKER_TITLE CHAR(25),
    AFFECTED_FROM DATETIME,
    FOREIGN KEY (WORKER_REF_ID) REFERENCES Worker(WORKER_ID) ON DELETE CASCADE
);

INSERT INTO Title (WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
    (1, 'Manager', '2023-02-20 00:00:00'),
    (2, 'Executive', '2023-06-11 00:00:00'),
    (8, 'Executive', '2023-06-11 00:00:00'),
    (5, 'Manager', '2023-06-11 00:00:00'),
    (4, 'Asst. Manager', '2023-06-11 00:00:00'),
    (7, 'Executive', '2023-06-11 00:00:00'),
    (6, 'Lead', '2023-06-11 00:00:00'),
    (3, 'Lead', '2023-06-11 00:00:00');
    
    
-- 1. Write SQL Query to Display FIRST_NAME with Alias WORKER_NAME.
select 
	WORKER_ID, 
    FIRST_NAME as Worker_name, 
    LAST_NAME, 
    SALARY, 
    JOINING_DATE, 
    DEPARTMENT
from worker;

-- 2. Write SQL Query to Display FIRST_NAME in Upper Case from the Worker Table.
select upper(FIRST_NAME) from worker;

-- 3. Write SQL Query to Display Unique DEPARTMENT Values from the Worker Table.
select distinct DEPARTMENT from worker;

-- 4. Write SQL Query to Display the First 3 Chars of FIRST_NAME from the Worker Table.
select substring(first_name,1,3) from worker;

-- 5. Write SQL Query to Find the Position of Alphabet ‘a’ in the FIRST_NAME Column.
select 
	*, 
	INSTR(FIRST_NAME, 'a') as position_of_A 
FROM Worker;

-- 6. Write SQL Query to Fetch FIRST_NAME from the Worker Table With No White Spaces on the Right.
select RTRIM(first_name) from worker;

-- 7. Write SQL Query to List DEPARTMENT from the Worker Table With No White Spaces on the Left.
select LTRIM(Department) from worker;

-- 8. Write SQL Query to Display Unique DEPARTMENT Values and Their Lengths from the Worker Table.
select distinct department, length(department) as Length from worker;

-- 9. Write SQL Query to Replace ‘a’ with ‘A’ in FIRST_NAME from the Worker Table.
select replace(first_name,'a','A') from worker;

-- 10. Write SQL Query to Combine FIRST_NAME and LAST_NAME into COMPLETE_NAME.
select concat(first_name," ",last_name) as complete_name from worker;

-- 11,12. Write SQL Query to Print Worker Details Ordered by FIRST_NAME Ascending and DEPARTMENT Descending.
select * from worker
order by first_name, department desc;

-- 13. Write SQL Query to Print Worker Details with First Names “Vipul” and “Satish”.
select * from worker
where first_name in ('Vipul','Satish');

-- 14. Write SQL Query to Print Worker Details Excluding First Names (“Vipul” and “Satish”).
select * from worker
where first_name not in ('Vipul','Satish');

-- 15. Write SQL Query to Print Worker Details with DEPARTMENT Name as “Admin”.
select * from worker
where department = 'Admin';

-- 16. Write SQL Query to Print Worker Details Whose FIRST_NAME Contains ‘a’.
select * from worker
where first_name like '%a%';

-- 17. Write SQL Query to List Worker Info Whose FIRST_NAME Ends with ‘a’.
select * from worker
where first_name like '%a';

-- 18. Write SQL Query to Fetch Workers Whose FIRST_NAME Ends with ‘h’ and Has 6 Letters.
select * from worker
where first_name like '_____h';

-- 19. Write SQL Query to Show Worker Info Whose SALARY is Between 100000 & 500000.
select * from worker
where salary between 100000 and 500000;

-- 20. Write SQL Query to Display Workers Who Joined in Feb 2021.
select * from worker
where joining_date between '2021-02-01' and '2021-03-01';

-- 21. Write SQL Query to Print Employee Count in ‘Admin’ Department.
select count(*) from worker
where department = 'Admin';

-- 22. Write SQL Query to Fetch Worker Names with Salaries >= 50000 and <= 100000.
select * from worker
where salary between 50000 and 100000;

-- 23. Write SQL Query to List Worker Count Per Department in Descending Order.
select department, count(worker_id) as no_of_workers from worker
group by DEPARTMENT 
order by no_of_workers desc;

-- 24. Write SQL Query to Print Worker Details Who Are Also Managers.
select * from worker w
join title t
	on w.worker_id = t.WORKER_REF_ID
where WORKER_TITLE = 'Manager';

-- 25. Write SQL Query to Fetch Duplicate Records with Matching Data in Specific Fields of a Table.
select worker_title, AFFECTED_FROM, count(*) from title
group by worker_title, AFFECTED_FROM having count(*)>1;

-- 26. Write SQL Query to Show Only Odd Rows from a Table.
select * from worker
where mod(worker_id,2)=1;

-- 27. Write SQL Query to Show Only Even Rows from a Table
select * from worker
where worker_id%2 = 0;

-- 28. Write SQL Query to Clone a New Table from Another Table.
create table worker_clone as
select * from worker;

-- 29. Write SQL Query to Display Intersecting Records of Two Tables.
SELECT * FROM Worker
INTERSECT 
SELECT * FROM Worker_clone;

-- 30. Write SQL Query to Show Records from One Table That Are Not Present in Another Table.
SELECT * FROM Worker
Except 
SELECT * FROM Worker_clone;

-- 31. Write SQL Query to Show the Current Date and Time.
select current_timestamp();

-- 32. Write SQL Query to Show the Top n (say 10) Records of a Table.
select * from worker
order by salary desc
limit 10;

-- 33. Write SQL Query to Determine the Nth (say n=5) Highest Salary.
select distinct salary, department from worker
order by salary desc
limit 4,1;

-- 34. Write SQL Query to Determine 5th Highest Salary Without Using TOP or Limit.
select * 
from worker w1
where 4 = (select count(distinct (w2.salary)) from worker w2
					where w2.salary >= w1.salary);
                    
select * from worker
order by salary desc
limit 4,1;

-- 35. Write SQL Query to Fetch the List of Employees with the Same Salary.
select * from worker w1
join worker w2
	on w1.salary = w2.salary and w1.worker_id != w2.worker_id;
    
-- 36. Write SQL Query to List the Employee with the Second-Highest Salary.
select max(salary) from worker
where salary not in (select max(salary) from worker);

-- 37. Write SQL Query to Display One Row Twice in the Results from a Table. 
-- union all gives twice where as union just joins but doesnt give twice
select * from worker w1
where w1.department = 'HR'
union all
select * from worker w2
where w2.department = 'HR';

-- 38. Write SQL Query to Fetch Intersecting Records of Two Tables.
select * from worker
intersect
select * from worker_clone;

select * from worker w
join worker_clone wc
	on w.worker_id = wc.worker_id;
    
    
-- 39. Write SQL Query to Fetch the First 50% of Records from a Table.
select * from worker w
where worker_id <=(select count(worker_id)/2 from worker);

-- 40. Write SQL Query to Fetch Departments with Less than Five People in Them.
select department,count(worker_id) as no_of_workers from worker
group by department having no_of_workers < 5;

-- 41. Write SQL Query to Show All Departments with the Number of People in There.
select department,count(worker_id) as no_of_workers from worker
group by department;

-- 42. Write SQL Query to Show the Last Record from a Table.
select * from worker
order by worker_id desc
limit 1;

-- 43. Write SQL Query to Fetch the First Row of a Table.
select * from worker
where worker_id = (select min(WORKER_ID) from worker);

-- 44. Write SQL Query to Fetch the Last Five Records from a Table.
select * from worker
order by worker_id desc
limit 5;

-- 45. Write SQL Query to Show Employees with the Highest Salary in Each Department.
select * from(
select *,
rank() over (partition by department order by salary desc) as highest_salary 
from worker) w
where highest_salary = 1;

-- 46. Write SQL Query to Fetch the Top Three Max Salaries from a Table.
select distinct salary from worker
order by salary desc
limit 3;

-- 47. Write SQL Query to Fetch the Three Min Salaries from a Table.
select distinct salary from worker
order by salary 
limit 3;

-- 48. Write SQL Query to Fetch the Nth Max Salaries from a Table.
select * from worker
order by salary desc
limit 4,1;

select first_name, salary from(
						select *,
						dense_rank() over(order by salary desc) as salary_rank
                        from worker) as w
where salary_rank = 6;

-- 49. Write SQL Query to Fetch Departments and Their Total Salaries.
select distinct department,
sum(salary) over(partition by department) as total_salary
from worker;

-- 50. Write SQL Query to Fetch Workers with the Highest Salary.
select * from worker
where salary = (select max(salary) from worker)