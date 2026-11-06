CREATE VIEW [dbo].[VL_Dier_Gewicht_Avond]
AS
--  Code van Hans, deed er 8 seconden over
SELECT        AnimalServerID AS DieNum, AnimalNo AS OorNum, CAST(AnimalNo AS int) AS OorNumGet, CAST(datefromparts(DATEPART(yyyy, WeighDateDT), DATEPART(mm, 
                         WeighDateDT), DATEPART(dd, WeighDateDT)) AS datetime) AS Dat, dbo.OchtendAvond(WeighDateDT) AS DagOA, COUNT(Weight) AS GewCnt, ROUND(AVG(Weight), 0) 
                         AS Gew
FROM            dbo.TB_Animal_AnimalWeighings
WHERE        (dbo.OchtendAvond(WeighDateDT) = 'A')
GROUP BY AnimalServerID, AnimalNo, CAST(AnimalNo AS int), datefromparts(DATEPART(yyyy, WeighDateDT), DATEPART(mm, WeighDateDT), DATEPART(dd, WeighDateDT)), 
 dbo.OchtendAvond(WeighDateDT)


-- code van bert (0 sec)
-- SELECT        
--     AnimalServerID AS DieNum, 
--     AnimalNo AS OorNum, 
--     CAST(AnimalNo AS int) AS OorNumGet, 
--     cast(cast(WeighDateDT as date) as datetime) as Dat,
--     'A' AS DagOA, 
--     COUNT(Weight) AS GewCnt, 
--     ROUND(AVG(Weight), 0)  AS Gew
-- FROM
--     dbo.TB_Animal_AnimalWeighings
-- WHERE        
--     datepart(hh, WeighDateDT)>= 12     
-- GROUP BY 
--     AnimalServerID, 
--     AnimalNo, 
--     CAST(AnimalNo AS int), 
--     cast(cast(WeighDateDT as date) as datetime) 



