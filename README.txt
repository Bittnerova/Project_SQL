Prùvodní listina- ENGETO Projekt SQL

Cílem Engeto SQL projektu bylo vytvoøit 7 sql soubory a odpovìdìt na 5 vytyèených otázek. Nejdøíve 
jsem vytvoøila 2 SQL tabulky s názvy: 
      1. t_tuul_bittnerova_projekt_SQL_primary_final.sql
      2. t_tuul_bittnerova_projekt_SQL_secondary_final.sql

Tabulka 1. t_tuul_bittnerova_projekt_SQL_primary_final.sql

V prvním a druhým dotazu byla vybrána požadovaná data, se kterými budu pracovat. Na základì 
tìchto dotazù vytvoøím 2 pohledy, tyto pohledy pak budu spojovat a vytvoøím tabulku.
Pro vytvoøení 1. tabulky t_tuul_bittnerova_projekt_SQL_primary_final.sql byly vybrány následující 
sloupce:
Z tabulky czechia_payroll -> value, payroll_year, industry_branch_code. Je poèítáno s 
calculation_code 200 pro mzdy na celé úvazky.
Z tabulky czechia_payroll_industry_branch vybrány sloupce->industry_branch_code, name. 
Dále tabulky czechia_payroll_industry_branch a czechia_payroll jsou spojeny pøes jednoho 
spoleèného typu sloupku (industry_branch_code X code), a byl uložen jako pohled s názvem 
tb_project_wages.
Z tabulky czechia_price -> value, code, date_from. V tabulce czechia_price u sloupcù date_from byl 
zmìnìn datový typ na YEAR.
Z tabulky czechia_price_category ->name, code. Poté tabulky czechia_price a czechia_price_category
byly spojeny pøes jednoho spoleèného typu sloupku (category_code X code), a byl uložen jako pohled 
s názvem tb_project_price. Data jsou seskupeny podle roku a podle kódu odvìtví.
Pohledy tb_project_price a tb_project_wages byly spojeny pomoci Joinu.

Tabulka t_tuul_bittnerova_project_SQL_secondary_final.sql

Na další tabulku t_tuul_bittnerova_projekt_SQL_secondary_final.sql byly vybrány 1 sloupec z tabulky 
countries (country) a 3 sloupce z tabulky economies (year, GDP, population). Tabulky byly propojený 
pøes sloupec country.

