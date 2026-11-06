SELECT
    [dbo].[TVL_totaal_sub_ric_opn].*

FROM
    [dbo].[TVL_totaal_sub_ric_opn]
LEFT JOIN 
    TVL_Totaal_Bedrijf_Proef as ppp on ppp.oornum=cow and cast(TVL_totaal_sub_ric_opn.dat as date ) =ppp.dat
WHERE  
    prfcod='[prfcod]'  


