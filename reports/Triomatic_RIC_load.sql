SELECT 
    * 
FROM 
    t_raw_trioliet 
WHERE 
    filename in (
    SELECT DISTINCT 
        [filename]
    FROM T_RAW_Trioliet as t
    RIGHT JOIN  (
        SELECT DISTINCT 
            date, 
            feedtyperv1 as feedtype 
        FROM 
            VL_Totaal_Bedrijf_Ric_CD   
        LEFT JOIN 
            TVL_Totaal_Bedrijf_Proef as ppp on ppp.oornum=cow and cast(date as date ) =dat
        WHERE  
            prfcod='[prfcod]'  

        UNION ALL
        SELECT DISTINCT 
            date, 
            feedtyperv2 as feedtype 
        FROM 
            VL_Totaal_Bedrijf_Ric_CD   
        LEFT JOIN 
            TVL_Totaal_Bedrijf_Proef as ppp on ppp.oornum=cow and cast(date as date ) =dat
        WHERE  
            prfcod='[prfcod]'  

        UNION ALL
        SELECT DISTINCT 
            date, 
            feedtyperv3 as feedtype 
        FROM 
            VL_Totaal_Bedrijf_Ric_CD   
        LEFT JOIN 
            TVL_Totaal_Bedrijf_Proef as ppp on ppp.oornum=cow and cast(date as date ) =dat
        WHERE  
            prfcod='[prfcod]'  

        UNION ALL
        SELECT DISTINCT 
            date, 
            feedtyperv4 as feedtype 
        FROM 
            VL_Totaal_Bedrijf_Ric_CD   
        LEFT JOIN 
            TVL_Totaal_Bedrijf_Proef as ppp on ppp.oornum=cow and cast(date as date ) =dat
        WHERE  
            prfcod='[prfcod]'  

                                                                                        
    ) as h on h.feedtype=t.groupName and t.date=h.date
)
AND subgroupnr = 0