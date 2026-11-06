CREATE VIEW dbo.VL_Count_Milkings
AS
SELECT        TOP (100) PERCENT MilkingDateDT, COUNT(AnimalMilkingID) AS MilkCount
FROM            dbo.T_Animal_Milkings
GROUP BY MilkingDateDT
ORDER BY MilkingDateDT DESC
