-- =====================================================
-- Project: Employee Compensation & Bonus Analysis
-- Database: PostgreSQL
-- Author: Mykhailo Korobchuk
-- =====================================================

-- -----------------------------------------------------
-- 1. Department Salary Benchmarking
-- Business Goal: Understand salary distributions, ranges, and averages per department.
-- -----------------------------------------------------

SELECT 
    department,
    COUNT(*) AS total_employees,
    ROUND(AVG(salary), 2) AS avg_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary,
    MAX(salary) - MIN(salary) AS salary_spread
FROM employees
GROUP BY department
ORDER BY avg_salary DESC;

-- -----------------------------------------------------
-- 2. Top-2 Earners Per Department
-- Business Goal: Identify top compensation tiers within each department using Window Functions.
-- -----------------------------------------------------

WITH ranked_salary AS (
  SELECT department,
         first_name,
         last_name,
         salary,
         DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_salary
  FROM employees
)

SELECT department,
       first_name,
       last_name,
       salary,
       rank_salary
FROM ranked_salary
WHERE rank_salary <= 2
ORDER BY department, rank_salary;

-- -----------------------------------------------------
-- 3. Bonus Eligibility & Department Coverage
-- Business Goal: Identify which departments and employees receive bonuses vs. those with 0 bonuses.
-- -----------------------------------------------------

SELECT e.department,
       COUNT(DISTINCT e.id) AS total_employees,
       COUNT(DISTINCT b.employee_id) AS count_bonus,
       COALESCE(SUM(b.bonus_amount), 0) AS total_bonus,
       ROUND(COUNT(DISTINCT b.employee_id) * 100 / COUNT(DISTINCT e.id), 2) AS bonus_coverage_pct
FROM employees AS e
LEFT JOIN bonuses AS b
ON e.id = b.employee_id
GROUP BY e.department
ORDER BY count_bonus DESC;
