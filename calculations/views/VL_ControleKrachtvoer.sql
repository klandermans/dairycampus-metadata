CREATE VIEW [dbo].[VL_ControleKrachtvoer]
AS
SELECT        
    Dat.PrfCod, 
    Dat.BehCod, Dat.Dat, Dat.DieNum, 
    Dat.OorNum, Dat.OorNumGet, Opn.PrcCom, 
    Opn.VoeNum, 
    Opn.PrtNam, 
    Opn.VoeGft as Kg, 
    CAST(DATEDIFF(day, Opn.Dat, GETDATE()) * - 1 AS varchar(2)) + 'G' AS Dag
FROM            
    dbo.VL_Dier_Voeropname_KV AS Opn 
RIGHT OUTER JOIN
    dbo.VL_Dier_Datum_Proef AS Dat ON Opn.Dat = Dat.Dat AND Opn.DieNum = Dat.DieNum
WHERE        
    (Opn.Dat > GETDATE() - 8)
UNION
SELECT        
    Dat.PrfCod, 
    Dat.BehCod, 
    Dat.Dat, 
    Dat.DieNum, 
    Dat.OorNum, 
    Dat.OorNumGet, 
    Opn.PrcCom, 
    Opn.VoeNum, 
    Opn.PrtNam, 
    Opn.VoeRst AS Kg, 
    CAST(DATEDIFF(day, Opn.Dat, GETDATE()) * - 1 AS varchar(2)) + 'R' AS Dag
FROM            
    dbo.VL_Dier_Voeropname_KV AS Opn 
RIGHT OUTER JOIN
    dbo.VL_Dier_Datum_Proef AS Dat ON Opn.Dat = Dat.Dat AND Opn.DieNum = Dat.DieNum
WHERE        
    (Opn.Dat > GETDATE() - 8)




