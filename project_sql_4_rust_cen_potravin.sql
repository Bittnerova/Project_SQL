-- Tuul Bittnerová project 1 ukol 4
/*
 * Existuje rok, ve kterém byl mezi roční nárůst cen potravin výrazně vyšší než
 *  růst mezd (větší než 10 %)?
 */

-- průměrné mzdy

SELECT
	*,
	LAG(avg_wages) OVER (ORDER BY wages_year) AS prev_wages
FROM (
	SELECT DISTINCT 
		wages_year,
		avg_wages
	FROM t_tuul_bittnerova_project_SQL_primary_final 
	WHERE industry_branch_code IS NULL
	) a;


-- průměrné ceny

 
SELECT 
	*,
	LAG(avg_price) OVER (PARTITION BY category_code ORDER BY price_year) AS prev_price
FROM (
	SELECT DISTINCT 
		price_year,
		category_code,
		food_name,
		avg_price
	FROM t_tuul_bittnerova_project_SQL_primary_final 
	) a;

SELECT 
	a.wages_year,
	ROUND((a.avg_wages - b.avg_wages) * 100 / b.avg_wages, 2) AS wages_growth,
	ROUND(AVG((a.avg_price - b.avg_price) * 100 / b.avg_price), 2) AS price_growth,
	ROUND((AVG((a.avg_price - b.avg_price) * 100 / b.avg_price)) - ((a.avg_wages - b.avg_wages) * 100 / b.avg_wages), 2) AS growth_diff
FROM t_tuul_bittnerova_project_SQL_primary_final a
LEFT JOIN t_tuul_bittnerova_project_SQL_primary_final b
	ON a.category_code = b.category_code
	AND a.wages_year = b.wages_year + 1
WHERE a.industry_branch_code IS NULL 
	AND a.wages_year > 2006
GROUP BY a.price_year 
ORDER BY growth_diff DESC;

