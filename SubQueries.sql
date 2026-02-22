create database subqueries;
use subqueries;

create table Employee(
emp_id int primary key,
name varchar(15),
department_id varchar(10),
salary int);

Insert into Employee(emp_id,name,department_id,salary) values (101,"Abhishek","D01",62000);
Insert into Employee(emp_id,name,department_id,salary) values (102,"Shubham","D01",58000);
Insert into Employee(emp_id,name,department_id,salary) values (103,"Priya","D02",67000);
Insert into Employee(emp_id,name,department_id,salary) values (104,"Rohit","D02",64000);
Insert into Employee(emp_id,name,department_id,salary) values (105,"Neha","D03",72000);
Insert into Employee(emp_id,name,department_id,salary) values (106,"Aman","D03",55000);
Insert into Employee(emp_id,name,department_id,salary) values (107,"Ravi","D04",60000);
Insert into Employee(emp_id,name,department_id,salary) values (108,"Sneha","D04",75000);
Insert into Employee(emp_id,name,department_id,salary) values (109,"Kiran","D05",70000);
Insert into Employee(emp_id,name,department_id,salary) values (110,"Tanuja","D05",65000);
select * from Employee;


create table Department(
department_id varchar(10),
department_name varchar(30),
location varchar(20));

Insert into Department(department_id,department_name,location) values ("D01","Sales","Mumbai");
Insert into Department(department_id,department_name,location) values ("D02","Marketing","Delhi");
Insert into Department(department_id,department_name,location) values ("D03","Finance","Pune");
Insert into Department(department_id,department_name,location) values ("D04","HR","Bengaluru");
Insert into Department(department_id,department_name,location) values ("D05","IT","Hyderabad");
select * from Department;

create table Sales(
sale_id int,
emp_id int,
sale_amount int,
sale_date date);

Insert into Sales(sale_id,emp_id,sale_amount,sale_date) values (201,101,4500,"2025-01-05");
Insert into Sales(sale_id,emp_id,sale_amount,sale_date) values (202,102,7800,"2025-01-10");
Insert into Sales(sale_id,emp_id,sale_amount,sale_date) values (203,103,6700,"2025-01-14");
Insert into Sales(sale_id,emp_id,sale_amount,sale_date) values (204,104,12000,"2025-01-20");
Insert into Sales(sale_id,emp_id,sale_amount,sale_date) values (205,105,9800,"2025-02-02");
Insert into Sales(sale_id,emp_id,sale_amount,sale_date) values (206,106,10500,"2025-02-05");
Insert into Sales(sale_id,emp_id,sale_amount,sale_date) values (207,107,3200,"2025-02-09");
Insert into Sales(sale_id,emp_id,sale_amount,sale_date) values (208,108,5100,"2025-02-15");
Insert into Sales(sale_id,emp_id,sale_amount,sale_date) values (209,109,3900,"2025-02-20");
Insert into Sales(sale_id,emp_id,sale_amount,sale_date) values (210,110,7200,"2025-03-01");
select * from Sales;

### 15 Daily Practice Problems (DPP) on Subqueries
### Basic Level


### 1. Retrieve the names of employees who earn more than the average salary of all employees.

select name, salary
from Employee 
where salary > (select avg(salary) from Employee);

### 2. Find the employees who belong to the department with the highest average salary.

select e.emp_id, e.name, e.department_id, e.salary
from Employee e
where e.department_id > (
    select department_id
    from Employee
    group by department_id
    order by avg(salary) desc
    limit 1);

### 3. List all employees who have made at least one sale.

select e.emp_id, e.name,s.sale_amount
FROM Employee e
join Sales s 
on e.emp_id = s.emp_id
where e.emp_id in (
select distinct emp_id
from Sales);

### 4. Find the employee with the highest sale amount.

select e.emp_id, e.name,s.sale_amount
FROM Employee e
join Sales s 
on e.emp_id = s.emp_id
having s.sale_amount = (
select max(sale_amount)
from Sales);

### 5. Retrieve the names of employees whose salaries are higher than Shubham’s salary.

select emp_id,name,salary
from Employee 
where salary > (select salary from Employee where name = "Shubham");

### Intermediate Level

### 1.Find employees who work in the same department as Abhishek.

select e.emp_id,e.name,e.department_id,d.department_name
from Employee e
join Department d
on e.department_id = d.department_id
where e.department_id = (select department_id from Employee where name = "Abhishek");

### 2. List departments that have at least one employee earning more than ₹60,000.

select d.department_id,d.department_name,e.name,e.salary
from Department d
join Employee e
on d.department_id = e.department_id
where e.name in (select name from Employee where salary > 60000);

### 3. Find the department name of the employee who made the highest sale.

select d.department_id,d.department_name,e.name,s.sale_amount
from Department d
join Employee e
on d.department_id = e.department_id 
join Sales s
on e.emp_id = s.emp_id
where sale_amount = (select Max(sale_amount) from Sales);

### 4. Retrieve employees who have made sales greater than the average sale amount.

select e.name,s.sale_amount
from Sales s
join Employee e 
on s.emp_id = e.emp_id
where s.sale_amount > (select avg(sale_amount) from sales);

### 5. Find the total sales made by employees who earn more than the average salary.

select e.name,e.salary,sum(sale_amount) as Totalsales
from Sales s
join Employee e
on s.emp_id = e.emp_id
where e.salary > (select avg(salary) from Employee)
group by s.emp_id;

### Advanced Level

### 1. Find employees who have not made any sales.

select e.name,s.sale_amount,e.emp_id
from Employee e
join Sales s
on e.emp_id = s.emp_id
where s.sale_amount not in (select sale_amount > 0 from Sales);

### 2. List departments where the average salary is above ₹55,000.

select d.department_name,e.salary
from Department d
join Employee e
on d.department_id = e.department_id
where e.salary > (select avg(salary) from Employee);

### 3. Retrieve department names where the total sales exceed ₹10,000.

select d.department_name
from Department d
where department_id in(select e.department_id
from Employee e
join Sales s
on e.emp_id = s.emp_id
group by e.department_id
having sum(sale_amount) > 10000);

### 4. Find the employee who has made the second-highest sale.

select e.name,e.emp_id,s.sale_amount
from Employee e
join Sales s 
on e.emp_id = s.emp_id
where s.sale_amount = (select max(sale_amount) from Sales 
where sale_amount < (select max(sale_amount) from Sales));

### 5. Retrieve the names of employees whose salary is greater than the highest sale amount recorded.

select e.name,e.salary
from Employee e 
join sales s
on e.emp_id = s.emp_id
where e.salary > (select max(sale_amount) from Sales);




