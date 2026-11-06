CREATE VIEW [dbo].[VL_Dier_Datum_Proef]
-- with schemabinding
AS
    SELECT        
        D.Dat, 
        dbo.eu_jaar(D .Dat) AS Jar, 
        dbo.eu_week(D .Dat) AS Wek, 
        dbo.DagNam(DATEPART(dw, D .Dat)) AS WekDag, 
        P.PrfCod, 
        P.BehCod, 
        P.HrhNum, 
        P.Blk, 
        P.DieNum, 
        dbo.T_Animals.RegistrationId AS LevNum, 
        
        -- L.OorNum,
        T_Animals.animalno as OorNum,

        L.OorNumGet, P.BegDat AS BegDatPrf, 
        P.EndDat AS EndDatPrf, 
        dbo.T_Animals.BirthDateDT AS GebDat, 
        DATEDIFF(day, dbo.T_Animals.BirthDateDT, D .Dat) AS LftDgn, 
        L.LacNum, 
        L.KlfDat, DATEDIFF(day, L.KlfDat, D .Dat) AS LacDgn, 
        L.InsDat, 
        L.DrgZetDat,
        L.VrwKlfDat, 
        L.VlgKlfDat, 
        DATEDIFF(day, D .Dat, L.VrwKlfDat) AS VrwDgn, 
        IIF(L.DrgZetDat <= D.Dat, 'Droog', iif(lacnum=0,'Pink','Melk')) AS PrdSta, 
        dbo.T_LogboekNOK.MlkNOK, 
        dbo.T_LogboekNOK.KVNOK, 
        dbo.T_LogboekNOK.RVNOK, 
        dbo.T_LogboekNOK.GewNOK

    FROM dbo.T_Proef_Dier AS P 
    INNER JOIN dbo.T_Datum AS D ON P.BegDat <= D .Dat AND ISNULL(P.EndDat, GETDATE()) >= D .Dat 
    LEFT JOIN dbo.VL_Dier_Lactatie AS L ON P.DieNum = L.DieNum AND D .Dat <= L.EinDat AND D .Dat >= L.KlfDat 
    INNER JOIN dbo.T_Animals ON P.DieNum = dbo.T_Animals.AnimalServerID 
    LEFT OUTER JOIN dbo.T_LogboekNOK ON D .Dat = dbo.T_LogboekNOK.Dat





