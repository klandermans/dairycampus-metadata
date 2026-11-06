CREATE VIEW dbo.VL_Dier_Datum_Hok_Melkcontrole
AS
SELECT        TOP (100) PERCENT S.Jar, S.Wek, S.Hok, AVG(DATEDIFF(day, S.GebDat, GETDATE()) * 1.0 / 365.25) AS LftJar, AVG(M.Mlk) AS Expr1, AVG(M.Vet) AS Expr2, AVG(M.Eiw) 
                         AS Expr3, AVG(M.Lac) AS Expr4, AVG(M.Ket) AS Expr5, AVG(M.Ure) AS Expr6
FROM            dbo.VL_Dier_Datum_Stal AS S LEFT OUTER JOIN
                         dbo.VL_Dier_Datum_Melkcontrole AS M ON S.Dat = M.Dat AND S.DieNum = M.DieNum
GROUP BY S.Jar, S.Wek, S.Hok
ORDER BY S.Jar, S.Wek, S.Hok
