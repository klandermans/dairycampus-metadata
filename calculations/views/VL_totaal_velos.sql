-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO
CREATE view [dbo].[VL_totaal_velos] WITH SCHEMABINDING as  

     SELECT  
     
            DATEADD(MINUTE, nr.number, [date]) as [dt],
            cow,
            [type]

    FROM (
        select
            ([date] AT TIME ZONE 'UTC' AT TIME ZONE 'Central European Standard Time' ) as [date],
            cow,
            duration/60 as duration, 
            [type]
        from 
            dbo.t_raw_velos_behaviour
        where cow > 0 and duration<300
        
    ) as velos
    LEFT JOIN (
        SELECT TOP (1440) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as number
    FROM dbo.t_datum a
    CROSS JOIN  dbo.t_datum b
        
    ) as nr ON (nr.Number <= duration)