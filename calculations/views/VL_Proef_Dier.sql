CREATE VIEW dbo.VL_Proef_Dier
AS
SELECT        P.PrfCod, dbo.T_Proef.PrfNam, P.BehCod, P.Blk, P.DieNum, RIGHT('0000' + CAST(dbo.T_Animals.AnimalNo AS varchar(4)), 4) AS OorNum, 
                         CAST(dbo.T_Animals.AnimalNo AS int) AS OorNumGet, dbo.T_Animals.RegistrationId AS LevNum, P.BegDat, P.EndDat
FROM            dbo.T_Proef INNER JOIN
                         dbo.T_Proef_Dier AS P ON dbo.T_Proef.PrfCod = P.PrfCod INNER JOIN
                         dbo.T_Animals ON P.DieNum = dbo.T_Animals.AnimalServerID
