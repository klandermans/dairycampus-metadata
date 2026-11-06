CREATE view [dbo].[_dev_batch] as 
select 
    [filename], 
    cast(sum(performedproductkgafterdrop) as REAL) as totalLaad,  
    cast(sum(performedproductkgatstop)as REAL) as totalLos 
    from t_raw_trioliet 
    where 
        logsource=0 
        
group by [filename]
