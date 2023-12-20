-- Tuul Bittnerovaá projekt 1 ukol 5

/*
 * Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste 
výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo 
následujícím roce výraznějším růstem?
 */

SELECT 
	`year`,
	GDP,
	LAG(GDP) OVER (ORDER BY `year`) AS prev_GDP,
	ROUND((GDP - (LAG(GDP) OVER (ORDER BY `year`))) * 100 / (LAG(GDP) OVER (ORDER BY `year`)), 2) AS GDP_growth
FROM t_tuul_bittnerova_project_SQL_secondary_final
WHERE country = 'Czech Republic';


SELECT 
	a.wages_year,
	ROUND((a.avg_wages - b.avg_wages) * 100 / b.avg_wages, 2) AS growth_wages,
	ROUND(AVG((a.avg_price - b.avg_price) * 100 / b.avg_price), 2) AS growth_price,
	ROUND((c.GDP - d.GDP) * 100 / d.GDP, 2) AS growth_GDP
FROM t_tuul_bittnerova_project_SQL_primary_final a
LEFT JOIN t_tuul_bittnerova_project_SQL_primary_final b
	ON a.category_code = b.category_code
	AND a.wages_year = b.wages_year + 1
LEFT JOIN t_tuul_bittnerova_project_SQL_secondary_final c
	ON a.wages_year = c.`year`
LEFT JOIN t_tuul_bittnerova_project_SQL_secondary_final d
	ON a.wages_year = d.`year` + 1
	AND c.country = d.country 
WHERE a.industry_branch_code IS NULL 
	AND a.wages_year > 2006
	AND c.country = 'Czech Republic'
GROUP BY a.price_year 
;


SELECT 
	a.wages_year,
	ROUND((a.avg_wages - b.avg_wages) * 100 / b.avg_wages, 2) AS growth_wages,
	CASE 
		WHEN (a.avg_wages - b.avg_wages) * 100 / b.avg_wages >= 5 THEN 'faster growth'
		WHEN (a.avg_wages - b.avg_wages) * 100 / b.avg_wages <= -2 THEN 'fast growth '
		ELSE 'slow growth'
	END AS wages_growth_recap,
	ROUND(AVG((a.avg_price - b.avg_price) * 100 / b.avg_price), 2) AS growth_price,
	CASE 
		WHEN AVG((a.avg_price - b.avg_price) * 100 / b.avg_price) >= 5 THEN 'faster growth'
		WHEN AVG((a.avg_price - b.avg_price) * 100 / b.avg_price)<= -2 THEN 'fast growth'
		ELSE 'slow growth'
	END AS growth_price_recap,
	ROUND((c.GDP - d.GDP) * 100 / d.GDP, 2) AS growth_GDP,
	CASE 
		WHEN (c.GDP - d.GDP) * 100 / d.GDP >= 5 THEN 'faster growth'
		WHEN (c.GDP - d.GDP) * 100 / d.GDP <= -2 THEN 'fast growth'
		ELSE 'slow growth'
	END AS growth_GDP_recap
FROM t_tuul_bittnerova_project_SQL_primary_final a
LEFT JOIN t_tuul_bittnerova_project_SQL_primary_final b 
	ON a.category_code = b.category_code
	AND a.wages_year = b.wages_year + 1
LEFT JOIN t_tuul_bittnerova_project_SQL_secondary_final c 
	ON a.wages_year = c.`year`
LEFT JOIN t_tuul_bittnerova_project_SQL_secondary_final d
	ON a.wages_year= d.`year` + 1
	AND c.country = d.country 
WHERE a.industry_branch_code IS NULL 
	AND a.wages_year > 2006
	AND c.country = 'Czech Republic'
GROUP BY a.price_year 
;