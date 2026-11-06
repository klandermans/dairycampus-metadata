SELECT
    [Cow],
    [IMDat],[Reg1],[RespISO],[Name],[IMTim]      ,[IMWt]      ,[IMFlg]      ,[IMDim]      ,[IMAvFlo]      ,[IMMxFlow]      ,[IMStall]      ,[IMStartSec] ,
     milkingduration
from
    T_RAW_Gea_milk
LEFT JOIN 
    TB_Animal_Milkings on cast(imdat as datetime)= (cast(milkingtime as datetime)  + cast(milkingdate as datetime)) and cow=animalid
LEFT JOIN
    vl_totaal_sub_dier_datum_proef as ppp on ppp.oornum=cow and cast(imdat as date ) =dat
WHERE
    prfcod='[prfcod]'

