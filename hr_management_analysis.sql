CREATE DATABASE hr_management;
USE hr_management;

CREATE TABLE Departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2),
    hire_date DATE,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

CREATE TABLE Recruitment (
    recruit_id INT PRIMARY KEY AUTO_INCREMENT,
    candidate_name VARCHAR(50),
    position VARCHAR(50),
    interview_date DATE,
    status VARCHAR(20)
);

CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    attendance_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);

CREATE TABLE Payroll (
    payroll_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    basic_salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    pay_month VARCHAR(20),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);

CREATE TABLE LeaveRequests (
    leave_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    leave_type VARCHAR(30),
    days INT,
    status VARCHAR(20),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);

CREATE TABLE Appraisals (
    appraisal_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    review_date DATE,
    rating INT,
    remarks VARCHAR(100),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);

select * from departments
select * from employees
select * from Recruitment

select * from Attendance
select * from payroll
select * from LeaveRequests
select * from Appraisals


use hr_management

--Display all employees
select * from employees

--Display all departments.
select * from departments

--Display all recruitment records
select * from recruitment 

--Display employee names and salaries
select emp_name, salary from employees

--Display employee names and hire dates.
select emp_name, hire_date from employees

--Show employees whose salary is greater than 50,000
select * from employees where salary >50000

--Show employees who belong to department 1
select * from employees where dept_id =1

--Display employees hired after 2023-01-01
select * from employees where hire_date> 2023-01-01

--Show recruitment candidates with status = 'Selected'
select * from Recruitment where status= 'selected'

--Display leave requests with status = 'Approved'
select * from LeaveRequests where status ='approved'

--Display employees ordered by salary (ascending)
select * from employees order by salary asc

--Display employees ordered by salary (descending)
select * from employees order by salary desc

--Display payroll records ordered by bonus (highest first)
select * from payroll order by bonus desc limit 1

--Display unique leave types
select distinct leave_type from leaverequests

--Display unique recruitment positions
select distinct position from recruitment

--Find the total number of employees
select count(*) total_employees from employees

--Find the maximum salary
select max(salary) AS maximum_salary from employees

--Find the minimum salary
select min(salary) As minimum_salary from employees

--Find the average salary
select avg(salary) As average_salary from employees

--Find the total bonus paid
select sum(bonus) As total_bonus_paid from payroll

--Count employees in each department
select dept_id, count(*) from employees group by dept_id

--Find the average salary for each department
select dept_id, avg(salary) from employees group by dept_id

--Count leave requests by status
select status, count(*) from leaverequests group by status

--Display the first 5 employees
select * from employees limit 5

--Display the top 3 highest-paid employees
select * from employees order by salary desc limit 3

--Display employee name with department name
SELECT e.emp_name,d.dept_name 
FROM Employees e 
JOIN Departments d ON e.dept_id=d.dept_id;

--Display employee name and payroll details
SELECT e.emp_name,p.basic_salary,p.bonus,p.pay_month 
FROM Employees e 
JOIN Payroll p ON e.emp_id=p.emp_id;

--Display employee name and appraisal rating
SELECT e.emp_name,a.rating 
FROM Employees e 
JOIN Appraisals a ON e.emp_id=a.emp_id;

--Display employee name and attendance status
SELECT e.emp_name,at.status 
FROM Employees e 
JOIN Attendance at ON e.emp_id=at.emp_id;

--Display employee name, department name, and salary
SELECT e.emp_name,d.dept_name,e.salary 
FROM Employees e  
JOIN Departments d ON e.dept_id=d.dept_id

--Find the second highest salary
SELECT MAX(salary) AS second_highest_salary
FROM Employees
WHERE salary < (SELECT MAX(salary) FROM Employees);

--Find employees earning more than the average salary
SELECT *
FROM Employees
WHERE salary > (
SELECT AVG(salary)
FROM Employees
);

--Department with highest average salary
SELECT dept_id, AVG(salary) AS avg_salary
FROM Employees
GROUP BY dept_id
ORDER BY avg_salary DESC
LIMIT 1;

--Employees who never applied for leave
SELECT *
FROM Employees
WHERE emp_id NOT IN (
    SELECT emp_id
    FROM LeaveRequests
);

--Employees with appraisal rating 5
SELECT e.emp_name, a.rating
FROM Employees e
JOIN Appraisals a
ON e.emp_id = a.emp_id
WHERE a.rating = 5;

--Find departments having more than 50 employees
SELECT dept_id, COUNT(*) AS total_employees
FROM Employees
GROUP BY dept_id
HAVING COUNT(*) > 50;

--Find the employee with the highest bonus
SELECT e.emp_name, p.bonus
FROM Employees e
JOIN Payroll p
ON e.emp_id = p.emp_id
ORDER BY p.bonus DESC
LIMIT 1;

--Display employees who have never received an appraisal
SELECT *
FROM Employees
WHERE emp_id NOT IN (
    SELECT emp_id
    FROM Appraisals
);

--Count employees in each department
SELECT d.dept_name,
COUNT(e.emp_id) AS total_employees
FROM Departments d
LEFT JOIN Employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

--Find employees whose salary is higher than every employee in Department 2
SELECT *
FROM Employees
WHERE salary >
ALL (
    SELECT salary
    FROM Employees
    WHERE dept_id = 2
);

--Find the total payroll amount for each department
SELECT d.dept_name,
SUM(p.basic_salary + p.bonus) AS total_payroll
FROM Employees e
JOIN Departments d
ON e.dept_id = d.dept_id
JOIN Payroll p
ON e.emp_id = p.emp_id
GROUP BY d.dept_name;

--Find the top 5 highest-paid employees.
SELECT *
FROM Employees
ORDER BY salary DESC
LIMIT 5;

--Find employees hired in the current year
SELECT *
FROM Employees
WHERE YEAR(hire_date) = YEAR(CURDATE());

--Display employees who have more than one leave request
SELECT emp_id,
COUNT(*) AS leave_count
FROM LeaveRequests
GROUP BY emp_id
HAVING COUNT(*) > 1;

--Find departments where the average salary is above 60,000
SELECT dept_id,
AVG(salary) AS avg_salary
FROM Employees
GROUP BY dept_id
HAVING AVG(salary) > 60000;

--Display employee details along with department name and appraisal rating
SELECT e.emp_name,
d.dept_name,
a.rating
FROM Employees e
JOIN Departments d
ON e.dept_id = d.dept_id
JOIN Appraisals a
ON e.emp_id = a.emp_id;

--Find employees who were absent
SELECT DISTINCT e.emp_name
FROM Employees e
JOIN Attendance a
ON e.emp_id = a.emp_id
WHERE a.status = 'Absent';

--Rank employees by salary using a window function
SELECT emp_name,
salary,
RANK() OVER(ORDER BY salary DESC) AS salary_rank
FROM Employees;

--Display the latest hired employee in each department
SELECT *
FROM Employees e
WHERE hire_date = (
    SELECT MAX(hire_date)
    FROM Employees
    WHERE dept_id = e.dept_id
);

--Find employees whose salary is above their department's average salary

SELECT emp_name,
salary,
dept_id
FROM Employees e
WHERE salary >
(
    SELECT AVG(salary)
    FROM Employees
    WHERE dept_id = e.dept_id
);