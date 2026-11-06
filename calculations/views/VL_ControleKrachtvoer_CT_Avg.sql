CREATE VIEW [dbo].[VL_ControleKrachtvoer_CT_Avg]
AS
SELECT        
    PrfCod, 
    BehCod, 
    PrcCom, 
    VoeNum, 
    PrtNam, 
    AVG([-7G]) AS [-7G], 
    AVG([-7R]) AS [-7R], 
    AVG([-6G]) AS [-6G], 
    AVG([-6R]) AS [-6R], 
    AVG([-5G]) AS [-5G], 
    AVG([-5R]) AS [-5R], 
                         AVG([-4G]) AS [-4G], AVG([-4R]) AS [-4R], AVG([-3G]) AS [-3G], AVG([-3R]) AS [-3R], AVG([-2G]) AS [-2G], AVG([-2R]) AS [-2R], AVG([-1G]) AS [-1G], AVG([-1R]) AS [-1R]
FROM            
    dbo.VL_ControleKrachtvoer_CT
GROUP BY PrfCod, BehCod, PrcCom, VoeNum, PrtNam


