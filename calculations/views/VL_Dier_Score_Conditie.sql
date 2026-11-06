CREATE VIEW dbo.VL_Dier_Score_Conditie
AS
SELECT        DieNum, Dat, Sco
FROM            dbo.T_Dier_Score
WHERE        (ScoCod = 'Conditie')
