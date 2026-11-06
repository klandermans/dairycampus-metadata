CREATE VIEW [dbo].[VL_Dier_Gewicht_Ochtend]
AS
-- code van hans van de heuvel ( 8 seconden 444759)
SELECT        AnimalServerID AS DieNum, AnimalNo AS OorNum, CAST(AnimalNo AS int) AS OorNumGet, CAST(datefromparts(DATEPART(yyyy, WeighDateDT), DATEPART(mm, 
                         WeighDateDT), DATEPART(dd, WeighDateDT)) AS datetime) AS Dat, dbo.OchtendAvond(WeighDateDT) AS DagOA, COUNT(Weight) AS GewCnt, ROUND(AVG(Weight), 0) 
                         AS Gew
FROM            dbo.TB_Animal_AnimalWeighings
WHERE        (dbo.OchtendAvond(WeighDateDT) = 'O')
GROUP BY AnimalServerID, AnimalNo, CAST(AnimalNo AS int), datefromparts(DATEPART(yyyy, WeighDateDT), DATEPART(mm, WeighDateDT), DATEPART(dd, WeighDateDT)), 
                         dbo.OchtendAvond(WeighDateDT)

-- -- Code van Bert 19-09-2019 0 sec 444759
-- SELECT        
--     AnimalServerID AS DieNum, 
--     AnimalNo AS OorNum, 
--     CAST(AnimalNo AS int) AS OorNumGet, 
--     cast(cast(WeighDateDT as date) as datetime) as Dat,
--     'O' AS DagOA, 
--     COUNT(Weight) AS GewCnt, 
--     ROUND(AVG(Weight), 0)  AS Gew
-- FROM
--     dbo.TB_Animal_AnimalWeighings
-- WHERE        
--     datepart(hh, WeighDateDT)< 12     
-- GROUP BY 
--     AnimalServerID, 
--     AnimalNo, 
--     CAST(AnimalNo AS int), 
--     cast(cast(WeighDateDT as date) as datetime) 



