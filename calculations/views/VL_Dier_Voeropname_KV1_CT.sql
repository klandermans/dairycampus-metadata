CREATE VIEW [dbo].[VL_Dier_Voeropname_KV1_CT]
AS
SELECT        
    DieNum, Dat, [SAC-1], [SAC-2], [SAC-3], [SAC-4], [C21-9], [C21-10], [DelPro-13]
FROM            
    (SELECT        
        DieNum, Dat, VoeNum, Opn
                          FROM            dbo.VL_Dier_Voeropname_KV1) AS P PIVOT (Max(Opn) FOR VoeNum IN ( [SAC-1], [SAC-2], [SAC-3], [SAC-4], [C21-9], [C21-10], [DelPro-13])) AS pvt

