-- 17-09-2025 bert: wordt dit gebruikt? 
CREATE view [dbo].[VL_Totaal_gewicht_controle] as select 
    Dat, 
    DieNum,
    
    max(animalno) as OorNum,
    max(iif(cast(weighdate as date)=dateadd(dd, -7, dat) and datepart(hh, weighdatedt) < 12,  [weight], 0)) as [-7O],
    max(iif(cast(weighdate as date)=dateadd(dd, -7, dat) and datepart(hh, weighdatedt) > 12,  [weight], 0)) as [-7A],
    max(iif(cast(weighdate as date)=dateadd(dd, -7, dat) and datepart(hh, weighdatedt) < 12,  [weight], 0)) as [-6O],
    max(iif(cast(weighdate as date)=dateadd(dd, -7, dat) and datepart(hh, weighdatedt) > 12,  [weight], 0)) as [-6A],
    max(iif(cast(weighdate as date)=dateadd(dd, -7, dat) and datepart(hh, weighdatedt) < 12,  [weight], 0)) as [-5O],
    max(iif(cast(weighdate as date)=dateadd(dd, -7, dat) and datepart(hh, weighdatedt) > 12,  [weight], 0)) as [-5A],
    max(iif(cast(weighdate as date)=dateadd(dd, -7, dat) and datepart(hh, weighdatedt) < 12,  [weight], 0)) as [-4O],
    max(iif(cast(weighdate as date)=dateadd(dd, -7, dat) and datepart(hh, weighdatedt) > 12,  [weight], 0)) as [-4A],
    max(iif(cast(weighdate as date)=dateadd(dd, -7, dat) and datepart(hh, weighdatedt) < 12,  [weight], 0)) as [-3O],
    max(iif(cast(weighdate as date)=dateadd(dd, -7, dat) and datepart(hh, weighdatedt) > 12,  [weight], 0)) as [-3A],
    max(iif(cast(weighdate as date)=dateadd(dd, -7, dat) and datepart(hh, weighdatedt) < 12,  [weight], 0)) as [-2O],
    max(iif(cast(weighdate as date)=dateadd(dd, -7, dat) and datepart(hh, weighdatedt) > 12,  [weight], 0)) as [-2A],               
    max(iif(cast(weighdate as date)=dateadd(dd, -1, dat) and datepart(hh, weighdatedt) < 12,  [weight], 0)) as [-1O],
    max(iif(cast(weighdate as date)=dateadd(dd, -1, dat) and datepart(hh, weighdatedt) > 12,  [weight], 0)) as [-1A]
from tvl_dier_datum_stal 
left join T_Animal_Animalweighings on dienum = animalserverid

group by dat, dienum
