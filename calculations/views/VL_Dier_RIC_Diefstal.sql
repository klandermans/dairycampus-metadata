CREATE VIEW dbo.VL_Dier_RIC_Diefstal
AS
SELECT        P.PrfCod, P.BehCod, P.Dat, P.DieNum, P.OorNumGet, ROUND(SUM(M.Opn), 1) AS SumOpn, ROUND(MAX(M.Opn), 1) AS MaxOpn, SIGN(SUM(M.Opn) - MAX(M.Opn)) 
                         AS Dief, ROUND(SUM(M.Opn) - MAX(M.Opn), 1) AS DiefOpn, ROUND(100 * (SUM(M.Opn) - MAX(M.Opn)) / SUM(M.Opn), 0) AS DiefPct
FROM            dbo.TVL_RIC_Dier_Opname_Mengsel AS M RIGHT OUTER JOIN
                         dbo.TVL_Dier_Datum_Proef AS P ON M.Dat = P.Dat AND M.DieNum = P.DieNum
WHERE        (M.Opn > 0)
GROUP BY P.OorNumGet, P.Dat, P.DieNum, P.PrfCod, P.BehCod
