CREATE VIEW [dbo].[VL_Dier_Melkgift_Proef1]
AS
SELECT        
	P.PrfCod, P.BehCod, P.HrhNum, 
	P.DieNum AS DieNum, 
	RIGHT('0000' + CAST(A.AnimalNo AS varchar(4)), 4) AS OorNum, 
	try_CAST(A.AnimalNo AS int) AS OorNumGet, 
	A.RegistrationId AS LevNum, 
	M.MilkingDateDT AS MlkDat, 
	M.MilkingTime AS MlkTim, 
    '' AS OA, 
	M.MilkQuantityMass AS KgMlk, 
	M.MilkingPlace AS MlkPla, L.LacNum, 
	L.KlfDat, 
	L.InsDat, 
	L.VrwKlfDat
FROM            
	T_Proef_Dier AS P 
INNER JOIN
	T_Animals AS A ON P.DieNum = A.AnimalServerID 
LEFT OUTER JOIN
	TB_Animal_Milkings AS M ON P.DieNum = M.AnimalServerID 
LEFT OUTER JOIN
	VL_Dier_Lactatie AS L ON P.DieNum = L.DieNum
WHERE        
	(M.MilkingDateDT BETWEEN P.BegDat AND ISNULL(P.EndDat, GETDATE())) AND (M.MilkingDateDT BETWEEN L.KlfDat AND ISNULL(L.EinDat, GETDATE()))

