create view VL_Totaal_sub_kv as
    select 
        dienum, 
        dat, 
        sum(iif(voenum='C21-9', opn, 0)) as [C21-9],
        sum(iif(voenum='C21-10', opn, 0)) as [C21-10],
        sum(iif(voenum='DelPro-13', opn, 0)) as [DelPro-13]
    from (
        SELECT        
            AnimalServerID AS DieNum, 
            FeedStartPeriodDateDT AS Dat, 
            ProcessComputerAbbr + '-' + CAST(ProcessComputerFeedID AS varchar(4)) AS VoeNum, 
            cast(ISNULL(QuantityProgrammed, 0) - ISNULL(QuantityRemainFeed, 0) as float) AS Opn
        FROM            
            dbo.TB_Animal_Feedings 
    ) as asdfadfs
    where dat<cast(getdate() as date)
    group by dat, dienum 