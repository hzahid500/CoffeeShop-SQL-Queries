-- Joining all the tables together in the database

SELECT e.first_name, e.last_name, e.hire_date, e.gender, e.salary,
	   s.coffeeshop_name, l.city, l.country, s.coffeeshop_name,
	   su.supplier_name, su.coffee_type
FROM
	employees e
JOIN
	shops s ON e.coffeeshop_id = s.coffeeshop_id
JOIN
	locations l ON s.city_id = l.city_id
JOIN
	suppliers su ON e.coffeeshop_id = su.coffeeshop_id

-- Using CTE to query the joined_table, looking at the max salary in each country

WITH joined_table AS
(
SELECT e.first_name, e.last_name, e.hire_date, e.gender, e.salary,
	   s.coffeeshop_name, l.city, l.country, s.coffeeshop_name,
	   su.supplier_name, su.coffee_type
FROM
	employees e
JOIN
	shops s ON e.coffeeshop_id = s.coffeeshop_id
JOIN
	locations l ON s.city_id = l.city_id
JOIN
	suppliers su ON e.coffeeshop_id = su.coffeeshop_id
)
SELECT 
	country, max(salary) as max_salary_by_country
from 
	joined_table
GROUP BY 
	country
ORDER BY 
	max_salary_by_country DESC

-- Using joined_table, what is the average salary by country?

WITH joined_table AS
(
SELECT e.first_name, e.last_name, e.hire_date, e.gender, e.salary,
	   s.coffeeshop_name, l.city, l.country, s.coffeeshop_name,
	   su.supplier_name, su.coffee_type
FROM
	employees e
JOIN
	shops s ON e.coffeeshop_id = s.coffeeshop_id
JOIN
	locations l ON s.city_id = l.city_id
JOIN
	suppliers su ON e.coffeeshop_id = su.coffeeshop_id
)
SELECT 
	country, round(avg(salary),2) as avg_salary_by_country
from 
	joined_table
GROUP BY 
	country
ORDER BY 
	avg_salary_by_country DESC

-- Using joined_table, what is the average salary by city name?

WITH joined_table AS
(
SELECT e.first_name, e.last_name, e.hire_date, e.gender, e.salary,
	   s.coffeeshop_name, l.city, l.country, s.coffeeshop_name,
	   su.supplier_name, su.coffee_type
FROM
	employees e
JOIN
	shops s ON e.coffeeshop_id = s.coffeeshop_id
JOIN
	locations l ON s.city_id = l.city_id
JOIN
	suppliers su ON e.coffeeshop_id = su.coffeeshop_id
)
SELECT
	city, ROUND(AVG(salary),2) as avg_salary_by_city
FROM
	joined_table
GROUP BY
	city
ORDER BY 
	avg_salary_by_city DESC

-- Using joined_table, what is the average salary by coffeeshop and where are the shops located?

WITH joined_table AS
(
SELECT e.first_name, e.last_name, e.hire_date, e.gender, e.salary,
	   s.coffeeshop_name, l.city, l.country,
	   su.supplier_name, su.coffee_type
FROM
	employees e
JOIN
	shops s ON e.coffeeshop_id = s.coffeeshop_id
JOIN
	locations l ON s.city_id = l.city_id
JOIN
	suppliers su ON e.coffeeshop_id = su.coffeeshop_id
)	
SELECT 
	coffeeshop_name, city, ROUND(AVG(salary),2) as avg_salary_by_coffeeshop
FROM
	joined_table
GROUP BY
	coffeeshop_name, city
ORDER BY
	avg_salary_by_coffeeshop DESC
	
-- which employee has the highest salary by coffeeshop_name?

with highest_dept_salary as
(
SELECT
	first_name, last_name, coffeeshop_name, salary, 
	max(salary) OVER (PARTITION BY coffeeshop_name) as highest_salary_by_coffeeshop
FROM
	joined_table
GROUP BY
	1,2,3,4
ORDER BY 
	highest_salary_by_coffeeshop DESC
)
SELECT 
	coffeeshop_name, MAX(highest_salary_by_coffeeshop) as max_salary
FROM
	highest_dept_salary
GROUP BY
	coffeeshop_name
ORDER BY
	max_salary DESC








