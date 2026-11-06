CREATE VIEW [dbo].[VL_Dier_Melkgift_Etmaal_Melkcontrole]
AS
SELECT        
    dbo.VL_Dier_Melkgift_Etmaal.DieNum, 
    dbo.VL_Dier_Melkgift_Etmaal.Dat, 
    dbo.VL_Dier_Melkgift_Etmaal.AntMlkO, 
    dbo.VL_Dier_Melkgift_Etmaal.KgMlkO, 
    dbo.VL_Dier_Melkgift_Etmaal.AntMlkA, 
    dbo.VL_Dier_Melkgift_Etmaal.KgMlkA, 
    dbo.VL_Dier_Melkgift_Etmaal.KgMlkEtm, 
    dbo.VL_Dier_Datum_Melkcontrole.DatCon, 
    dbo.VL_Dier_Datum_Melkcontrole.DatGldTot, 
    dbo.VL_Dier_Datum_Melkcontrole.Mlk AS MlkCon, 
    dbo.VL_Dier_Datum_Melkcontrole.Vet, 
    dbo.VL_Dier_Datum_Melkcontrole.Eiw, 
    dbo.VL_Dier_Datum_Melkcontrole.Lac, 
    dbo.VL_Dier_Datum_Melkcontrole.Ket, 
    dbo.VL_Dier_Datum_Melkcontrole.Ure, 
    dbo.VL_Dier_Datum_Melkcontrole.Cel
FROM
    dbo.VL_Dier_Melkgift_Etmaal 
    LEFT OUTER JOIN dbo.VL_Dier_Datum_Melkcontrole 
    ON dbo.VL_Dier_Melkgift_Etmaal.DieNum = dbo.VL_Dier_Datum_Melkcontrole.DieNum 
    AND  dbo.VL_Dier_Melkgift_Etmaal.Dat = dbo.VL_Dier_Datum_Melkcontrole.Dat

