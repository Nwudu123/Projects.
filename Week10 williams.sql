
---------------------------- TO the nearest whole number---------------------------------
USE bike;
SELECT MIN(14) AS'stock Average'
FROM stock;
SELECT ROUND(AVG(Quantity),0)AS "Stock Average"
FROM Stock;   
   
           # filter to the lowest quantity of zero #
	SELECT  product_name
FROM store s
JOIN stock st
ON s.store_id = st.store_id
JOIN product p
ON st.product_id = p.product_id
WHERE quantity = 0
GROUP BY product_name 
ORDER BY product_name;

          


       #Sorting bikes in the lowest order #
USE bike;
SELECT category_name, COUNT( case when store_name = "Baldwin Bikes" then  1 end) AS "Instock"
FROM category c
   JOIN product p
            ON c.category_id = p.category_id
   JOIN stock k
            ON p.product_id = k.product_id
    JOIN store s
            ON s.store_id = k.store_id
	GROUP BY category_name
    ORDER BY instock ASC;

# Total number of employees#
        USE employees;
        SELECT * FROM employees;
        SELECT COUNT(emp_no) AS "Number of Employees"
        FROM employees;
        
        
        # averaging all the departments #
USE employees;
SELECT DISTINCT dept_name, FORMAT (AVG(salary), 2) AS average_salary
FROM salaries JOIN employees
ON salaries.emp_no = employees.emp_no
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no =departments.dept_no
GROUP BY dept_name 
HAVING AVG(salary) < 60000;

# numbers of female who works in each department #
USE employees;
SELECT  dept_name, COUNT(gender) AS "Number of Females"
     FROM departments ds
JOIN dept_emp de
      ON de.dept_no = ds.dept_no
JOIN employees es
       ON es.emp_no = de.emp_no
WHERE gender ="F"
GROUP BY  gender,dept_name;
















