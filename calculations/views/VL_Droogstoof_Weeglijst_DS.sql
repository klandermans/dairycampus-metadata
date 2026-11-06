CREATE VIEW dbo.VL_Droogstoof_Weeglijst_DS
AS
SELECT        TOP (100) PERCENT L.DatSes, L.PrjCod, L.VlgNum, L.ObjCod, L.DatMon, ROUND(AVG(L.DrgStfGkg), 1) AS DrgStfGkg, dbo.DagNam(DATEPART(weekday, L.DatMon)) 
                         AS WekDag
FROM            dbo.T_Droogstoof_WeegSessie AS S INNER JOIN
                         dbo.T_Droogstoof_WeegLijst AS L ON S.PrjCod = L.PrjCod AND S.DatSes = L.DatSes AND S.VlgNum = L.VlgNum
GROUP BY L.PrjCod, L.DatSes, L.VlgNum, L.DatMon, L.ObjCod
