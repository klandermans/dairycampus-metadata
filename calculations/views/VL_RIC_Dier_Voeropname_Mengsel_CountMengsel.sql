CREATE VIEW [dbo].[VL_RIC_Dier_Voeropname_Mengsel_CountMengsel]
AS
/* deze wordt gebruikt in het ric voeropnamen formulier */
SELECT        
    Dat, DieNum, COUNT(MngNamRic) AS CntMng
FROM
    dbo.T_Dier_Voeropname_Mengsel
GROUP BY Dat, DieNum
HAVING (COUNT(MngNamRic) > 1)


