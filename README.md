# Civic tech who's who 
Using data analysis to understand people and organizations in the civic tech sector in France. 
An Ironhack final project for data analysis full time - 2023, Paris, 0410. 

**Steps:**
1. Data collection 
2. Database construction 
3. Data analysis 
4. Data visualisation 
5. Data modeling and prediction 

**Contents of the repository:**
1. Profiles : Python notebook for transforming jsons to a pandas dataframe, people general information, education and experience datasets
2. Organizations : Python notebook for transforming htmls to a pandas dataframe, finance and general information datasets
3. EDA directory : Python data analysis notebook and a few figures 
4. SQL : Python notebook for producing and exporting tables to SQL (and tables as csvs), sql script for querying, ERD as image
5. Modeling : 2 Python notebooks for making appropriate databases from json files, 2 Python notebooks for Random Forest Classifier testing and evaluation according to different parameters (based on NLP - vectorizing), and datasets 
And at home : 
* this readme.md file, 
* the gitignore file
* the Ironhack project report for certification 
* the Ironhack project slides for certification 


>License information:
>This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/)  


  
# How it went : 

## From data collection to database construction 

### Scraping linkedin profiles and companies data - 2.5 days
* Using [Tom Quirk's scraper](https://github.com/tomquirk/linkedin-api) to get individual linkedin pages and adapting the code to produce readable json files (thanks @Thomas) 
* Writing code to turn the json files into dataframes which can be modified and analyzed in python
* Getting companies data from Pappers
* Writing code to turn html files into dataframes which can be modified and analyzed in Python 
* 2nd collection round to increase the number of individuals in dataset (people & organizations), using R code to collect the linked profile urls for the new people identified. 

### Data cleaning and building database tables - 2.5 days 
* initial outline of tables, keys, variables and relationships 
* cleaning data and recoding columns/categories for individuals 
* cleaning data and recoding columns/categories for companies 
* splitting data points into different tables (anonymizing solution)

### SQL entity-relation model and tables - 1 day
* export tables to SQL
* define relationships and keys 
* describe database
* write initial queries
* ERD with different tables 

> BONUSES 
>* improve the scraper to return the previous experience information 
>* keep increasing the dataset
>* write code to automate the collection of data from the Pappers website

## Data analysis 

### Python Exploratory Data Analysis - 1 day 
* check and plot feature distributions with histograms 
* checking for outliers
* identifying correlations in numeric columns 

### Data visualization with Tableau - 0.5 day
* Geographical data cleaning and visualization 

### SQL Querying - 0.5 day 
* Education table exploration 
* Combining companies' tables 
* Combining people's education with companies' information 

## Modeling/ prediction 

### Re-creating database  
* People database cleaning
* Preprocessing (missing values, feature selection, )
* setting y for categorical prediction : industry ? 
* NLP vectorizing preparation 

### Model selection, testing and evaluation 
* selection of model : Random Forest Classifier 
* Parameter tuning (manual, gridsearch)
* handling imbalance 
* Testing vectorizer parameters and NLP options (stop words, stemming, TF-IDF)
* Evaluation/ scoring 
* Second iteration with a more complete database including additional information 

> BONUSES  
>* changing y : civic tech yes/no ?
>* next company recommender (nearest neighbors) 
>* modeling on companies data & combination of datasets : clustering options, company prediction
>* Expanding beyond civic tech 
>* Careers analysis 
>* Networks analysis 
>* MCA/ state of the field 

## Project management - 2 days  
* updating the readme file and kanban in Trello 
* creating and updating github repo 
* defining gitignore to avoid sharing personal data 
* report writing 
* slides for presentation

> BONUSES : 
>* review and beautify repo, code, sql queries files
