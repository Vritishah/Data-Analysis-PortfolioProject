select *
from [Portfolio Project].dbo.CovidDeaths
where continent is not null
order by 3,4

select *
from [Portfolio Project].dbo.CovidVaccinations
order by 3,4

select location, date, population, total_cases, new_cases, total_deaths
from [Portfolio Project].dbo.CovidDeaths
order by 1,2

select location, date, total_cases, total_deaths, (cast(total_deaths as float)/total_cases)*100 as DeathPercentage
from [Portfolio Project].dbo.CovidDeaths
order by 1,2

select location, date, total_cases, total_deaths,
case 
when total_cases = 0 Then NULL
Else (CAST(total_deaths AS float) / total_cases) * 100
END AS DeathPercentage
from [Portfolio Project].dbo.CovidDeaths
where location like 'India'
order by 1,2

select location, date, population, total_cases, (total_cases /population)*100 as CovidCasesPercentage
from [Portfolio Project].dbo.CovidDeaths
--where location like 'India'
order by 1,2

select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases /population))*100 as CovidCasesPercentage
from [Portfolio Project].dbo.CovidDeaths
--where location like 'India'
group by location, population
order by CovidCasesPercentage desc

select location, MAX(cast(total_deaths as int)) as TotalDeathCount
from [Portfolio Project].dbo.CovidDeaths
--where location like 'India'
where continent is not null
group by location
order by TotalDeathCount desc

select location, MAX(cast(total_deaths as int)) as TotalDeathCount
from [Portfolio Project].dbo.CovidDeaths
--where location like 'India'
where continent is null
group by location
order by TotalDeathCount desc

select date, sum(new_cases) as NewCases, sum(new_deaths) as Newdeaths
from [Portfolio Project].dbo.CovidDeaths
where continent is not null
group by date
order by 1,2

select sum(new_cases) as NewCases, sum(new_deaths) as NewDeaths, sum(new_deaths)/sum(new_cases)*100 as GlobalDeathPercentage
from [Portfolio Project].dbo.CovidDeaths
--where location like 'India'
where continent is not null
--group by date
order by 1,2

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from [Portfolio Project].dbo.CovidDeaths Dea
join [Portfolio Project].dbo.CovidVaccinations Vac
on Dea.location = Vac.location
and Dea.date = Vac.date
where dea.continent is not null
order by 2,3

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location,
dea.date) as RollingPeopleVaccinated
from [Portfolio Project].dbo.CovidDeaths Dea
join [Portfolio Project].dbo.CovidVaccinations Vac
on Dea.location = Vac.location
and Dea.date = Vac.date
where dea.continent is not null
order by 2,3

--With CTE

with PopVsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location,
dea.date) as RollingPeopleVaccinated
from [Portfolio Project].dbo.CovidDeaths Dea
join [Portfolio Project].dbo.CovidVaccinations Vac
on Dea.location = Vac.location
and Dea.date = Vac.date
where dea.continent is not null
--order by 2,3
)
select *, (RollingPeopleVaccinated/population)*100
from PopVsVac

--With Temp Table

Drop table if exists #PercentagePeopleVaccinated
create Table #PercentagePeopleVaccinated
(
continent nvarchar(250),
location nvarchar(250),
date datetime, 
population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentagePeopleVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location,
dea.date) as RollingPeopleVaccinated
from [Portfolio Project].dbo.CovidDeaths Dea
join [Portfolio Project].dbo.CovidVaccinations Vac
on Dea.location = Vac.location
and Dea.date = Vac.date
where dea.continent is not null

select *, (RollingPeopleVaccinated/population)*100
from #PercentagePeopleVaccinated