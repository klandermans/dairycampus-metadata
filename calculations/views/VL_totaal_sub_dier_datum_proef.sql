-- Sub VIEW om dieren per proefdag te tonen wordt gebruikt in totaal tabel
CREATE VIEW [dbo].[VL_Totaal_Sub_Dier_Datum_Proef]
AS
    SELECT        
        D.Dat, 
        dbo.eu_jaar(D .Dat) AS Jar, 
        dbo.eu_week(D .Dat) AS Wek, 
        dbo.DagNam(DATEPART(dw, D .Dat)) AS WekDag, 
        P.PrfCod, 
        P.BehCod, 
        P.HrhNum, 
        P.Blk, 
        P.DieNum, 
        T_Animals.animalno as OorNum,
        P.BegDat AS BegDatPrf, 
        P.EndDat AS EndDatPrf


    FROM dbo.T_Proef_Dier AS P 
    left JOIN dbo.T_Datum AS D ON P.BegDat <= D .Dat AND ISNULL(P.EndDat, GETDATE()) >= D .Dat 
    left JOIN dbo.T_Animals ON P.DieNum = dbo.T_Animals.AnimalServerID 
    

    -- union all

    -- SELECT        
    --     Dat, 
    --     Jar, 
    --      Wek, 
    --      WekDag, 
    --     440000001 as PrfCod, 
    --     hok as BehCod, 
    --     0 as HrhNum, 
    --     0 as Blk, 
    --     Animalserverid, 
    --     OorNum,
    --     getdate() AS BegDatPrf, 
    --     getdate() AS EndDatPrf


    -- FROM dbo.tvl_totaal_bedrijf AS P 
    -- where hok in ('60','61','62','70','71','72','73')
    -- and dat>dateadd(dd ,-1, getdate()) and dat < getdate()


