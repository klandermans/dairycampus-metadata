select
distinct 
    prfcod,tvl_totaal_bedrijf_proef.dat, VL_totaal_droogstoof.*
from 
    tvl_totaal_bedrijf_proef 
left join 
    tvl_totaal_sub_ric_opn_prod on tvl_totaal_sub_ric_opn_prod.dat=tvl_totaal_bedrijf_proef.dat and  tvl_totaal_sub_ric_opn_prod.cow=tvl_totaal_bedrijf_proef.oornum 
left join 
    VL_totaal_droogstoof on datmon=tvl_totaal_bedrijf_proef.dat and objcod=ingredientname
where 
    tvl_totaal_bedrijf_proef.prfcod='[prfcod]' 
