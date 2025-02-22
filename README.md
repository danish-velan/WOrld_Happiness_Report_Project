🌍 World Happiness Report Data Analysis
This project explores the World Happiness Report Dataset using SQL Server to uncover insights about global happiness, economic factors, and social well-being. The dataset contains various indicators like GDP per capital, social support, and life expectancy for countries worldwide.

⚙️ Key SQL Queries Used
Importing and Viewing Data
SELECT * FROM [World Happiness Report Dataset];


Dropping Unwanted Columns
Removed irrelevant columns to simplify analysis.
ALTER TABLE [World Happiness Report Dataset]
DROP COLUMN [Standard_error_of_ladder_score], [upperwhisker], [lowerwhisker], 
[Ladder_score_in_Dystopia], [Dystopia_residual], [Explained_by_Log_GDP_per_capita], 
[Explained_by_Social_support], [Explained_by_Healthy_life_expectancy], 
[Explained_by_Freedom_to_make_life_choices], [Explained_by_Generosity], 
[Explained_by_Perceptions_of_corruption];


Renaming Columns
Used sp_rename for renaming a column in SQL Server.
EXEC sp_rename 
    '[dbo].[World Happiness Report Dataset].[Logged_GDP_per_capita]',  
    'Logged_GDP_per_capital',  
    'COLUMN';

    
Rounding Numeric Values
Rounded numerical columns to two decimal places for better readability.
UPDATE [World Happiness Report Dataset]
SET [Ladder_score] = ROUND([Ladder_score], 2),
    [Logged_GDP_per_capital] = ROUND([Logged_GDP_per_capital], 2),
    [Social_support] = ROUND([Social_support], 2),
    [Healthy_life_expectancy] = ROUND([Healthy_life_expectancy], 2),
    [Freedom_to_make_life_choices] = ROUND([Freedom_to_make_life_choices], 2),
    [Generosity] = ROUND([Generosity], 2),
    [Perceptions_of_corruption] = ROUND([Perceptions_of_corruption], 2);

    
Null Value Check
Verified if any columns had missing values.
SELECT COLUMN_NAME, COUNT(*) AS TotalRows, 
SUM(CASE WHEN COLUMN_NAME IS NULL THEN 1 ELSE 0 END) AS NullCount
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'World Happiness Report Dataset'
GROUP BY COLUMN_NAME;


Exploratory Data Analysis

Country with the highest happiness score:
SELECT Country_name, Ladder_score AS Happiest_Country
FROM [World Happiness Report Dataset]
WHERE Ladder_score = (SELECT MAX(Ladder_score) FROM [World Happiness Report Dataset]);


Country with the lowest happiness score:
SELECT Country_name, Ladder_score AS Country_With_Least_Happiness
FROM [World Happiness Report Dataset]
WHERE Ladder_score = (SELECT MIN(Ladder_score) FROM [World Happiness Report Dataset]);


Country closest to the average happiness score:
SELECT TOP 1 Country_name, Ladder_score AS Country_With_Average_Happiness
FROM [World Happiness Report Dataset]
ORDER BY ABS(Ladder_score - (SELECT AVG(Ladder_score) FROM [World Happiness Report Dataset])) ASC;


Top 5 happiest countries:
SELECT TOP 5 Country_name, Ladder_score AS Top_5_highest_country
FROM [World Happiness Report Dataset]
ORDER BY Ladder_score DESC;


Country with the highest freedom to make life choices:
SELECT TOP 1 Country_name, Freedom_to_make_life_choices
FROM [World Happiness Report Dataset]
ORDER BY Freedom_to_make_life_choices DESC;


📈 Key Insights
Identified the happiest and least happy countries based on the Ladder Score.
Highlighted countries with high freedom to make life choices.
Simplified and cleaned the dataset for better analysis.


🛠️ Technologies Used
SQL Server
T-SQL (Transact-SQL)
Data Cleaning and Exploratory Data Analysis


✅ Conclusion
This project demonstrates how SQL Server can be used for data exploration and analysis using real-world datasets. The findings from this dataset reveal global patterns in happiness, economic conditions, and social factors.









