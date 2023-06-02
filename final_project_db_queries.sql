CREATE DATABASE IF NOT EXISTS civictech;

/* the database tables are created through python mysql alchemy module*/ 

USE civictech;

SHOW TABLES;
DESCRIBE people;

SELECT geoCountryName, geoLocationName 
FROM people
GROUP BY geoCountryName, geoLocationName;


SELECT industryName, count(industryName) from people
GROUP BY industryName
ORDER BY count(industryName) DESC ;

SELECT languages_stated, count(languages_over2) from people
GROUP BY languages_stated ;

DESCRIBE companies_finance;

SELECT avg(chiffre_daffaires_e), max(chiffre_daffaires_e), min(chiffre_daffaires_e) 
FROM companies_finance;

SELECT activite, count(activite) FROM companies_info
GROUP BY activite 
ORDER BY count(activite) DESC;

SELECT effectif, count(effectif) FROM companies_info
GROUP BY effectif 
ORDER BY count(effectif) DESC;

SELECT unnamed, inscription_au_rcs, creation, activite, adresse FROM companies_info
WHERE inscription_au_rcs LIKE '%RADIE%' ;

SELECT forme_juridique, count(forme_juridique) FROM companies_info
GROUP BY forme_juridique 
ORDER BY count(forme_juridique) DESC;

SELECT domaine_dactivite, activite_principale_declaree, count(domaine_dactivite) FROM companies_info
GROUP BY domaine_dactivite, activite_principale_declaree
ORDER BY count(domaine_dactivite) DESC;

SELECT code_naf_ou_ape, count(code_naf_ou_ape) FROM companies_info
GROUP BY code_naf_ou_ape 
ORDER BY count(code_naf_ou_ape) DESC;

/*ALTER TABLE table_name
DROP COLUMN column_name; 

ALTER TABLE table_name
MODIFY COLUMN column_name datatype; 
