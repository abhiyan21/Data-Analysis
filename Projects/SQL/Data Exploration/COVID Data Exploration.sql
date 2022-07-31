-- QUERY01
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
ORDER BY 1, 2


-- QUERY02
-- TOTAL CASES VS TOTAL DEATHS
SELECT location, date, population, total_cases, total_deaths
FROM CovidDeaths
WHERE location = 'Belgium' -- WHERE location IN( 'United States', 'Afghanistan'), if two or more values
ORDER BY 1, 2


-- QUERY03
-- COUNTRIES WITH HIGHEST INFECTION RATE
SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS InfectedPopulationPercentage
FROM CovidDeaths
GROUP BY location, population
ORDER BY InfectedPopulationPercentage DESC


-- QUERY04
-- HIGHEST DEATH COUNT PER TOTAL POPULATION PER COUNTRY
SELECT location, MAX(CAST(total_deaths as int)) AS TotalDeathCount -- CASTed to change into INT type from VARCHAR
FROM CovidDeaths
WHERE continent is not NULL
GROUP BY location
ORDER BY TotalDeathCount DESC


-- QUERY05
-- DEATHS BY CONTINENTS
SELECT continent, MAX(CAST(total_deaths as int)) AS TotalDeathCount -- CASTed to change into INT type from VARCHAR
FROM CovidDeaths
WHERE continent is not NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC


-- QUERY06
-- TOTAL CASES AND DEATHS BY GLOBAL GLOBAL BASIS
SELECT SUM(new_cases) AS TotalCases, SUM(cast(new_deaths as int)) AS TotalDeaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 AS DeathPercentage
FROM CovidDeaths
WHERE continent is not NULL
ORDER BY 1,2
 

 -- QUERY07
 -- NUMBER OF VACCINATIONS
SELECT d.continent, d.location, d.date, population, v.new_vaccinations,
SUM(CONVERT(int, v.new_vaccinations)) OVER
(PARTITION BY d.location
ORDER BY d.location, d.date) AS TotalVaccination
FROM CovidDeaths d
JOIN CovidVaccinations v
	ON d.date = v.date
	AND d.location = v.location
WHERE d.continent is not NULL
ORDER BY 2, 3


-- QUERY08
-- USING COMMON TABLE EXPRESSION FROM QUERY07
WITH POPvsVAC(Continent, location, date, population, newVaccinations, totalVaccinations)
AS(
SELECT d.continent, d.location, d.date, population, v.new_vaccinations,
SUM(CONVERT(int, v.new_vaccinations)) OVER
(PARTITION BY d.location
ORDER BY d.location, d.date) AS TotalVaccinations
FROM CovidDeaths d
JOIN CovidVaccinations v
	ON d.date = v.date
	AND d.location = v.location
WHERE d.continent is not NULL
)
SELECT *, (TotalVaccinations/population)*100 AS TotalPercentVaccinated
FROM POPvsVAC

-- QUERY09
-- USING TEMP TABLE FROM QUERY07
DROP Table IF exists #TotalPercentVaccinated
Create Table #TotalPercentVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
NewVaccinations numeric,
TotalVaccinations numeric
)

INSERT INTO #TotalPercentVaccinated
SELECT d.continent, d.location, d.date, population, v.new_vaccinations,
SUM(CONVERT(int, v.new_vaccinations)) OVER
(PARTITION BY d.location
ORDER BY d.location, d.date) AS TotalVaccinations
FROM CovidDeaths d
JOIN CovidVaccinations v
	ON d.date = v.date
	AND d.location = v.location

SELECT *, (TotalVaccinations/Population)*100 AS TotalPercentVaccinated
FROM #TotalPercentVaccinated

-- QUERY10
-- CREATE VIEWS
CREATE VIEW VP AS
SELECT d.continent, d.location, d.date, population, v.new_vaccinations,
SUM(CONVERT(int, v.new_vaccinations)) OVER
(PARTITION BY d.location
ORDER BY d.location, d.date) AS TotalVaccination
FROM CovidDeaths d
JOIN CovidVaccinations v
	ON d.date = v.date
	AND d.location = v.location
WHERE d.continent is not NULL

SELECT * FROM VP