-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO
CREATE view [dbo].[_dev_ingredient_per_bak_per_batch_dag] as 
SELECT 
    date, 
    ric, 
    ingredientname, 
    SUM(COALESCE(kgingredient, 0)) AS kg,    
    SUM(COALESCE(kgingredient, 0)) / SUM(SUM(COALESCE(kgingredient, 0))) OVER (PARTITION BY date, ric) AS [percentage]
    
FROM 
    _dev_ingredient_per_bak_per_batch 
-- WHERE date='2024-01-01' AND ric=17
WHERE
kgingredient > 0 
and ric IS NOT NULL
    
GROUP BY 
    date, 
    ric, 
    ingredientname

-- order by ric
