

/*czechia_payroll=> 
 * 			value, 
 * 			payroll_year, 			
 * 			industry_branch_code
 */
 -- průměrná roční mzda: avg_wages= průměrná mzda počítané období
 -- prev_avg_wages =>průměrná mzda předchozí období

SELECT 
	 ROUND(AVG(cpay.value),2) AS avg_wages,
	 LAG(AVG(cpay.value)) OVER (PARTITION BY cpay.industry_branch_code ORDER BY cpay.payroll_year) AS prev_avg_wages,
	 cpay.industry_branch_code ,
	 cpay.payroll_year AS year_wages
FROM czechia_payroll cpay
WHERE cpay.value_type_code = 5958
	AND cpay.calculation_code = 200
GROUP BY cpay.industry_branch_code,
	cpay.payroll_year 
ORDER BY cpay.payroll_year,
cpay.industry_branch_code ;

-- Průměrné roční ceny produktů 
/*
 * czechia_price=> category_code
 * 					value ,
 * 					date_from
 */

SELECT 
	ROUND(AVG(cp.value),2) AS avg_value,
	cp.category_code ,
	YEAR (cp.date_from) AS year_price
FROM czechia_price cp
WHERE cp.region_code IS NULL 
GROUP BY cp.category_code ,
	YEAR (cp.date_from);


-- roční průměrná mzda jednotlivých odvětví
	 
CREATE VIEW IF NOT EXISTS tb_project_wages AS 
SELECT 
	ROUND(AVG(cpay.value),2) AS avg_wages,
	cpay.industry_branch_code ,
	cpib.name AS industry_name,
	cpay.payroll_year AS wages_year
FROM czechia_payroll cpay
LEFT JOIN czechia_payroll_industry_branch cpib 
	ON cpay.industry_branch_code = cpib.code 
WHERE cpay.value_type_code = 5958
	AND cpay.calculation_code =200
GROUP BY cpay.industry_branch_code , cpay.payroll_year 
ORDER BY cpay.payroll_year, cpay.industry_branch_code ;

SELECT 
	*
FROM tb_project_wages;

-- roční průměrné ceny produktů

CREATE VIEW IF NOT EXISTS tb_project_price AS 
SELECT 
	ROUND(AVG(cp.value),2) AS avg_price,
	cp.category_code ,
	YEAR (cp.date_from) AS price_year,
	cpc.name AS food_name,
	CONCAT(cpc.price_value,'', cpc.price_unit ) AS units
FROM czechia_price cp
JOIN czechia_price_category cpc 
	ON cp.category_code = cpc.code 
WHERE cp.region_code IS NULL 
GROUP BY cp.category_code , YEAR (cp.date_from);

SELECT 
	*
FROM tb_project_price;

SELECT 
	*
FROM tb_project_wages;


CREATE OR REPLACE TABLE  t_tuul_bittnerova_project_SQL_primary_final AS 
SELECT 
	*
FROM tb_project_price tbpp
JOIN tb_project_wages tbpw
	ON tbpp.price_year = tbpw.wages_year ;

SELECT 
	*
FROM t_tuul_bittnerova_project_SQL_primary_final a;


	


