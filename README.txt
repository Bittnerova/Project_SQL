Pr�vodn� listina- ENGETO Projekt SQL

C�lem Engeto SQL projektu bylo vytvo�it 7 sql soubory a odpov�d�t na 5 vyty�en�ch ot�zek. Nejd��ve 
jsem vytvo�ila 2 SQL tabulky s n�zvy: 
      1. t_tuul_bittnerova_projekt_SQL_primary_final.sql
      2. t_tuul_bittnerova_projekt_SQL_secondary_final.sql

Tabulka 1. t_tuul_bittnerova_projekt_SQL_primary_final.sql

V prvn�m a druh�m dotazu byla vybr�na po�adovan� data, se kter�mi budu pracovat. Na z�klad� 
t�chto dotaz� vytvo��m 2 pohledy, tyto pohledy pak budu spojovat a vytvo��m tabulku.
Pro vytvo�en� 1. tabulky t_tuul_bittnerova_projekt_SQL_primary_final.sql byly vybr�ny n�sleduj�c� 
sloupce:
Z tabulky czechia_payroll -> value, payroll_year, industry_branch_code. Je po��t�no s 
calculation_code 200 pro mzdy na cel� �vazky.
Z tabulky czechia_payroll_industry_branch vybr�ny sloupce->industry_branch_code, name. 
D�le tabulky czechia_payroll_industry_branch a czechia_payroll jsou spojeny p�es jednoho 
spole�n�ho typu sloupku (industry_branch_code X code), a byl ulo�en jako pohled s n�zvem 
tb_project_wages.
Z tabulky czechia_price -> value, code, date_from. V tabulce czechia_price u sloupc� date_from byl 
zm�n�n datov� typ na YEAR.
Z tabulky czechia_price_category ->name, code. Pot� tabulky czechia_price a czechia_price_category
byly spojeny p�es jednoho spole�n�ho typu sloupku (category_code X code), a byl ulo�en jako pohled 
s n�zvem tb_project_price. Data jsou seskupeny podle roku a podle k�du odv�tv�.
Pohledy tb_project_price a tb_project_wages byly spojeny pomoci Joinu.

Tabulka t_tuul_bittnerova_project_SQL_secondary_final.sql

Na dal�� tabulku t_tuul_bittnerova_projekt_SQL_secondary_final.sql byly vybr�ny 1 sloupec z tabulky 
countries (country) a 3 sloupce z tabulky economies (year, GDP, population). Tabulky byly propojen� 
p�es sloupec country.

