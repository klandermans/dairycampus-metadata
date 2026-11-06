CREATE VIEW [dbo].[VL_LaatsteAfkalving]
AS
SELECT        
    AnimalServerID, MAX(CalvingDateDT) AS MaxCalvingDateDT
FROM          
    dbo.T_Animal_Calvings
GROUP BY AnimalServerID

