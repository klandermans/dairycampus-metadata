SELECT
    TVL_Totaal_sub_ric_opn_prod.*
FROM
    [dbo].[TVL_Totaal_sub_ric_opn_prod]
LEFT JOIN 
    TVL_Totaal_Bedrijf_Proef as ppp on ppp.oornum=cow and cast(TVL_Totaal_sub_ric_opn_prod.dat as date ) =ppp.dat
WHERE  
    prfcod='[prfcod]'  


