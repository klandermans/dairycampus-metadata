CREATE VIEW [dbo].[VL_Droogstoof_Weeglijst_DS1]
AS
SELECT        
    PrjCod, 
    ObjCod, 
    DatMon, 
    -- DATEPART(year, DatMon) AS Jar, 
    -- OMG >> please forgive me, year is returning a different value than iso_week (bert 03-01-2020)
    year(dateadd(day,+DATEPART(weekday, DatMon), datmon)) as Jar,
    DATEPART(iso_week, DatMon) AS Wek, 
    dbo.DagNam(DATEPART(weekday, DatMon)) AS Dag, 
    ROUND(AVG(DrgStfGkg), 1) AS DrgStfGkg
FROM            
    dbo.T_Droogstoof_WeegLijst
GROUP BY 
    PrjCod, 
    ObjCod, 
    DatMon, 
    year(dateadd(day,+DATEPART(weekday, DatMon), datmon)) , 
    DATEPART(iso_week, DatMon), 
    dbo.DagNam(DATEPART(weekday, DatMon))

