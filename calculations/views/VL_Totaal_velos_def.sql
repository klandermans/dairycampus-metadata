CREATE view VL_Totaal_velos_def
 WITH SCHEMABINDING
  as   

SELECT 
    tb.[date], 
    tb.duration / 60 AS duration_in_minutes, 
    tb.cow, 
    tb.duration, 
    nr.number,  
    DATEADD(MINUTE, nr.number, tb.[date]) AS date2
FROM dbo.t_raw_velos_behaviour tb
LEFT JOIN (
    SELECT TOP (1440) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as number
FROM dbo.t_datum a
CROSS JOIN  dbo.t_datum b
    
) as nr ON (nr.Number <= (tb.duration / 60))
WHERE tb.cow > 0 



