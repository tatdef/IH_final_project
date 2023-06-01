CREATE DATABASE IF NOT EXISTS civictech;
USE civictech;

SHOW TABLES;
DESCRIBE people;

SELECT geoCountryName, geoLocationName 
FROM people
GROUP BY geoCountryName, geoLocationName;

SELECT birthDate, count(birthDate) FROM people 
GROUP BY birthDate; 
-- it counts nulls as just 1 occurrence ? 

SELECT industryName, count(industryName) from people
GROUP BY industryName
ORDER BY count(industryName) DESC ;

SELECT exp1_honors, count(exp1_honors) from people
GROUP BY exp1_honors
ORDER BY count(exp1_honors) DESC ;

DESCRIBE companies_finance;

SELECT chiffre_daffaires_e FROM companies_finance;

ALTER TABLE companies_finance
MODIFY COLUMN chiffre_daffaires_e bigint;

/*ALTER TABLE table_name
DROP COLUMN column_name; 

ALTER TABLE table_name
MODIFY COLUMN column_name datatype; 
