CREATE view VL_Dier_Datum_Crv_Week_Date as 
select dat, crv.* 
from T_Datum 
right join vl_dier_datum_crv as crv on DATEPART(ww, Date ) =  DATEPART(ww, dat ) 
and DATEPART(yy, Date ) =  DATEPART(yy, dat ) 
where animalserverid is not null