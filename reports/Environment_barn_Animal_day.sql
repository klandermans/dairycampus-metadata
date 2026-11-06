SELECT
    cast(TVL_Dier_Datum_Stal.Dat  as date)AS [Date],
    TVL_Dier_Datum_Stal.Jar AS [Year],
    TVL_Dier_Datum_Stal.Wek AS Week,
    TVL_Dier_Datum_Stal.WekDag AS WeekDay,
    TVL_Dier_Datum_Stal.Stl,
    TVL_Dier_Datum_Stal.Hok AS Unit,
    TVL_Dier_Datum_Stal.DieNum AS AnimalNumber,
    Count(TVL_Dier_Melkgift_Etmaal_Melkcontrole.DieNum) AS NumberAninal,
    TVL_Dier_Datum_Stal.LevNum AS IDNumber,
    TVL_Dier_Datum_Stal.OorNumGet AS EarNumber,
    cast(TVL_Dier_Datum_Stal.BegDat  as date) AS StartDate,
    cast(TVL_Dier_Datum_Stal.EndDat  as date) AS EndDate,
    cast(TVL_Dier_Datum_Stal.GebDat   as date) AS BirthDate,
    TVL_Dier_Datum_Stal.LftDgn AS AgeDAys,
    TVL_Dier_Datum_Stal.LacNum AS NumberOLactations,
    cast(TVL_Dier_Datum_Stal.KlfDat  as date) AS LastCalvingDate,
    TVL_Dier_Datum_Stal.LacDgn AS DaysInLactation,
    cast(TVL_Dier_Datum_Stal.InsDat as date) AS InsiminationDate,
    cast(TVL_Dier_Datum_Stal.DrgZetDat as date) AS DryDate,
    cast(TVL_Dier_Datum_Stal.VrwKlfDat as date) AS ExpecCalvingDate,
    TVL_Dier_Datum_Stal.VrwDgn, TVL_Dier_Melkgift_Etmaal_Melkcontrole.AntMlkO,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.KgMlkO AS MilkMorming,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.AntMlkA,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.KgMlkA AS MilkAfternoon,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.KgMlkEtm AS MilkDay,
    TVL_Dier_Gewicht_Etmaal.AntGewO,
    TVL_Dier_Gewicht_Etmaal.GewO AS WeightMorning, TVL_Dier_Gewicht_Etmaal.AntGewA,
    TVL_Dier_Gewicht_Etmaal.GewA AS WeightAfternoon,
    ([GewO]+[GewA])/2 AS GewTot,
    TVL_Dier_Voeropname_KV_Etmaal.SumVoeGft, TVL_Dier_Voeropname_KV_Etmaal.SumVoeRst, [SumVoeGft]-[SumVoeRst] AS SumVoeOpnm,
    cast(TVL_Dier_Melkgift_Etmaal_Melkcontrole.DatCon  as date) AS DateMelkCon4Wk,
    cast(TVL_Dier_Melkgift_Etmaal_Melkcontrole.DatGldTot as date) as DatGldTot,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.MlkCon,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.Vet,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.Eiw,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.Lac,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.Ket,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.Ure,
    cast(crv.a as date) AS SampleDateEvening,
    cast(crv.o as date)  AS SampleDateMorning,
    crv.Milk_Yield_CRV AS MilkYield,
    round(crv.Milk_Yield,5) as Milk_Yield,
    crv.dates AS NumbOfDates,
    round(crv.Fat_Concentration,5) AS [Fat%],
    round(crv.Protein_Concentration,5) AS [Protein%],
    round(crv.Lactose_Concentration,5) AS [Lactose%],
    round(crv.SCC,5) AS SCC,
    round(crv.Urea_Concentration,5) AS [Urea (mg/100g)]
FROM
    TVL_Dier_Datum_Stal
LEFT JOIN
    TVL_Dier_Melkgift_Etmaal_Melkcontrole ON TVL_Dier_Datum_Stal.Dat = TVL_Dier_Melkgift_Etmaal_Melkcontrole.Dat AND TVL_Dier_Datum_Stal.DieNum = TVL_Dier_Melkgift_Etmaal_Melkcontrole.DieNum
LEFT JOIN
    TVL_Dier_Gewicht_Etmaal ON TVL_Dier_Datum_Stal.Dat = TVL_Dier_Gewicht_Etmaal.Dat AND TVL_Dier_Datum_Stal.DieNum = TVL_Dier_Gewicht_Etmaal.DieNum
LEFT JOIN
    TVL_Dier_Voeropname_KV_Etmaal ON TVL_Dier_Datum_Stal.Dat = TVL_Dier_Voeropname_KV_Etmaal.Dat AND TVL_Dier_Datum_Stal.DieNum = TVL_Dier_Voeropname_KV_Etmaal.DieNum
LEFT JOIN tvl_dier_datum_proef on tvl_dier_datum_stal.dat = tvl_dier_datum_proef.dat and tvl_dier_datum_stal.dienum = tvl_dier_datum_proef.dienum
LEFT JOIN
    tvl_dier_datum_crv as crv  ON TVL_Dier_Datum_Stal.Jar = year(crv.date)
    AND TVL_Dier_Datum_Stal.Wek = DATEPART(WK, crv.date)
    AND TVL_Dier_Datum_Stal.DieNum = crv.AnimalServerId
WHERE 
    PrfCod='[prfcod]'
GROUP BY
    TVL_Dier_Datum_Stal.Dat,
    TVL_Dier_Datum_Stal.Jar, TVL_Dier_Datum_Stal.Wek, TVL_Dier_Datum_Stal.WekDag,
    TVL_Dier_Datum_Stal.Stl, TVL_Dier_Datum_Stal.Hok, TVL_Dier_Datum_Stal.DieNum,
    TVL_Dier_Datum_Stal.LevNum, TVL_Dier_Datum_Stal.OorNumGet, TVL_Dier_Datum_Stal.BegDat,
    TVL_Dier_Datum_Stal.EndDat, TVL_Dier_Datum_Stal.GebDat, TVL_Dier_Datum_Stal.LftDgn,
    TVL_Dier_Datum_Stal.LacNum, TVL_Dier_Datum_Stal.KlfDat, TVL_Dier_Datum_Stal.LacDgn,
    TVL_Dier_Datum_Stal.InsDat,
    TVL_Dier_Datum_Stal.DrgZetDat,
    TVL_Dier_Datum_Stal.VrwKlfDat,
    TVL_Dier_Datum_Stal.VrwDgn,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.AntMlkO,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.KgMlkO,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.AntMlkA,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.KgMlkA,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.KgMlkEtm, TVL_Dier_Gewicht_Etmaal.AntGewO,
    TVL_Dier_Gewicht_Etmaal.GewO, TVL_Dier_Gewicht_Etmaal.AntGewA,
    TVL_Dier_Gewicht_Etmaal.GewA, ([GewO]+[GewA])/2, TVL_Dier_Voeropname_KV_Etmaal.SumVoeGft,
    TVL_Dier_Voeropname_KV_Etmaal.SumVoeRst, [SumVoeGft]-[SumVoeRst],
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.DatCon,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.DatGldTot,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.MlkCon,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.Vet,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.Eiw,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.Lac,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.Ket,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.Ure,
    crv.a, crv.o, crv.Milk_Yield_CRV,
    crv.Milk_Yield, crv.dates, crv.Fat_Concentration,
    crv.Protein_Concentration, crv.Lactose_Concentration,
    crv.SCC,
    crv.Urea_Concentration
HAVING
    TVL_Dier_Datum_Stal.Hok In ('13','14','15','16','60','61','70','71','72','73')
    Or
    TVL_Dier_Datum_Stal.Hok In ('60','61','62','70','71','72','73')

