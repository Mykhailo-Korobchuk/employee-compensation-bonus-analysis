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
