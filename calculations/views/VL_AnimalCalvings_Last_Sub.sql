CREATE VIEW [dbo].[VL_AnimalCalvings_Last_Sub]

AS
SELECT        
    AnimalServerID, MAX(LactationNo) AS MaxLactationNo
FROM            
    dbo.T_Animal_Calvings
GROUP BY 
    AnimalServerID


