CREATE view [dbo].[bert_relifestock] as  
   
    SELECT 
        
        
        kgmlketm * (0.337 + (0.116 * [MPR_WEEK.FAT_CONCENTRATION]) + (0.06 * [MPR_WEEK.PROTEIN_CONCENTRATION])) AS fcpm,       

        TVL_totaal_bedrijf.*
    FROM 
        [dbo].[TVL_totaal_bedrijf] 
    LEFT JOIN (
        SELECT 
            AVG(thi) AS THI, datum  
        FROM 
            t_raw_knmi 
        GROUP BY 
            DATUM
    ) AS TTT ON dat = DATUM 
    where  hok in ('70','71','72','73','60','61') and CAST(Dat AS DATE)>'2022-01-01'
-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO

-- ALTER view [dbo].[bert_relifestock] as SELECT 

--     AVG(a.thi) OVER (
--         PARTITION BY a.animalserverid, a.lacnum 
--         ORDER BY a.dat 
--         ROWS BETWEEN 3 PRECEDING AND CURRENT ROW
--     ) AS thi_rolling_7_days_prev,
    
--      AVG(a.fcpm) OVER (
--         PARTITION BY a.animalserverid, a.lacnum 
--         ORDER BY a.dat 
--         ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
--     ) AS fcpm_rolling_7_days_prev,
    
--     -- 7-day rolling average forward (next 7 days, excluding current day)
--     AVG(a.fcpm) OVER (
--         PARTITION BY a.animalserverid, a.lacnum 
--         ORDER BY a.dat 
--         ROWS BETWEEN 1 FOLLOWING AND 7 FOLLOWING
--     ) AS fcpm_rolling_7_days_next,

--      AVG(a.kgmlketm) OVER (
--         PARTITION BY a.animalserverid, a.lacnum 
--         ORDER BY a.dat 
--         ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
--     ) AS kgmlketm_rolling_7_days_prev,
    
--     -- 7-day rolling average forward (next 7 days, excluding current day)
--     AVG(a.kgmlketm) OVER (
--         PARTITION BY a.animalserverid, a.lacnum 
--         ORDER BY a.dat 
--         ROWS BETWEEN 1 FOLLOWING AND 7 FOLLOWING
--     ) AS kgmlketm_rolling_7_days_next,
    
--     -- 7-day rolling average forward (next 7 days, excluding current day)
--     AVG(a.[mpr_week.Scc]) OVER (
--         PARTITION BY a.animalserverid, a.lacnum 
--         ORDER BY a.dat 
--         ROWS BETWEEN 1 FOLLOWING AND 14 FOLLOWING
--     ) AS scc_rolling_14_days_next

--     ,
--     nullif(AVG(a.fcpm) OVER (
--         PARTITION BY a.animalserverid, a.lacnum 
--         ORDER BY a.dat 
--         ROWS BETWEEN 1 FOLLOWING AND 7 FOLLOWING
--     ),0)/

--       nullif(AVG(a.fcpm) OVER (
--         PARTITION BY a.animalserverid, a.lacnum 
--         ORDER BY a.dat 
--         ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
--     ) ,0) as [fcpmratio],

--     nullif(AVG(a.kgmlkEtm) OVER (
--         PARTITION BY a.animalserverid, a.lacnum 
--         ORDER BY a.dat 
--         ROWS BETWEEN 1 FOLLOWING AND 7 FOLLOWING
--     ),0)

--     /
    
--     nullif(AVG(a.kgmlkEtm) OVER (
--         PARTITION BY a.animalserverid, a.lacnum 
--         ORDER BY a.dat 
--         ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
--     ) ,0) as [kgmlkEtmRatio],

--     a.* 

-- FROM (
    
--     SELECT 
        
--         THI, 
--         kgmlketm * (0.337 + (0.116 * [MPR_WEEK.FAT_CONCENTRATION]) + (0.06 * [MPR_WEEK.PROTEIN_CONCENTRATION])) AS fcpm,       
        
--         TVL_totaal_bedrijf.*
--     FROM 
--         [dbo].[TVL_totaal_bedrijf] 
--     LEFT JOIN (
--         SELECT 
--             AVG(thi) AS THI, datum  
--         FROM 
--             t_raw_knmi 
--         GROUP BY 
--             DATUM
--     ) AS TTT ON dat = DATUM 
-- ) AS a 
-- WHERE fcpm IS NOT NULL

--   and hok<>'sikk' and hok<>'2car' and hok <>'caru'

-- ;
-- GO
