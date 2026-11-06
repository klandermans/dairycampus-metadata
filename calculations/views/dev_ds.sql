CREATE view dev_ds as 

WITH OpdrachtCTE AS (
    SELECT 
        filename, 
        SUM(performedproductkgafterdrop) AS total 
    FROM 
        t_raw_trioliet 
    WHERE 
        receptname IS NOT NULL
    GROUP BY 
        filename
),
LosLaadCTE AS (
    SELECT 
        los.filename, 
        los.date, 
        los.subgroupnr AS ric, 
        los.performedproductkgatstop AS LOS, 
        laad.ingredientname, 
        laad.performedproductkgafterdrop AS laad, 
        laad.performedproductkgafterdrop / opdracht.total AS pctingredient, 
        los.performedproductkgatstop * (laad.performedproductkgafterdrop / opdracht.total) AS kgingredient
    FROM 
        t_raw_trioliet los
    LEFT JOIN 
        t_raw_trioliet laad ON los.filename = laad.filename AND laad.receptname IS NOT NULL
    LEFT JOIN 
        OpdrachtCTE opdracht ON los.filename = opdracht.filename
    WHERE 
        los.receptname IS NULL 
        AND los.subgroupnr > 0
)
SELECT 
    date, 
    ric, 
    ingredientname, 
    SUM(kgingredient) AS total_kgingredient
FROM 
    LosLaadCTE
    where ric=40 and date='2022-03-01'
GROUP BY 
    date, 
    ric, 
    ingredientname;
