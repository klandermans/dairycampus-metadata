SELECT
    distinct
    T_RAW_gordijnen.*
FROM (
    SELECT
    DATEADD(hour, DATEDIFF(hour, 0, Datum), 0) AS datum
      ,avg([Buitentemperatuur]) as Buitentemperatuur
      ,avg([Windsnelheid]) as [Windsnelheid]
      ,max([Windrichting]) as [Windrichting]
      ,avg([Stal_50]) as [Stal_50]
      ,avg([Temp_50]) as [Temp_50]
      ,avg([West_50]) as [West_50]
      ,avg([Oost 50]) as [Oost 50]
      ,avg([Stal_60]) as [Stal_60]
      ,avg([Temp_60]) as [Temp_60]
      ,avg([West_60]) as [West_60]
      ,avg([Oost_60]) as [Oost_60]
      ,avg([Stal_61]) as [Stal_61]
      ,avg([Temp_61]) as [Temp_61]
      ,avg([West_61]) as [West_61]
      ,avg([Oost_61]) as [Oost_61]
      ,avg([Stal_70]) as [Stal_70]
      ,avg([Temp_70]) as [Temp_70]
      ,avg([West_70]) as [West_70]
      ,avg([Oost_70]) as [Oost_70]
      ,avg([Stal_71]) as [Stal_71]
      ,avg([Temp_71]) as [Temp_71]
      ,avg([West_71]) as [West_71]
      ,avg([Oost_71]) as [Oost_71]
      ,avg([Stal_72]) as [Stal_72]
      ,avg([Temp_72]) as [Temp_72]
      ,avg([West_72]) as [West_72]
      ,avg([Oost_72]) as [Oost_72]
      ,avg([Stal_73]) as [Stal_73]
      ,avg([Temp_73]) as [Temp_73]
      ,avg([West_73]) as [West_73]
      ,avg([Oost_73]) as [Oost_73]
    FROM
        [dbo].[T_RAW_gordijnen]
    group by DATEADD(hour, DATEDIFF(hour, 0, Datum), 0) 
) as T_RAW_gordijnen
LEFT JOIN
    TVL_totaal_bedrijf_proef on cast(datum as date)=dat
WHERE
    hok in ('50', '51', '60','61', '62', '70','71','72','73')
    and dat is not null