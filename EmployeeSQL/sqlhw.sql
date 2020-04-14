DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;

CREATE TABLE employees(
	emp_no INT NOT NULL PRIMARY KEY,
	birth_date DATE NOT NULL,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	gender VARCHAR(7) NOT NULL,
	hire_date DATE NOT NULL
	
);

CREATE TABLE departments(
	dept_no VARCHAR(20) NOT NULL PRIMARY KEY,
	dept_name VARCHAR(30) NOT NULL

);

CREATE TABLE dept_manager(
	dept_manager_id VARCHAR(20) NOT NULL,
	emp_manager_id INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (dept_manager_id) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_manager_id) REFERENCES employees(emp_no)
	

);

CREATE TABLE dept_emp(
	emp_dept_id INT NOT NULL,
	dept_emp_id VARCHAR,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (dept_emp_id) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_dept_id) REFERENCES employees(emp_no)
	
);

CREATE TABLE titles(
	emp_title_id INT NOT NULL,
	title VARCHAR(30) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES employees(emp_no)
);

CREATE TABLE salaries(
	emp_salary_id INT NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_salary_id) REFERENCES employees(emp_no)
);

COPY employees FROM 'C:\sql_hw_data/employees.csv' DELIMITER ',' CSV HEADER;
COPY departments FROM 'C:\sql_hw_data/departments.csv' DELIMITER ',' CSV HEADER;
COPY dept_emp FROM 'C:\sql_hw_data/dept_emp.csv' DELIMITER ',' CSV HEADER;
COPY dept_manager FROM 'C:\sql_hw_data/dept_manager.csv' DELIMITER ',' CSV HEADER;
COPY salaries FROM 'C:\sql_hw_data/salaries.csv' DELIMITER ',' CSV HEADER;
COPY titles FROM 'C:\sql_hw_data/titles.csv' DELIMITER ',' CSV HEADER;



--Question 1
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees as e
INNER JOIN salaries as s 
	ON e.emp_no = s.emp_salary_id;



--Question 2
SELECT *
FROM employees
WHERE hire_date < '1987-01-01' AND  hire_date > '1985-12-31';



--Question 3
SELECT dm.dept_manager_id, d.dept_name, dm.emp_manager_id, e.last_name, e.first_name, dm.from_date as start_date, dm.to_date as end_date
FROM dept_manager as dm
INNER JOIN departments as d 
	ON dm.dept_manager_id = d.dept_no
INNER JOIN employees as e
	on dm.emp_manager_id = e.emp_no;



--Question 4
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
JOIN dept_emp as de
	ON e.emp_no = de.emp_dept_id
JOIN departments as d
	ON de.dept_emp_id = d.dept_no;



--Question 5
SELECT *
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--Question 6
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
JOIN dept_emp as de
	ON e.emp_no = de.emp_dept_id
JOIN departments as d
	ON de.dept_emp_id = d.dept_no
	WHERE d.dept_name = 'Sales';
	
--Question 7
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
JOIN dept_emp as de
	ON e.emp_no = de.emp_dept_id
JOIN departments as d
	ON de.dept_emp_id = d.dept_no
	WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';

--Question 8
SELECT last_name, COUNT(last_name) as number_of_occurences
FROM employees
GROUP BY last_name
ORDER BY number_of_occurences DESC;



