-- ============================================================================
-- VIEW: VW_Productie_Tabel_Generiek
-- ============================================================================
-- Gebruik: SELECT * FROM VW_Productie_Tabel_Generiek WHERE PrfCod = '4400004252'
-- Deze view werkt voor ALLE proeven en ALLE behandelingen
-- ============================================================================

CREATE   VIEW VW_Productie_Tabel_Generiek
AS
WITH ProductieData AS (
    SELECT 
        PrfCod,
        BehCod,
        COUNT(DISTINCT AnimalServerId) as N_Dieren,
        COUNT(DISTINCT Dat) as N_Meetdagen,
        AVG(KgMlkEtm) as Melk_Gem,
        STDEV(KgMlkEtm) as Melk_SD,
        AVG([tot.opnDs]) as DS_Gem,
        STDEV([tot.opnDs]) as DS_SD,
        AVG(CASE WHEN [tot.opnDs] > 0 THEN KgMlkEtm / [tot.opnDs] ELSE NULL END) as VoerEff,
        AVG(GewO) as Gewicht,
        AVG(LacDgn) as LacDag,
        AVG(LacNum) as LacNum
    FROM tvl_totaal_bedrijf_proef
    WHERE BehCod IS NOT NULL
      AND KgMlkEtm IS NOT NULL
    GROUP BY PrfCod, BehCod
)
SELECT 
    PrfCod,
    BehCod,
    N_Dieren,
    'Aantal meetdagen' AS Parameter,
    CAST(N_Meetdagen AS VARCHAR(50)) AS Waarde,
    1 AS SortOrder
FROM ProductieData

UNION ALL

SELECT 
    PrfCod,
    BehCod,
    N_Dieren,
    'Melkproductie (kg/dag)',
    CONCAT(
        CAST(ROUND(Melk_Gem, 1) AS VARCHAR), 
        ' ± ', 
        CAST(ROUND(Melk_SD, 1) AS VARCHAR)
    ),
    2
FROM ProductieData

UNION ALL

SELECT 
    PrfCod,
    BehCod,
    N_Dieren,
    'DS opname (kg/dag)',
    CONCAT(
        CAST(ROUND(DS_Gem, 1) AS VARCHAR), 
        ' ± ', 
        CAST(ROUND(DS_SD, 1) AS VARCHAR)
    ),
    3
FROM ProductieData

UNION ALL

SELECT 
    PrfCod,
    BehCod,
    N_Dieren,
    'Voerefficiëntie¹',
    CAST(ROUND(VoerEff, 2) AS VARCHAR),
    4
FROM ProductieData

UNION ALL

SELECT 
    PrfCod,
    BehCod,
    N_Dieren,
    'Lichaamsgewicht (kg)',
    CAST(ROUND(Gewicht, 0) AS VARCHAR),
    5
FROM ProductieData

UNION ALL

SELECT 
    PrfCod,
    BehCod,
    N_Dieren,
    'Lactatiedad (gemiddeld)',
    CAST(ROUND(LacDag, 0) AS VARCHAR),
    6
FROM ProductieData

UNION ALL

SELECT 
    PrfCod,
    BehCod,
    N_Dieren,
    'Lactatienummer',
    CAST(ROUND(LacNum, 0) AS VARCHAR),
    7
FROM ProductieData;

