CREATE VIEW [dbo].[_dev_opname_final] AS
SELECT 
    cow, 
    date, 
    -- max(OpnRvDsHans) as hns, 
    max(opname_controle) aS opname_controle, 
    max([rv1.opnDs])+max(isnull([rv2.opnDs], 0))+max(isnull([rv3.opnDs], 0)) as oud, 
    sum(opnds) as opnds, 
    sum(opnds7) as opnds7,
    round(ABS(1-(sum(opnds) /   sum(opnds7))) * 100,2) as DIFF7   ,
    round(ABS(1-(   (max([rv1.opnDs])+max(isnull([rv3.opnDs], 0))+max(isnull([rv2.opnDs], 0)) )         /   sum(opnds)))*100 ,2) as DIFF_Oud
FROM [dbo].[_dev_opname_per_dag]
left join tvl_totaal on oornum=cow and cast(dat as date)=date
-- where date='2024-09-15' 
group by cow, date

-- select * from t_raw_hokofarmvr where date='2024-09-15' and cow = 748 order by startTime


