-- MVP --

-- Question 1. How many employee records are lacking both a grade and salary?
SELECT
    count(id)
FROM employees
WHERE grade IS NULL AND salary IS NULL; 

-- Question 2. Produce a table with the two following fields (columns):

    -- the department
    -- the employees full name (first and last name)

-- Order your resulting table alphabetically by department, and then by last name
SELECT 
    department,
    concat(first_name, ' ', last_name)
FROM employees
ORDER BY department ASC, last_name ASC;

-- Question 3. Find the details of the top ten highest paid employees who have a last_name beginning with ‘A’.
SELECT *
FROM employees 
WHERE last_name ILIKE 'a%' AND salary IS NOT NULL
ORDER BY salary DESC 
LIMIT 10;

-- Question 4. Obtain a count by department of the employees who started work with the corporation in 2003.
SELECT
    department,
    count(*)
FROM employees 
WHERE start_date BETWEEN '2003-01-01' AND '2003-12-31'
GROUP BY department;

-- Question 5. Obtain a table showing department, fte_hours and the number of employees in each department
--             who work each fte_hours pattern. Order the table alphabetically by department, and then in
--             ascending order of fte_hours.
SELECT 
    department,
    fte_hours,
    count(*)
FROM employees
GROUP BY department, fte_hours 
ORDER BY department ASC, fte_hours ASC;

-- Question 6. Provide a breakdown of the numbers of employees enrolled, not enrolled, and with unknown 
--             enrollment status in the corporation pension scheme.
SELECT
    pension_enrol,
    count(*)
FROM employees
GROUP BY pension_enrol;

-- Question 7. Obtain the details for the employee with the highest salary in the ‘Accounting’ department who
--             is not enrolled in the pension scheme?
SELECT *
FROM employees 
WHERE department = 'Accounting' 
    AND pension_enrol IS FALSE
    AND salary IS NOT NULL 
ORDER BY salary DESC 
LIMIT 1;

-- Question 8. Get a table of country, number of employees in that country, and the average salary 
--             of employees in that country for any countries in which more than 30 employees are based. 
--             Order the table by average salary descending.
--             Hints: A HAVING clause is needed to filter using an aggregate function. 
--             You can pass a column alias to ORDER BY. 
SELECT 
    country,
    count(id),
    round(avg(salary))
FROM employees
WHERE country IN
     (SELECT 
            country FROM employees 
        GROUP BY country 
        HAVING count(country) > 30);
GROUP BY country 

-- Question 9. Return a table containing each employees first_name, last_name, full-time equivalent hours 
--             (fte_hours), salary, and a new column effective_yearly_salary which should contain fte_hours 
--             multiplied by salary. Return only rows where effective_yearly_salary is more than 30000.
SELECT 
    first_name,
    last_name,
    fte_hours,
    salary,
    (salary * fte_hours) AS effective_yearly_salary 
FROM employees 
WHERE (salary * fte_hours) > 30000;

-- Question 10. Find the details of all employees in either Data Team 1 or Data Team 2
--              Hint: name is a field in table `teams 
SELECT
    e.*,
    t.*
FROM employees AS e LEFT JOIN teams AS t
ON e.team_id = t.id 
WHERE t."name" IN ('Data Team 1', 'Data Team 2');

-- Question 11. Find the first name and last name of all employees who lack a local_tax_code.
--              Hint: local_tax_code is a field in table pay_details, and first_name and last_name 
--              are fields in table employees 
SELECT 
 e.first_name,
 e.last_name
FROM employees AS e LEFT JOIN pay_details AS pd 
ON e.id = pd.id
WHERE pd.local_tax_code IS NULL; 

-- Question 12. The expected_profit of an employee is defined as (48 * 35 * charge_cost - salary) * fte_hours,
--              where charge_cost depends upon the team to which the employee belongs. Get a table showing 
--              expected_profit for each employee.
    (48 * 35 * CAST(t.charge_cost AS int) - salary) * fte_hours 
    AS expected_profit 
FROM employees AS e LEFT JOIN teams AS t 
ON e.team_id = t.id 
WHERE t.charge_cost IS NOT NULL 
AND fte_hours IS NOT NULL AND salary IS NOT NULL;

-- Question 13. Find the first_name, last_name and salary of the lowest paid employee in Japan who works the
--              least common full-time equivalent hours across the corporation.”
--              Hint: You will need to use a subquery to calculate the mode 

SELECT
    first_name,
    last_name,
    salary 
FROM employees
WHERE country = 'Japan' AND fte_hours IN (
  SELECT fte_hours
  FROM employees
  GROUP BY fte_hours
  HAVING COUNT(*) = (
    SELECT min(count)
    FROM (
      SELECT COUNT(*) AS count
      FROM employees
      GROUP BY fte_hours
    ) AS temp
  )
)
ORDER BY salary ASC 
LIMIT 1

-- Question 14. Obtain a table showing any departments in which there are two or more employees 
--              lacking a stored first name. Order the table in descending order of the number of 
--              employees lacking a first name, and then in alphabetical order by department.
SELECT 
    department,
    count(*) AS num_lacking_first_name
FROM employees e 
WHERE first_name IS NULL 
GROUP BY department
HAVING count(*) >= 2
ORDER BY count(*) DESC, department ASC 

-- Question 15.  Return a table of those employee first_names shared by more than one employee, 
--               together with a count of the number of times each first_name occurs. Omit employees
--               without a stored first_name from the table. Order the table descending by count,
--               and then alphabetically by first_name.
SELECT 
    first_name,
    count(*) AS occurances
FROM employees 
WHERE first_name IS NOT NULL 
GROUP BY first_name
HAVING count(*) > 1
ORDER BY count(*) DESC, first_name ASC 

-- Question 16. Find the proportion of employees in each department who are grade 1.

WITH grade_1s_per_dep AS (
SELECT 
    department,
    count(*)
FROM employees 
GROUP BY department, grade 
HAVING grade = 1
),
grades_per_dep AS (
SELECT 
    department,
    count(*)
FROM employees 
GROUP BY department 
)
SELECT 
    department,
    count