CREATE DATABASE IF NOT EXISTS civictech;
/* the database tables are created through python mysql alchemy module*/ 

USE civictech;
SHOW TABLES;

DESCRIBE associations_info; 
/* asso_id(int) 
categorical : association_name(text), effectif(text), postcode
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

DESCRIBE companies_finance;
/* IDs : company_year_ide (int) specific to this table
company(text)== companyname in companies_info
 all columns are integers - to be analyzed */

DESCRIBE people;
/* ID : ind_id (common to people, people_experience, people_education, people_names) 
categorical columns : geoCountryName, geoLocationName, industryName
categorical (binary): languages_over2, honors_stated, publications_stated, projects_stated, volunteer_stated, certifications_stated, languages_stated
categorical (0 to 5): consulting_roles, direction_roles, founding_roles
text columns : summary, headline, experience, education, languages, publications, certifications, volunteer, honors, projects. All include dictionaries.
split text columns : experience1 (to 5), education1 (to 3). Include a single dictionary. 
TEXT columns could be dropped for sql */ 

DESCRIBE people_experience;
/* IDs = experience_id (specific to this table), ID : ind_id (common to people, people_experience, people_education, people_names), can be repeated up to 5 times here. 
categorical columns : locationName, companyName, industry 
categorical (binary) columns : title_direction, titleconsulting, titlefounder (for each experience) 
dates : startDate_month, startDate_year, endDate_month, endDate_year (for each experience)
number of employees ranges between company_employees_low and company_employees_high
text columns : description, title*/

DESCRIBE people_education;
/* although the table isn't clean yet, can be used with %like% function
ID : ind_id (common to people, people_experience, people_education, people_names) 
text - but readable: degreeName, schoolName, fieldOfStudy (lower everything to help)
pure text : school -- could be dropped
date: startDate_year 
*/

## FINAL QUERIES 

# 1 - IDENTIFYING ACTIVITY SECTORS 
SELECT activite, count(activite) FROM companies_info
GROUP BY activite 
ORDER BY count(activite) DESC
LIMIT 10;

# 2 - HOW MANY EMPLOYEES DO COMPANIES HAVE  
SELECT 
	CASE WHEN effectif LIKE '%0 salarié%' then "0"
		 WHEN effectif LIKE '%Au moins 1 salarié%' 
			OR effectif LIKE '%Entre 1 et 2%' 
			OR effectif LIKE '%Entre 3 et 5%' then "1 to 5"
         WHEN effectif LIKE '%Entre 6 et 9%' then "6 to 9"
         WHEN effectif LIKE '%Entre 10 et 19%' then "10 to 19"
		 ELSE "20 or more"
	END AS Number_employees, count(effectif) as count
FROM companies_info
GROUP BY Number_employees 
ORDER BY count(effectif) DESC;


# 3 - COMBINING COMPANY INFORMATION WITH COMPANY FINANCIAL INFORMATION 
WITH CA_compile AS (
SELECT  company, 
		avg(chiffre_daffaires_e) AS chiffre_affaires_moyen, 
        avg(salaires_et_charges_sociales_e) as couts_salariaux_moyens
FROM companies_finance
GROUP BY company)
SELECT 	ci.companyname, ci.creation, ci.inscription_rcs as RCS, ci.city AS ville, 
        ci.activite, cc.chiffre_affaires_moyen as CA_moyen, cc.couts_salariaux_moyens,
		CASE WHEN ci.effectif LIKE '%0 salarié%' then "0"
		 WHEN ci.effectif LIKE '%Au moins 1 salarié%' 
			OR ci.effectif LIKE '%Entre 1 et 2%' 
            OR ci.effectif LIKE '%Entre 3 et 5%' then "1 to 5"
         WHEN ci.effectif LIKE '%Entre 6 et 9%' then "6 to 9"
         WHEN ci.effectif LIKE '%Entre 10 et 19%' then "10 to 19"
		 ELSE "20 or more"
         END AS effectif
FROM companies_info ci
LEFT JOIN CA_compile cc ON ci.companyname = cc.company
ORDER BY cc.chiffre_affaires_moyen DESC;

# 4 -  REVIEW EDUCATION TABLE TO PRODUCE NEW CATEGORIES 
SELECT 
		CASE WHEN schoolName LIKE '%Sciences Po%' OR schoolName LIKE '%IEP%' 
                OR schoolName LIKE "%Institut d'Etudes Politiques%" 
                then "IEP"
			 WHEN schoolName LIKE '%Universi%' OR schoolName LIKE '%College%' 
                then "Université"
             WHEN schoolName LIKE '%School%' OR schoolName LIKE '%ESCP%' OR schoolName LIKE '%CELSA%' 
                OR schoolName LIKE '%school%' OR schoolName LIKE '%HEC%' OR schoolName LIKE '%ESSEC%' 
                OR schoolName LIKE '%Management%' OR schoolName LIKE '%INSEAD%' 
                then "Business school"
             WHEN schoolName LIKE '%journalism%' OR schoolName LIKE '%IFP%' 
				OR schoolName LIKE '%ESJ%' OR schoolName LIKE '%CFJ%' 
				then "Journalisme"
             WHEN schoolName LIKE '%Lycée%' OR schoolName LIKE '%Collège%' OR schoolName LIKE '%Prépa%'  
				then "Lycée ou CPGE"
             WHEN schoolName LIKE '%EPITECH%' OR schoolName LIKE '%ENSSAT%' OR schoolName LIKE '%Télécom%' 
				OR schoolName LIKE '%Polytech%' OR schoolName LIKE '%Mines%' 
				then "Ecole d'ingénieur"
             ELSE "Other"
	END AS school_type, count(fieldOfStudy) as count
FROM people_education
GROUP BY school_type 
ORDER BY count(fieldOfStudy) desc, school_type desc ;

# 5 - With these new categories, assess what type of diplomas people in direction positions have in different companies 
WITH new_education AS (
SELECT ind_id,
		CASE WHEN schoolName LIKE '%Sciences Po%' OR schoolName LIKE '%IEP%' 
                OR schoolName LIKE "%Institut d'Etudes Politiques%" 
                then "IEP"
			 WHEN schoolName LIKE '%Universi%' OR schoolName LIKE '%College%' 
                then "Université"
             WHEN schoolName LIKE '%School%' OR schoolName LIKE '%ESCP%' OR schoolName LIKE '%CELSA%' 
                OR schoolName LIKE '%school%' OR schoolName LIKE '%HEC%' OR schoolName LIKE '%ESSEC%' 
                OR schoolName LIKE '%Management%' OR schoolName LIKE '%INSEAD%' 
                then "Business school"
             WHEN schoolName LIKE '%journalism%' OR schoolName LIKE '%IFP%' 
				OR schoolName LIKE '%ESJ%' OR schoolName LIKE '%CFJ%' 
				then "Journalisme"
             WHEN schoolName LIKE '%Lycée%' OR schoolName LIKE '%Collège%' OR schoolName LIKE '%Prépa%'  
				then "Lycée ou CPGE"
             WHEN schoolName LIKE '%EPITECH%' OR schoolName LIKE '%ENSSAT%' OR schoolName LIKE '%Télécom%' 
				OR schoolName LIKE '%Polytech%' OR schoolName LIKE '%Mines%' 
				then "Ecole d'ingénieur"
             ELSE "Other"
	END AS school_type
FROM people_education 
)

SELECT pe.companyName, ne.school_type, count(ne.school_type)
FROM people_experience pe
LEFT JOIN new_education ne on pe.ind_id= ne.ind_id 
WHERE title_direction=1
GROUP BY pe.companyName, ne.school_type
ORDER BY count(ne.school_type) desc, companyName;


## COMPANIES 
SELECT activite, count(activite) FROM companies_info
GROUP BY activite 
ORDER BY count(activite) DESC
LIMIT 10;

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

SELECT company, max(annee)
##, chiffre_daffaires_e, salaires_et_charges_sociales_e, resultat_net_e, chiffre_daffaires_a_lexport_e as CA_export
from companies_finance
GROUP BY company;

SELECT company, avg(chiffre_daffaires_e), max(chiffre_daffaires_e), min(chiffre_daffaires_e) 
FROM companies_finance
GROUP BY company
ORDER BY avg(chiffre_daffaires_e) DESC;

### PEOPLE 

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

SELECT industry, count(industry)
FROM people_experience
GROUP BY industry
ORDER BY count(industry) DESC;

SELECT schoolName, count(schoolName) 
FROM people_education
GROUP BY schoolName DESC;

SELECT schoolName, count(schoolName) 
FROM people_education
WHERE schoolName LIKE '%Sciences Po%' OR schoolName LIKE '%IEP%' or schoolName LIKE "%Institut d'Etudes Politiques%"
GROUP BY schoolName
ORDER BY count(schoolName) DESC;

SELECT companyName, count(title_direction)
FROM people_experience
WHERE title_direction=1
GROUP BY companyName
ORDER BY count(title_direction) desc, companyName;





/*ALTER TABLE table_name
DROP COLUMN column_name; 


SELECT 
	country_name, 
	(births_attended_norm +parliament_norm+school_norm+lgbt_equality_index_normalized-fertility_norm) as composite_indicator
FROM gender1
where country_name like "U%"
ORDER BY composite_indicator desc;


ALTER TABLE table_name
MODIFY COLUMN column_name datatype; 
