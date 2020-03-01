--Challenge 7 Part 1 - Number of [titles] Retiring
SELECT ri.emp_no,
ri.first_name,
ri.last_name,
ti.title, 
ti.from_date,
sa.salary
into number_retirement_titles
FROM retirement_info as ri
inner join titles as ti
on ri.emp_no = ti.emp_no
inner join salaries as sa
on ri.emp_no=sa.emp_no
	 
select * from number_retirement_titles

-- Challenge 7 Part 1 - Number of [titles] Retiring with most recent title using partition
SELECT emp_no, first_name, last_name, title,from_date,salary 
into number_retirement_latest_titles
FROM
(
SELECT emp_no, first_name, last_name,  title,from_date,salary,
     ROW_NUMBER() OVER 
(PARTITION BY (emp_no, first_name, last_name,salary) ORDER BY from_date DESC) rn
   FROM number_retirement_titles
) tmp 
WHERE rn = 1;

--Count of employee titles by desc date
select from_date, title, count(emp_no)
into count_employee_titles
from number_retirement_latest_titles
group by from_date, title
order by from_date desc

--titles table with just teh latest titles
select emp_no, title, from_date, to_date
into latest_titles
from
(SELECT emp_no, title, from_date, to_date,
     ROW_NUMBER() OVER 
(PARTITION BY (emp_no) ORDER BY from_date DESC) rn
   FROM titles
) tmp
 where rn = 1;

--Mentor Table
select 
emp.emp_no,
emp.first_name,
emp.last_name,
ti.title,
ti.from_date,
ti.to_date
into mentor_list
from employees emp
inner join 
latest_titles as ti
on emp.emp_no = ti.emp_no
LEFT JOIN dept_employee as de
ON emp.emp_no = de.emp_no
WHERE 
emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
and de.to_date = ('9999-01-01') ;