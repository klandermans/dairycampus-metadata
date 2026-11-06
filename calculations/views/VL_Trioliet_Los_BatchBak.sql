CREATE VIEW dbo.VL_Trioliet_Los_BatchBak
AS
SELECT        Dat, MngNam, OpdID, dbo.UuMm(DatTyd) AS Tyd, Bak, ROUND(MngKgPln, 1) AS MngKgPln, ROUND(MngKgRea, 1) AS MngKgRea, ROUND(MngKgRea - MngKgPln, 1) 
                         AS MngKgVrs
FROM            dbo.T_Bedrijf_Voermengsel_Los
