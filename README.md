# Final ironhack project
Using data analysis to understand people and organizations in the civic tech sector in France. 

**Steps:**
1. Data collection 
2. Database construction 
3. Data analysis 
4. Data visualisation 
5. Data modeling and prediction 

**Deadlines :**
* June 5 : report for RNCP certification 
* June 7 : completion of project for in-class presentation 
* June 9 : jury day 

# How it's going : 

## Initializing : from data scraping to database construction 

### Scraping linkedin profiles and companies data - 2/2 days - tuesday may 30
* Using [Tom Quirk's scraper](https://github.com/tomquirk/linkedin-api) to get individual linkedin pages and adapting the code to produce readable json files (thanks @Thomas) 
* Writing code to turn the json files into dataframes which can be modified and analyzed in python
* scraping companies data from Pappers

Bonus : improve the scraper to return the previous experience information 
**Bonus 2: increase the dataset**

### Building a database - 2 days 
* initial outline of tables, keys, variables and relationships 
* recoding for individuals 
* recoding for companies 
* Run R script to get new individual linkedIn urls
* anonymizing solution 

### SQL entity-relation model and tables 2 days - friday june 2
* create tables in SQL
* write initial queries
* identify relationships and keys 
* describe database
* check data quality (missing, outliers, correlations, features)

### Database refining // data analysis 2 days - sunday june 4
* Identify the list of organizations we want to focus us (partly done)
* ERD with different tables
* Data cleaning for analysis : building categories, encoding... 
* Initial visualization tries in Python

### Report writing - 0.5 days 

## Data analysis and visualization - 0.5 days 
* Produce better visualisations with Python
* Get a couple visualisations from Tableau (geographical data )

## Improvements - 0.5 days  
* check github gitignore function to be able to open the repo
* add collected jsons and htmls 
* Streamline the process to collect linkedin pages for individuals and organizations 
* automate collection of information for companies/ NGOs
* civic tech list 

BY JUNE 5 
Planning of your project in Trello/Jira,
Code in Python for data collection and cleaning,
ER model,
data sources and metadata,
database script,
report (10 pages).

## Datavisualization - 1 day - tuesday 
* People and organizations (Tableau)
* Careers *optional*
* Networks *optional*
* PCA/ state of the field *optional*
* Analyse (cor)relations and networks 

## Data modeling - 1 day - wednesday 
* defining X and Y 
* model research, selection/ testing and evaluation 
* prediction fine tuning 

## Presentation - 1 day - thursday 
* preparing slides 
* beautifying code and github repo

