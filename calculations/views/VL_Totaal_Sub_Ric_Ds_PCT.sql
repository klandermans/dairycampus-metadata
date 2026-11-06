
-- deze view laat de samenstelling van de drogestof zien.
CREATE view [dbo].[VL_Totaal_Sub_Ric_Ds_PCT] as 
select 
    date, 
    groupname,
    ingredientname ,     
    (SUM(performedproductdryweightkgafterdrop) / NULLIF(SUM(SUM(performedproductdryweightkgafterdrop)) OVER (PARTITION BY date, groupname), 0)) * 100 AS Pct, 
    sum(performedproductdryweightkgafterdrop)/sum(PerformedProductKgAfterDrop) as DsTrio
FROM (select * from dbo.t_raw_trioliet where not (ingredientname='water' and performedproducterror=performedproductkgafterdrop)) as t_raw_trioliet

group by date, groupname, ingredientname
having sum(performedproductdryweightkgafterdrop) > 0
