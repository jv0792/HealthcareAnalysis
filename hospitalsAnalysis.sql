create DATABASE healthmgt;
use healthmgt;

select * from hospitals;

#list of columns
desc hospitals;

select count(*) as 'Total Rows' from hospitals;

#Number of Unique Hospitals 
select count(distinct(FacilityName)) as 'Count of Hospitals'
from hospitals;

#Counting number of Hospitals within each state.
select FacilityState,
count(*) as 'Total Number of Hospitals' 
from hospitals
group by FacilityState
order by `Total Number of Hospitals` desc;

#listing types of hospitals and showing the counts
select 
distinct(FacilityType) as 'Type',
count(*) as 'Counts'
from hospitals
group by FacilityType
order by `Counts` desc;

#checking for null values
select * 
from hospitals
where FacilityName is null;

#checking hosital with overall rating -1
select FacilityName, RatingOverall
from hospitals
where RatingOverall < 0;

#Total number of hospital by count against the ratings
select RatingOverall,
count(*) as 'Counts'
from hospitals
group by RatingOverall
order by `Counts` desc;

#checking the ProcedureHeart AttackCost across different states
select FacilityState,
round(avg(ProcedureHeartAttackCost), 2) as 'Avg Cost HA',
sum(ProcedureHeartAttackCost) as 'Total Sum of Cost HA',
round(avg(ProcedureHeartFailureCost), 2) as 'Avg Cost HF',
sum(ProcedureHeartFailureCost) as 'Total Sum of Cost HF',
round(avg(ProcedurePneumoniaCost), 2) as 'Avg Cost PC',
sum(ProcedurePneumoniaCost) as 'Total Sum of Cost PC',
round(avg(ProcedureHipKneeCost), 2) as 'Avg Cost HK',
sum(ProcedureHipKneeCost) as 'Total Sum of Cost HK'
from hospitals
group by FacilityState
order by 
sum(ProcedureHeartAttackCost) desc,
sum(ProcedureHeartFailureCost) desc,
sum(ProcedurePneumoniaCost) desc,
sum(ProcedureHipKneeCost) desc;

#counts based on the state level
select ProcedurePneumoniaQuality,
FacilityState,
count(*) as 'Counts'
from hospitals
group by ProcedurePneumoniaQuality, FacilityState
order by `Counts` desc;

select 
    FacilityState,
    sum(case when ProcedurePneumoniaQuality = 'Average' then 1 else 0 END) as AverageCount,
    sum(case when ProcedurePneumoniaQuality = 'Higher' then 1 else 0 END) as HigherCount,
    sum(case when ProcedurePneumoniaQuality = 'Unknown' then 1 else 0 end) as UnknownCount,
    sum(case when ProcedurePneumoniaQuality = 'Lower' then 1 else 0 end) as LowerCount
from hospitals
group by FacilityState
order by `HigherCount` desc;



