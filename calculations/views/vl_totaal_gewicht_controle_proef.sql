-- 17-09-2025 bert: wordt dit gebruikt? 

CREATE view [dbo].[VL_Totaal_gewicht_controle_proef] as 
select PrfCod, vl_totaal_gewicht_controle.*
from tvl_dier_datum_proef 
left join vl_totaal_gewicht_controle on tvl_dier_datum_proef.dienum=vl_totaal_gewicht_controle.dienum and tvl_dier_datum_proef.dat=vl_totaal_gewicht_controle.dat  
-- where vl_totaal_gewicht_controle.dat='2023-01-23'
