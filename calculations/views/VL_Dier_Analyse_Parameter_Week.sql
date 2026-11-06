CREATE VIEW [dbo].[VL_Dier_Analyse_Parameter_Week]
AS
SELECT        MP1.DieNum, MP1.Dat, DATEPART(YYYY, MP1.Dat) AS Jar, DATEPART(ISOWK, MP1.Dat) AS WeeNum, MP1.MedCod, MP1.MlkGftSom AS MlkGftTotA, 
                         MP2.MlkGftSom AS MlkGftTotO, MP1.MlkGftSom + MP2.MlkGftSom AS MlkGftTot, MP1.MlkGftAnt AS MlkGftAntA, MP2.MlkGftAnt AS MlkGftAntO, 
                         MP1.MlkGftAnt + MP2.MlkGftAnt AS MlkGftAnt, 

MP1.Vet AS VetA, MP2.Vet AS VetO, ROUND(dbo.DeelNull(MP1.MlkGftSom * iif(MP1.Vet = 0, NULL, MP1.Vet) + MP2.MlkGftSom * iif(MP2.Vet = 0, NULL, MP2.Vet), MP1.MlkGftSom + MP2.MlkGftSom), 2) AS Vet, 

MP1.Eiwit AS EiwitA, MP2.Eiwit AS EiwitO, ROUND(dbo.DeelNull(MP1.MlkGftSom * iif(MP1.Eiwit=0,Null,MP1.Eiwit) + MP2.MlkGftSom * iif(MP2.Eiwit=0,Null,MP2.Eiwit), MP1.MlkGftSom + MP2.MlkGftSom), 2) AS Eiwit, 

MP1.Lactose AS LactoseA, MP2.Lactose AS LactoseO, ROUND(dbo.DeelNull(MP1.MlkGftSom * iif(MP1.Lactose=0,Null, MP1.Lactose) + MP2.MlkGftSom * iif(MP2.Lactose=0,Null,MP2.Lactose), MP1.MlkGftSom + MP2.MlkGftSom), 2) AS Lactose, 
                         
MP1.Ureum AS UreumA, MP2.Ureum AS UreumO, ROUND(dbo.DeelNull(MP1.MlkGftSom * iif(MP1.Ureum=0,Null, MP1.Ureum) + MP2.MlkGftSom * iif(MP2.Ureum=0,Null,MP2.Ureum), MP1.MlkGftSom + MP2.MlkGftSom), 0) AS Ureum, 

MP1.Celgetal AS CelgetalA, MP2.Celgetal AS CelgetalO, ROUND(dbo.DeelNull(MP1.MlkGftSom * iif(MP1.Celgetal=0,Null, MP1.Celgetal) + MP2.MlkGftSom * iif(MP2.Celgetal=0,Null,MP2.Celgetal), MP1.MlkGftSom + MP2.MlkGftSom), 0) AS Celgetal

FROM dbo.VL_Dier_Analyse_Melkgift2Parameter AS MP1 
INNER JOIN dbo.VL_Dier_Analyse_Melkgift2Parameter AS MP2 ON MP1.DieNum = MP2.DieNum AND MP1.Dat = MP2.Dat AND MP1.MedCod = MP2.MedCod
WHERE        (MP1.VlgNum = 1) AND (MP2.VlgNum = 2)

