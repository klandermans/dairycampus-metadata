CREATE view [dbo].[_dev_ingredient_per_bak_per_batch] as     
select 
    los.filename as filename, 
    los.date, 
    los.subgroupnr as ric, 
    avg(totalLaad) as totallaad, 
    avg(totalLos) as totalLos, 
    sum(los.performedproductkgatstop) as totalLosInBak,
    laad.ingredientname, 
    avg(laad.performedproductkgafterdrop) as laadProduct,
    -- avg(laad.performedproductkgafterdrop)/avg(totallaad) as pctingredient,
   CASE 
        WHEN AVG(totallaad) = 0 THEN 0 
        ELSE AVG(laad.performedproductkgafterdrop) / AVG(totallaad) 
    END AS pctingredient,
    CAST(los.performedproductkgatstop AS REAL) * 
    CASE 
        WHEN AVG(totallaad) = 0 THEN 0 
        ELSE CAST(AVG(laad.performedproductkgafterdrop) / AVG(totallaad) AS REAL)
    END AS kgingredient
from 
    _dev_los as los
left join 
    _dev_laad as laad on los.filename=laad.filename
left join 
    _dev_batch as opdracht on los.filename=opdracht.filename

group by 
      los.filename
    , los.subgroupnr
    , los.date
    , laad.ingredientname 
    , los.performedproductkgatstop 
 