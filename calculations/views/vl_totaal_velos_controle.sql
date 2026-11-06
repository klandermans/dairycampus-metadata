CREATE view [dbo].[vl_totaal_velos_controle] as
select 
cast(dt as date) as 'date',
cow,
count(*) as total
, sum(iif( datepart(hh,[dt])=0,1,0)) as '0'
, sum(iif( datepart(hh,[dt])=1,1,0)) as '1'
, sum(iif( datepart(hh,[dt])=2,1,0)) as '2'
, sum(iif( datepart(hh,[dt])=3,1,0)) as '3'
, sum(iif( datepart(hh,[dt])=4,1,0)) as '4'
, sum(iif( datepart(hh,[dt])=5,1,0)) as '5'
, sum(iif( datepart(hh,[dt])=6,1,0)) as '6'
, sum(iif( datepart(hh,[dt])=7,1,0)) as '7'
, sum(iif( datepart(hh,[dt])=8,1,0)) as '8'
, sum(iif( datepart(hh,[dt])=9,1,0)) as '9'
, sum(iif( datepart(hh,[dt])=10,1,0)) as '10'
, sum(iif( datepart(hh,[dt])=11,1,0)) as '11'
, sum(iif( datepart(hh,[dt])=12,1,0)) as '12'
, sum(iif( datepart(hh,[dt])=13,1,0)) as '13'
, sum(iif( datepart(hh,[dt])=14,1,0)) as '14'
, sum(iif( datepart(hh,[dt])=15,1,0)) as '15'
, sum(iif( datepart(hh,[dt])=16,1,0)) as '16'
, sum(iif( datepart(hh,[dt])=17,1,0)) as '17'
, sum(iif( datepart(hh,[dt])=18,1,0)) as '18'
, sum(iif( datepart(hh,[dt])=19,1,0)) as '19'
, sum(iif( datepart(hh,[dt])=20,1,0)) as '20'
, sum(iif( datepart(hh,[dt])=21,1,0)) as '21'
, sum(iif( datepart(hh,[dt])=22,1,0)) as '22'
, sum(iif( datepart(hh,[dt])=23,1,0)) as '23'
from 
tvl_totaal_velos
where 
-- cast(dt as date)='2023-06-19'
-- and 
[type] is not null
group by cow, cast(dt as date)
having count(*) < 1400 or count(*) > 1500
