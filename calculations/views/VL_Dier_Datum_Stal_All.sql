create VIEW [dbo].[VL_Dier_Datum_Stal_All]
AS
SELECT        
    Dat.Dat, 
    dbo.eu_jaar(Dat.Dat) AS Jar, 
    dbo.eu_week(Dat.Dat) AS Wek, 
    DATEPART(dw, Dat.Dat) AS WekDag, 
    Stal.Stl, 
    Stal.Hok, 
    Stal.DieNum, 
    Ani.RegistrationId AS LevNum, Stal.OorNum, 
    CAST(Stal.OorNum AS int) AS OorNumGet, 
    Stal.BegDat, Stal.EndDat, 
    Ani.BirthDateDT AS GebDat, DATEDIFF(day, 
    Ani.BirthDateDT, Dat.Dat) AS LftDgn, 
    Lac.LacNum, 
    Lac.KlfDat, DATEDIFF(day, Lac.KlfDat, Dat.Dat) AS LacDgn, 
    Lac.InsDat, Lac.DrgZetDat, Lac.VrwKlfDat, 
    DATEDIFF(day, Dat.Dat, Lac.VrwKlfDat) AS VrwDgn, 
    IIF(Lac.DrgZetDat <= Dat.Dat, 'Droog', iif(lacnum=0,'Pink','Melk')) AS PrdSta, 
    [Log].MlkNOK, 
    [Log].KVNOK, 
    [Log].RVNOK, 
    [Log].GewNOK

FROM dbo.T_LogboekNOK AS [Log] 
RIGHT OUTER JOIN 
    dbo.T_Datum AS Dat ON [Log].Dat = Dat.Dat 
CROSS JOIN 
    dbo.VL_Dier_Stal AS Stal 
INNER JOIN 
    dbo.T_Animals AS Ani ON Stal.DieNum = Ani.AnimalServerID 
LEFT OUTER JOIN 
    dbo.VL_Dier_Lactatie AS Lac ON Stal.DieNum = Lac.DieNum

WHERE 
    (Dat.Dat BETWEEN Stal.BegDat 
    AND ISNULL(Stal.EndDat, GETDATE())) 
    AND (Dat.Dat BETWEEN birthdate AND ISNULL(Lac.EinDat, GETDATE())) 
    AND (Stal.Stl IS NOT NULL) 
    AND (Stal.Hok IS NOT NULL) 
    AND (Stal.Stl <> '') AND (Stal.Hok <> '')








