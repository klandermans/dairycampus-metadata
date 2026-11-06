CREATE VIEW [dbo].[VL_RIC_Dier_Opname_Mengsel]
AS
SELECT        
    dbo.EU_JAAR(Opn.Dat) AS Jar, 
    dbo.EU_WEEK(Opn.Dat) AS Wek, 
    DATEPART(dy, Opn.Dat) AS DagNum, 
    Opn.Dat, 
    Opn.DieNum, 
    RIGHT('0000' + CAST(Opn.AnmNo AS varchar(4)), 4) AS OorNum, 
    CAST(Opn.AnmNo AS int) AS OorNumGet, 
    Opn.MngNamRic, 
    Opn.MngNam, 
    Opn.Opn, 
    Opn.AntBez, 
    dbo.UrenMinutenSeconden(Opn.TydBez) AS Tyd, 
    MngCnt.CntMng
FROM            
    dbo.T_Dier_Voeropname_Mengsel AS Opn 
LEFT OUTER JOIN dbo.VL_RIC_Dier_Voeropname_Mengsel_CountMengsel AS MngCnt ON Opn.Dat = MngCnt.Dat AND Opn.DieNum = MngCnt.DieNum

