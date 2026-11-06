CREATE VIEW dbo.VL_Dier_Analyse_Parameter_CT
AS
SELECT        DieNum, Dat, MedCod, VlgNum, [Vet], [Eiwit], [Lactose], [Ureum], [Celgetal]
FROM            (SELECT        DieNum, Dat, MedCod, VlgNum, ParCod, ParWrd
                          FROM            dbo.T_Dier_Analyse_Parameter) AS P PIVOT (Max(ParWrd) FOR ParCod IN ([Vet], [Eiwit], [Lactose], [Ureum], [Celgetal])) AS pvt
