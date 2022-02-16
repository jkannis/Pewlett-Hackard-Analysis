-- DELIVERABLE 1 --

-- List of retirement-age employees and their titles
SELECT e.emp_no,
	e.first_name, 
	e.last_name, 
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM titles as t
INNER JOIN employees as e ON t.emp_no = e.emp_no
WHERE (e.birth_date >= '01-01-1952' AND e.birth_date <= '12-31-1955')

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, 
	first_name, 
	last_name, 
	title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC, from_date DESC

-- List of titles and count of retirees
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC

-- DELIVERABLE 2 --

-- List of employees eligible for the mentorship program
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,
		d.from_date, d.to_date,
		t.title
INTO mentorship_eligibility
FROM employees as e
JOIN dept_emp as d ON e.emp_no = d.emp_no
JOIN titles as t ON e.emp_no = t.emp_no
WHERE d.to_date = '9999-01-01'
AND (e.birth_date >= '01-01-1965' AND e.birth_date <= '12-31-1965')
ORDER BY e.emp_no