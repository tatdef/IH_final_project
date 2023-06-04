
CREATE DATABASE IF NOT EXISTS civictech;
DROP TABLE associations_info, companies_finance, companies_info, education, names, experience, people, people_experience;

/* the database tables are created through python mysql alchemy module*/ 

USE civictech;
SHOW TABLES;

DESCRIBE associations_info; 
/* asso_id(int) 
categorical : association_name(text), effectif(text), 
binary : inscription_rna(category : 1 or 0) 
datetime : creation(datetime), , date_inscr(datetime)
text : adresse(text), objet_de_lassociation(text)*/

DESCRIBE companies_info;
/*company_id (int), companyname(text)
category : activite(category), effectif(text), forme_juridique(category),code_naf_ou_ape(category), domaine_dactivite(text), greffe(category - location of registration - city)
category - binary : inscription_rcs(category 1=inscrit or 0=radie)
datetime : creation,  date_inscr_rad(inscription ou radiation), 
numeric : capital_social(int)
text : adresse, activite_principale_declaree, directors (names of directors separated by commas). 
-- effectif could be combined with effectif in people_experience, or cleaned in the same way  */

SELECT activite, count(activite) FROM companies_info
GROUP BY activite 
ORDER BY count(activite) DESC;

SELECT effectif, count(effectif) FROM companies_info
GROUP BY effectif 
ORDER BY count(effectif) DESC;

SELECT forme_juridique, count(forme_juridique) FROM companies_info
GROUP BY forme_juridique 
ORDER BY count(forme_juridique) DESC;

SELECT domaine_dactivite, count(domaine_dactivite) FROM companies_info
GROUP BY domaine_dactivite
ORDER BY count(domaine_dactivite) DESC;

SELECT code_naf_ou_ape, count(code_naf_ou_ape) FROM companies_info
GROUP BY code_naf_ou_ape 
ORDER BY count(code_naf_ou_ape) DESC;


DESCRIBE companies_finance;
/* IDs : company_year_ide (int) specific to this table
company(text)== companyname in companies_info
 all columns are integers - to be analyzed */

SELECT company, avg(chiffre_daffaires_e), max(chiffre_daffaires_e), min(chiffre_daffaires_e) 
FROM companies_finance
GROUP BY company
ORDER BY avg(chiffre_daffaires_e) DESC;


DESCRIBE people;
/* ID : ind_id (common to people, people_experience, people_education, people_names) 
categorical columns : geoCountryName, geoLocationName, industryName
categorical (binary): languages_over2, honors_stated, publications_stated, projects_stated, volunteer_stated, certifications_stated, languages_stated
categorical (0 to 5): consulting_roles, direction_roles, founding_roles
text columns : summary, headline, experience, education, languages, publications, certifications, volunteer, honors, projects. All include dictionaries.
split text columns : experience1 (to 5), education1 (to 3). Include a single dictionary. 
TEXT columns could be dropped for sql */ 

SELECT geoCountryName, geoLocationName, sum(founding_roles), sum(direction_roles), sum(consulting_roles)
FROM people
GROUP BY geoCountryName, geoLocationName;

SELECT geoLocationName, count(languages_over2)
FROM people
GROUP BY geoLocationName;

SELECT geoCountryName, geoLocationName 
FROM people
GROUP BY geoCountryName, geoLocationName;

SELECT geoCountryName, industryName, count(industryName) from people
GROUP BY geoCountryName, industryName
ORDER BY geoCountryName, count(industryName) DESC ;

SELECT languages_stated, count(languages_over2) from people
GROUP BY languages_stated ;

DESCRIBE people_experience;
/* IDs = experience_id (specific to this table), ID : ind_id (common to people, people_experience, people_education, people_names), can be repeated up to 5 times here. 
categorical columns : locationName, companyName, industry 
categorical (binary) columns : title_direction, titleconsulting, titlefounder (for each experience) 
dates : startDate_month, startDate_year, endDate_month, endDate_year (for each experience)
number of employees ranges between company_employees_low and company_employees_high
text columns : description, title*/

SELECT industry, count(industry)
FROM people_experience
GROUP BY industry
ORDER BY count(industry) DESC;


DESCRIBE people_education;
/* THIS TABLE IS NOT CLEAN BUT MAY BE USED ANYWAY, WITH %LIKE% FUNCTION

ID : ind_id (common to people, people_experience, people_education, people_names) 
text - but readable: degreeName, schoolName, fieldOfStudy (lower everything to help)
pure text : school -- could be dropped
date: startDate_year 
*/

SELECT schoolName, count(schoolName) 
FROM people_education
GROUP BY schoolName DESC;

SELECT schoolName, count(schoolName) 
FROM people_education
WHERE schoolName LIKE '%Sciences Po%' OR schoolName LIKE '%IEP%' or schoolName LIKE "%Institut d'Etudes Politiques%"
GROUP BY schoolName
ORDER BY count(schoolName) DESC;

SELECT schoolName, startDate_year, count(startDate_year) 
FROM people_education
WHERE schoolName LIKE '%Sciences Po%' OR schoolName LIKE '%IEP%' or schoolName LIKE "%Institut d'Etudes Politiques%"
GROUP BY schoolName, startDate_year
ORDER BY count(startDate_year) DESC, startDate_year DESC;




/*ALTER TABLE table_name
DROP COLUMN column_name; 

ALTER TABLE table_name
MODIFY COLUMN column_name datatype; 
