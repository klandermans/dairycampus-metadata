CREATE VIEW dbo.VL_Proef_Voerverbruik_TrioRIC
AS
SELECT        Trio.PrtNam, Trio.Jar, Trio.Wek, RIC.DieDag, ROUND(Trio.KgPrd, 1) AS KgPrdLaad, ROUND(Trio.KgDS, 1) AS KgDSLaad, ROUND(RIC.OpnDS, 1) AS KgDSOpn
FROM            dbo.VL_Proef_Voerverbruik_RIC AS RIC RIGHT OUTER JOIN
                         dbo.VL_Proef_Voerverbruik_Trioliet AS Trio ON RIC.PrtNam = Trio.PrtNam AND RIC.Jar = Trio.Jar AND RIC.Wek = Trio.Wek
