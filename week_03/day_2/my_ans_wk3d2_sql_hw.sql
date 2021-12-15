-- MVP

-- Q1 
    -- (a). Find the first name, last name and team name of employees who are members of teams.
SELECT 
    e.first_name,
    e.last_name,
    t."name" 
FROM employees AS e RIGHT JOIN teams AS t 
ON e.team_id = t.id; 


    -- (b). Find the first name, last name and team name of employees who are members of 
    --      teams and are enrolled in the pension scheme.
SELECT 
    e.first_name,
    e.last_name,
    t."name" 
FROM employees AS e RIGHT JOIN teams AS t 
ON e.team_id = t.id
WHERE e.pension_enrol IS TRUE;


    -- (c). Find the first name, last name and team name of employees who are members of teams,
    --      where their team has a charge cost greater than 80.
SELECT 
    e.first_name,
    e.last_name,
    t."name" 
FROM employees AS e RIGHT JOIN teams AS t 
ON e.team_id = t.id
WHERE cast(t.charge_cost as int) > 80;

  

--  Q2.
    -- (a). Get a table of all employees details, together with their local_account_no and local_sort_code, if they have them.
SELECT
    e.*,
    pd.local_account_no,
    pd.local_sort_code 
FROM employees AS e FULL OUTER JOIN pay_details AS pd 
ON e.id = pd.id 


    -- (b). Amend your query above to also return the name of the team that each employee belongs to
SELECT 
    e.*,
    pd.local_account_no,
    pd.local_sort_code 
FROM (employees AS e FULL OUTER JOIN pay_details AS pd 
ON e.id = pd.id)
FULL OUTER JOIN teams AS t 
ON t.id = e.team_id 

-- Q3.
    -- (a). Make a table, which has each employee id along with the team that employee belongs to.
SELECT 
    e.id,
    t."name" 
FROM employees AS e RIGHT JOIN teams AS t 
ON e.team_id = t.id; 


    -- (b). Breakdown the number of employees in each of the teams. 
SELECT 
    count (e.id),
    t."name" 
FROM employees AS e INNER JOIN teams AS t 
ON e.team_id = t.id
GROUP BY t."name" 

    -- (c). Order the table above by so that the teams with the least employees come first. 
SELECT 
    t."name",
    count (e.id)
FROM employees AS e INNER JOIN teams AS t 
ON e.team_id = t.id
GROUP BY t."name" 
ORDER BY count (e.id) ASC 

-- Q4.
    -- (a). Create a table with the team id, team name and the count of the number of employees in each team.
SELECT 
    t.id,
    t."name",
    count (e.id)
FROM employees AS e 
INNER JOIN teams AS t 
ON e.team_id = t.id
GROUP BY t.id 
ORDER BY t.id ASC 

    -- (b). The total_day_charge of a team is defined as the charge_cost of the team multiplied by the number of 
    --      employees in the team. Calculate the total_day_charge for each team.
SELECT 
    t.id,
    t."name",
    t.total_day_charge
FROM 
    (SELECT 
        t.id,
        t.name,
        count (e.id) AS num_employees,
        t.charge_cost,
        cast(t.charge_cost AS int) * count (e.id) AS total_day_charge
    FROM employees AS e INNER JOIN teams AS t 
    ON e.team_id = t.id
GROUP BY t."name", t.id 
ORDER BY t.id ASC) t 

-- instructor answer
SELECT 
    t.name,
    count(e.id) * cast(t.charge_cost AS int) AS total_day_charfe
FROM employees AS e
INNER JOIN teams AS t 
ON e.team_id = t.id
GROUP BY t.id

    -- (c). How would you amend your query from above to show only those teams with a total_day_charge greater than 5000? 
SELECT 
    t.id,
    t."name",
    t.total_day_charge
FROM 
    (SELECT 
        t.id,
        t.name,
        count (e.id) AS num_employees,
        t.charge_cost,
        cast(t.charge_cost AS int) * count (e.id) AS total_day_charge
    FROM employees AS e INNER JOIN teams AS t 
    ON e.team_id = t.id
GROUP BY t."name", t.id 
ORDER BY t.id ASC) t 
WHERE t.total_day_charge > 5000

--  instructor answer
SELECT 
    t.name,
    count(e.id) * cast(t.charge_cost AS int) AS total_day_charfe
FROM employees AS e
INNER JOIN teams AS t 
ON e.team_id = t.id
GROUP BY t.id
HAVING count(e.id) * cast(t.charge_cost AS int) > 5000

-- EXT -- 
-- Q5. 

SELECT 
    count (DISTINCT(employee_id)) AS num_employees_on_committees
FROM employees_committees 