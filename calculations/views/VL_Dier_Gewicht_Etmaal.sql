CREATE VIEW [dbo].[VL_Dier_Gewicht_Etmaal]
AS
-- code van bert (5 seconden)
-- SELECT  
--     AnimalServerID AS DieNum, 
--     CAST(CAST(WeighDateDT as DATE) as DATETIME) as Dat,        
--     sum(IIF(datepart(hh, WeighDateDT)<12, 1,0)) AS AntGewO, 
--     avg(IIF(datepart(hh, WeighDateDT)<12, 1,null)) AS GewO, 
--     sum(IIF(datepart(hh, WeighDateDT)>=12, 1,0)) AS AntGewA, 
--     avg(IIF(datepart(hh, WeighDateDT)>=12, 1,null)) AS GewA
-- FROM  dbo.TB_Animal_AnimalWeighings
-- GROUP BY  
--     AnimalServerID, 
--     CAST(CAST(WeighDateDT as DATE) as DATETIME) ;

-- code van Hans van de Heuvel 10 seconden na de subqierues die ik al had aangepast)
SELECT        GewO.DieNum, GewO.Dat, GewO.GewCnt AS AntGewO, GewO.Gew AS GewO, GewA.GewCnt AS AntGewA, GewA.Gew AS GewA
FROM            dbo.VL_Dier_Gewicht_Ochtend AS GewO LEFT OUTER JOIN
                         dbo.VL_Dier_Gewicht_Avond AS GewA ON GewO.DieNum = GewA.DieNum AND GewO.Dat = GewA.Dat
UNION
SELECT        GewA.DieNum, GewA.Dat, GewO.GewCnt AS AntGewO, GewO.Gew AS GewO, GewA.GewCnt AS AntGewA, GewA.Gew AS GewA
FROM            dbo.VL_Dier_Gewicht_Ochtend AS GewO RIGHT OUTER JOIN
                         dbo.VL_Dier_Gewicht_Avond AS GewA ON GewO.DieNum = GewA.DieNum AND GewO.Dat = GewA.Dat




