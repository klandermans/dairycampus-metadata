CREATE view [dbo].[_dev_laad] as     
    select 
        filename,
        ingredientname,
        sum(cast(performedproductkgafterdrop as real)) as performedproductkgafterdrop
         
    from t_raw_trioliet 
    where logsource=0 
    -- and filename='K20240619_1.CSV11725'
    group by filename, ingredientname
