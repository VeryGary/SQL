-- SQL project, Data Cleaning

-- Data: https://www.kaggle.com/datasets/swaptr/layoffs-2022

-- Data Cleaning is where you get it in a more usable format. Fixing alot of the issues in the raw 

SELECT *
FROM layoffs;

-- STEPS OF THIS PROJECT
-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values or Blank values
-- 4. Remove Any Columns Unnecessary

-- Will copy all the data from the tables to staging area
CREATE TABLE layoffs_staging
LIKE layoffs;

-- Look at staging table, will have just the column labels
SELECT *
FROM layoffs_staging;

-- Insert the data
-- Doing this because we will be changing the staging database a lot
INSERT layoffs_staging 
SELECT *
FROM layoffs;

-- STAGE 1 : Removing Duplicates

-- Make a table with everything and a column windowed function of 'row_num' that will have a 2 or above if theres a repeat
SELECT *, ROW_NUMBER() OVER(PARTITION BY company,location, industry, total_laid_off,percentage_laid_off, `date`,stage, country, funds_raised_millions) AS row_num 
FROM layoffs_staging;


-- Now will use CTE to make a subquery to show only those of row_num>=2, thus a duplicate
WITH duplicate_cte AS
(
	SELECT *, ROW_NUMBER() OVER(PARTITION BY company,location, industry, total_laid_off,percentage_laid_off, `date`,stage, country, funds_raised_millions) AS row_num 
	FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;
-- Cant do DELETE on CTEs, need to remake table since you cant update CTESs

-- Saw multiple duplicates, will double check my seeing repeats of 'Casper'
SELECT *
FROM layoffs_staging
WHERE company = 'Casper';

-- Create new staging table with row_num col
-- Got this from Right-Click Layoffs_stagin>copy to clipboard>create statement
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Now have empty table with labels
SELECT *
FROM layoffs_staging2;

-- Insert data into table
INSERT INTO layoffs_staging2
SELECT *, ROW_NUMBER() OVER(
PARTITION BY company,location, industry, total_laid_off,percentage_laid_off, `date`,stage, 
country, funds_raised_millions) AS row_num 
FROM layoffs_staging;

-- Now that its in a table, can delete duplicate rows
DELETE
FROM layoffs_staging2
WHERE row_num > 1;

-- Now that those are deleted this next query should return empty table
SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

-- STAGE 2 : Standardizing Data
-- Finding issues in the data and fixing it
-- Example, in the data, a company has a white space first before its name

-- Show companies and their trimmed counterparts
SELECT company, TRIM(company)
FROM layoffs_staging2;

-- Update the staging area company list so none of the names have white spaces around the name
UPDATE layoffs_staging2
SET company = TRIM(company);

-- Look at all distinct data for industries
-- Will notices blank spaces, NULL, Spaces missing in company names or shortened names, leading to repeats
-- Example of above is Crypto,CryptoCurrency,Crypto Currency
-- Order by 1, Which means order the first column
SELECT DISTINCT(industry)
FROM layoffs_staging2
ORDER BY 1;

-- Will look at Crypto related industries data, will notice most are simply called Crypto
SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

-- Update to make all Crypto industry labels the same
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Will Look at country label
-- Have issues like "United States."
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

-- Check if this query would fix it and compare
SELECT DISTINCT country, TRIM(TRAILING '.' from country)
FROM layoffs_staging2
ORDER BY 1;

-- Update table with fix
UPDATE layoffs_staging2
SET country= TRIM(TRAILING '.' from country)
WHERE country LIKE 'United States%';

-- Now want to fix date, its currently listed as text, need to change it 
SELECT `date`,STR_TO_DATE(`date`,'%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y');

-- Now will look at the update
-- In the schema, the data column still labeled as "text", need the change to format
SELECT `date`
FROM layoffs_staging2;

-- Change date column to Date format
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- STAGE 3: Null Values or Blank values

-- Will see which columns have NULL value for both total_laid_off and percentage_laid_off
-- With having both columns being NULL the row is fairly useless
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Show all industries that are NULL or blank
SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

-- Notice that some are just missing the label
-- Two Airbnb listings, one listed as "Trave", the other is blank, so can update these ones
SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

-- Will Compare companies with missing industry values to themselves if they already exist with a label for industry
-- This is so we know whill values we can fill in
SELECT t1.company,t1.location,t1.industry,t2.company,t2.location,t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company 
    AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry ='')
AND t2.industry IS NOT NULL;

-- First set all blanks to NULL to make it easier to update
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry ='';

-- Update Null values with proper labesl
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company 
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry ='')
AND t2.industry IS NOT NULL;

-- Confirming it worked
SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

-- Check to see if any industries are still NULL
-- Theres one, but is not listed any other times
SELECT *
FROM layoffs_staging2
WHERE industry IS NULL;

-- For the rest of the NULLS, like in total_laid_off, funds_raised, etc is harder to fill as we do not have enough info in this table

-- STAGE 4. Remove Any Columns Unnecessary

-- Once again, looking at those missing the total_laid_off and percentage_laid_off column
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Can remove as they add nothing to this table
DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Will now drop the row_num column we used earlier
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

-- Finalized Clean Data
SELECT *
FROM layoffs_staging2;
