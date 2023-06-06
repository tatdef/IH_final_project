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
>* clean notebooks

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

### Creating database for prediction model 
* People database 
* clean education 
* deal with missing values 
* setting y for categorical prediction : civic tech or not ? next company ? 
* civic tech list 
* model research, selection/ testing and evaluation 
* prediction fine tuning 

> BONUSES  
>* Expanding beyond civic tech 
>* Careers analysis 
>* Networks analysis 
>* MCA/ state of the field 
>* cleaning SQL query code 

## Project management - 2 days  
* updating the readme file and kanban in Trello 
* creating and updating github repo 
* defining gitignore to avoid sharing personal data 
* report writing 
* slides for presentation TO DO 
