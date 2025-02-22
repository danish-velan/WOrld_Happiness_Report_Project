SELECT * FROM [World Happiness Report Dataset];
 

 --Dropping unwanted columns\
 ALTER TABLE [World Happiness Report Dataset]
 DROP COLUMN [Standard_error_of_ladder_score];

 ALTER TABLE [World Happiness Report Dataset]
 DROP COLUMN [upperwhisker],[lowerwhisker],[Ladder_score_in_Dystopia],[Dystopia_residual],
 [Explained_by_Log_GDP_per_capita],[Explained_by_Social_support],[Explained_by_Healthy_life_expectancy],[Explained_by_Freedom_to_make_life_choices],
 [Explained_by_Generosity],[Explained_by_Perceptions_of_corruption];


 --Renaming the column name (in sqlserver we cant use Alter table command)
EXEC sp_rename 
    '[dbo].[World Happiness Report Dataset].[Logged_GDP_per_capita]',  -- The full path to the column you want to rename
    'Logged_GDP_per_capital',  -- The new name for the column
    'COLUMN';  -- Specify that you're renaming a column


 --Now lets keep the value limited after the decimal point in each column..
 update [World Happiness Report Dataset]
set 
[Ladder_score] = ROUND([Ladder_score], 2),
[Logged_GDP_per_capital] = Round([Logged_GDP_per_capital],2),
[Social_support]=Round([Social_support],2),
[Healthy_life_expectancy]=Round([Healthy_life_expectancy],2),
[Freedom_to_make_life_choices]=ROUND([Freedom_to_make_life_choices],2),
[Generosity]=Round([Generosity],2),
[Perceptions_of_corruption]=Round([Perceptions_of_corruption],2);


-- Now to check if there is any null columns in the entire table
SELECT COLUMN_NAME,  -- This selects the name of each column from the table.
COUNT(*) AS TotalRows,  -- Counts the total number of rows in the table (should return the same number for every column).
-- This part counts how many NULL values are present in each column.
-- CASE WHEN checks if the value is NULL, and if it is, it counts 1; otherwise, it counts 0.
SUM(CASE WHEN COLUMN_NAME IS NULL THEN 1 ELSE 0 END) AS NullCount  
FROM INFORMATION_SCHEMA.COLUMNS  -- This system view contains metadata about all the columns in the database.

-- Filtering the result to only include the columns from the specified table.
WHERE TABLE_NAME = 'World Happiness Report Dataset'  

-- Grouping the results by each column name to count NULLs separately for every column.
GROUP BY COLUMN_NAME;  


SELECT * FROM [World Happiness Report Dataset];


-- What is the maximum happiness score across all countries? (using subbqueries)
Select Country_name,Ladder_score as Happiest_Country from [World Happiness Report Dataset]
where Ladder_score = (select MAX(Ladder_score) from [World Happiness Report Dataset]);

--what is the minimum score across all countries (using subbqueries)
Select Country_name,Ladder_score as [Country_With_Least_Happiness] from [World Happiness Report Dataset]
where Ladder_score = (select MIN(Ladder_score) from [World Happiness Report Dataset]);


--what is the Average score across all countries (using subbqueries)
SELECT TOP 1 Country_name, Ladder_score AS Country_With_Average_Happiness
FROM [World Happiness Report Dataset]
ORDER BY ABS(Ladder_score - (SELECT AVG(Ladder_score) FROM [World Happiness Report Dataset])) ASC

--What are the top 5 countries with the highest happiness scores?
select Top 5 Country_name, Ladder_score as Top_5_highest_country from [World Happiness Report Dataset]
Order by Ladder_score desc;


SELECT * FROM [World Happiness Report Dataset];


--Which counrty have a Highest freedom to make life choices ?
Select Top 1 Country_name,Freedom_to_make_life_choices from [World Happiness Report Dataset]
order by Freedom_to_make_life_choices Desc;




