-- SQL project, Exploratory Data Analysis

-- Data: https://www.kaggle.com/datasets/swaptr/layoffs-2022

-- Cleaned the Data in other SQL file

SELECT *
FROM layoofs_staging2;

-- Look at the largest amount laid off and the largest percentage laid off
-- Percentage_laid_off = 1 means whole company was laid off
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

-- Show all companies that were laid off and order by the ones that had the most funding
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- Looking into the total number a company has laid off over covid
SELECT company, SUM(total_laid_off) sum_laid_off
FROM layoffs_staging2
GROUP BY company
ORDER BY sum_laid_off DESC;

-- Look into which industry laid off the most over covid
SELECT industry, SUM(total_laid_off) sum_laid_off
FROM layoffs_staging2
GROUP BY industry
ORDER BY sum_laid_off DESC;

-- Look into which icountry laid off the most over covid
SELECT country, SUM(total_laid_off) sum_laid_off
FROM layoffs_staging2
GROUP BY country
ORDER BY sum_laid_off DESC;

-- See the range of dates considered for this table
SELECT MIN(`date`),MAX(`date`)
FROM layoffs_staging2;

-- See layoffs per year
-- Note: Only three months of data for 2023 was considered
SELECT YEAR(`date`), SUM(total_laid_off) sum_laid_off
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

--  Sum of total laid off per month for every year
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7)
GROUP BY `MONTH`
ORDER BY 1 ASC;

WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7)
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`,SUM(total_off) OVER(ORDER BY `MONTH`)
FROM Rolling_Total;