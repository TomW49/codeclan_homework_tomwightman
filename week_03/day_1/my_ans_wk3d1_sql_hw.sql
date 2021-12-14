/* MVP */

/* Q1 */
SELECT*
FROM employees 
WHERE department = 'Human Resources';

/* Q2 */
SELECT 
    first_name,
    last_name,
    country
FROM employees
WHERE department = 'Legal';

/* Q3 */
SELECT 
    count (*) AS number_of_portugal_employees
FROM employees 
WHERE country = 'Portugal';
    
/* Q4 */
SELECT 
    count (*) AS number_of_portugese_and_spanish_employees
FROM employees 
WHERE country in ('Portugal', 'Spain');

/* Q5 */
SELECT 
    count (*) AS pay_details_lacking_local_acc_number
FROM pay_details
WHERE local_account_no IS NULL;

/* Q6 */
SELECT 
    count (*) AS pay_details_lacking_local_acc_number
FROM pay_details
WHERE 
    local_account_no IS NULL
    AND iban IS NULL;

/* Q7 */
SELECT 
    first_name,
    last_name 
FROM employees 
ORDER BY  last_name ASC NULLS LAST;

/* Q8 */
SELECT 
    first_name,
    last_name,
    country 
FROM employees
ORDER BY 
        country ASC NULLS LAST,
    last_name ASC NULLS LAST;

/* Q9 */
SELECT *
FROM employees
ORDER BY salary DESC NULLS LAST
LIMIT 10;

/* Q10 */
SELECT 
    first_name,
    last_name,
    salary 
FROM employees 
WHERE country = 'Hungary'
ORDER BY salary ASC NULLS LAST 
LIMIT 1;
    
/* Q11 */
SELECT  
    count (*) AS employees_with_first_name_starting_with_p
FROM employees 
WHERE first_name ILIKE 'p%';

/* Q12 */
SELECT * 
FROM employees 
WHERE email ILIKE '%yahoo%'

/* Q13 */
SELECT 
    count (*) AS pensions_not_in_france_or_germany
FROM employees 
WHERE pension_enrol IS NOT NULL 
     AND (country <> 'Germany' AND country <> 'France');
     
/* Q14 */
SELECT 
    max(salary) AS maximum_salary
FROM employees 
WHERE department = 'Engineering' AND fte_hours = '1.0'

/* Q15 */
SELECT 
    first_name,
    last_name,
    fte_hours,
    salary,
    fte_hours * salary AS effective_yearly_salary
FROM employees 
