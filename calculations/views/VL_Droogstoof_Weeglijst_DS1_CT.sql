CREATE VIEW dbo.VL_Droogstoof_Weeglijst_DS1_CT
AS
SELECT        PrjCod, ObjCod, Jar, Wek,  [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo]
FROM            (SELECT        PrjCod, ObjCod, Jar, Wek, DrgStfGkg, Dag
                          FROM            dbo.VL_Droogstoof_Weeglijst_DS1) AS P PIVOT (max(DrgStfGkg) FOR Dag IN ([Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo])) AS pvt       
