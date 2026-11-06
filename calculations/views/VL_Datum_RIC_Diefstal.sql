CREATE VIEW dbo.VL_Datum_RIC_Diefstal
AS
SELECT        PrfCod, BehCod, Dat, COUNT(OorNumGet) AS AntDier, SUM(Dief) AS AntDief, ROUND(AVG(SumOpn), 1) AS SumOpnGem, ROUND(AVG(MaxOpn), 1) AS MaxOpnGem, 
                         ROUND(AVG(DiefOpn), 1) AS DiefOpnGem, ROUND(MAX(DiefOpn), 1) AS DiefOpnMax, ROUND(AVG(DiefPct), 1) AS DiefPctGem, ROUND(MAX(DiefPct), 1) 
                         AS DiefPctMax
FROM            dbo.VL_Dier_RIC_Diefstal
GROUP BY Dat, PrfCod, BehCod
