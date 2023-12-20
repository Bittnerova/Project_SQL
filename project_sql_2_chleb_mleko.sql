-- Tuul Bittnerová Projekt 1 úkol 2
/*
 * Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období 
v dostupných datech cen a mezd.
 */
-- category_code: 114201=Mléko polotučné pasterované, 111301= chléb konzumní kmínový


SELECT *
FROM t_tuul_bittnerova_project_SQL_primary_final 
WHERE price_year IN (2006, 2018)
	AND (category_code = '114201' OR category_code = '111301');
	
SELECT 
	avg_wages,
	industry_name ,
	wages_year ,
	avg_price ,
	food_name ,	
	ROUND(avg_wages / avg_price) AS purchase_power
FROM t_tuul_bittnerova_project_SQL_primary_final
WHERE wages_year IN (2006, 2018)
	AND (category_code = '114201' OR category_code='111301')
	AND industry_branch_code IS NULL;


SELECT 
	avg_wages,
	industry_name ,
	wages_year ,
	avg_price ,
	food_name ,	
	ROUND(avg_wages / avg_price) AS purchase_power 
FROM t_tuul_bittnerova_project_SQL_primary_final
WHERE wages_year IN (2006, 2018)
	AND (category_code = '114201' OR category_code='111301')
GROUP  BY avg_wages,industry_name , wages_year ,
	avg_price ,food_name
ORDER BY purchase_power ;















