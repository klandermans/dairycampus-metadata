CREATE VIEW dbo.VL_Droogstoof_Weeglijst_DS_CT
AS
SELECT        DatSes, PrjCod, VlgNum, ObjCod, [Di], [Wo], [Do], [Vr], [Za], [Zo], [Ma]
FROM            (SELECT      DatSes, PrjCod, VlgNum, ObjCod, DrgStfGkg, WekDag
                          FROM            dbo.VL_Droogstoof_Weeglijst_DS) AS P PIVOT (max(DrgStfGkg) FOR WekDag IN ( [Di], [Wo], [Do], [Vr], [Za], [Zo], [Ma])) AS pvt
