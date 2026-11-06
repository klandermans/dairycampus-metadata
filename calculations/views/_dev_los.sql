
CREATE view [dbo].[_dev_los] as     
select 
    filename, 
    date,
    --    CAST(CAST(DATEADD(HH, +6, date+CAST(TAKEOFFTIME AS DATETIME)) AS DATE) AS DATETIME) AS [date] , 
 
    subgroupnr,
    cast(performedproductkgatstop as real) as performedproductkgatstop

from t_raw_trioliet where logsource=1
-- and performedproducterror=performedproductkgafterdrop
