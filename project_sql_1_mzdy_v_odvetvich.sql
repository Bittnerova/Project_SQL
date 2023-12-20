-- Tuul Bittnerová projekt 1 ukol 1
/*
 * Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
 */


SELECT *
FROM (
	SELECT 
		*,
		LAG(avg_wages) OVER (PARTITION BY industry_branch_code ORDER BY wages_year) AS wages_prev,
		ROUND((avg_wages - LAG(avg_wages) OVER (PARTITION BY industry_branch_code ORDER BY wages_year)) * 100 / LAG(avg_wages) OVER (PARTITION BY industry_branch_code ORDER BY wages_year), 2) AS growth_wages
	FROM (
		SELECT DISTINCT 
			wages_year,
			industry_branch_code,
			industry_name,
			avg_wages
		FROM t_tuul_bittnerova_project_SQL_primary_final
		WHERE industry_branch_code IS NOT NULL ) a
	) b
WHERE wages_year> 2006
ORDER BY growth_wages;


SELECT *
FROM (
	SELECT 
		*,
		LAG(avg_wages) OVER (PARTITION BY industry_branch_code ORDER BY wages_year) AS wages_prev,
		ROUND((avg_wages - LAG(avg_wages) OVER (PARTITION BY industry_branch_code ORDER BY wages_year)) * 100 / LAG(avg_wages) OVER (PARTITION BY industry_branch_code ORDER BY wages_year), 2) AS growth_wages
	FROM (
		SELECT DISTINCT 
			wages_year,
			industry_branch_code,
			industry_name,
			avg_wages
		FROM t_tuul_bittnerova_project_SQL_primary_final
		WHERE industry_branch_code IS NOT NULL ) a
	) b
WHERE wages_year > 2006
ORDER BY growth_wages DESC;  

SELECT
	industry_branch_code,
	industry_name,
	ROUND(AVG(b.growth_wages), 2) AS avg_wages_growth
FROM (
	SELECT 
		*,
		LAG(avg_wages) OVER (PARTITION BY industry_branch_code ORDER BY wages_year) AS wages_prev,
		ROUND((avg_wages - LAG(avg_wages) OVER (PARTITION BY industry_branch_code ORDER BY wages_year)) * 100 / LAG(avg_wages) OVER (PARTITION BY industry_branch_code ORDER BY wages_year), 2) AS growth_wages
	FROM (
		SELECT DISTINCT 
			wages_year,
			industry_branch_code,
			industry_name,
			avg_wages
		FROM t_tuul_bittnerova_project_SQL_primary_final t
		WHERE industry_branch_code IS NOT NULL ) a
	) b
WHERE wages_year > 2006
GROUP BY industry_branch_code
ORDER BY avg_wages_growth DESC ;
