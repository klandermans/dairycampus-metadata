SELECT
    TVL_Dier_Datum_Proef.PrfCod AS Projectcode, 
    T_Proef.PrfNam AS ProjectName,
    cast(TVL_Dier_Datum_Stal.Dat as date)AS [Date],
    TVL_Dier_Datum_Stal.Jar AS [Year], TVL_Dier_Datum_Stal.Wek AS [Week],
    TVL_Dier_Datum_Stal.WekDag AS [WeekDay], 
    TVL_Dier_Datum_Stal.Stl, TVL_Dier_Datum_Stal.Hok AS Unit,
    TVL_Dier_Datum_Stal.DieNum AS AnimalNumber,
    Count(TVL_Dier_Melkgift_Etmaal_Melkcontrole.DieNum) AS NumberAninal, TVL_Dier_Datum_Stal.LevNum AS IDNumber,
    TVL_Dier_Datum_Stal.OorNumGet AS EarNumber,
    cast(TVL_Dier_Datum_Stal.BegDat  as date) AS StartDate,
    cast(TVL_Dier_Datum_Stal.EndDat as date) AS EndDate,
    cast(TVL_Dier_Datum_Stal.GebDat as date) AS BirthDate,
    TVL_Dier_Datum_Stal.LftDgn AS AgeDAys,
    TVL_Dier_Datum_Stal.LacNum AS NumberOLactations,
    cast(TVL_Dier_Datum_Stal.KlfDat as date) AS LastCalvingDate,
    TVL_Dier_Datum_Stal.LacDgn AS DaysInLactation,
    cast(TVL_Dier_Datum_Stal.InsDat as date) AS InsiminationDate,
    cast(TVL_Dier_Datum_Stal.DrgZetDat as date) AS DryDate,
    cast(TVL_Dier_Datum_Stal.VrwKlfDat  as date) AS ExpecCalvingDate,
    TVL_Dier_Datum_Stal.VrwDgn, TVL_Dier_Melkgift_Etmaal_Melkcontrole.AntMlkO,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.KgMlkO AS MilkMorming, TVL_Dier_Melkgift_Etmaal_Melkcontrole.AntMlkA,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.KgMlkA AS MilkAfternoon,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.KgMlkEtm AS MilkDay, TVL_Dier_Gewicht_Etmaal.AntGewO,
    TVL_Dier_Gewicht_Etmaal.GewO AS WeightMorning,
    TVL_Dier_Gewicht_Etmaal.AntGewA, TVL_Dier_Gewicht_Etmaal.GewA AS WeightAfternoon,
    ([GewO]+[GewA])/2 AS GewTot, TVL_Dier_Voeropname_KV_Etmaal.SumVoeGft,
    TVL_Dier_Voeropname_KV_Etmaal.SumVoeRst, [SumVoeGft]-[SumVoeRst] AS SumVoeOpnm,
    cast(TVL_Dier_Melkgift_Etmaal_Melkcontrole.DatCon as date) AS DateMelkCon4Wk,
    cast(TVL_Dier_Melkgift_Etmaal_Melkcontrole.DatGldTot as date),
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.MlkCon,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.Vet, TVL_Dier_Melkgift_Etmaal_Melkcontrole.Eiw,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.Lac, TVL_Dier_Melkgift_Etmaal_Melkcontrole.Ket,
    TVL_Dier_Melkgift_Etmaal_Melkcontrole.Ure,
    cast(Q_Milieustallen_MelkcontroleAO_Crv.a as date) AS SampleDateEvening,
    Q_Milieustallen_MelkcontroleAO_Crv.o AS SampleDateMorning,
    Q_Milieustallen_MelkcontroleAO_Crv.Milk_Yield_CRV AS MilkYield,
    Q_Milieustallen_MelkcontroleAO_Crv.Milk_Yield,
    Q_Milieustallen_MelkcontroleAO_Crv.dates AS NumbOfDates,
    Q_Milieustallen_MelkcontroleAO_Crv.Fat_Concentration AS [Fat%],
    Q_Milieustallen_MelkcontroleAO_Crv.Protein_Concentration AS [Protein%],
    Q_Milieustallen_MelkcontroleAO_Crv.Lactose_Concentration AS [Lactose%],
    Q_Milieustallen_MelkcontroleAO_Crv.SCC AS SCC,
    Q_Milieustallen_MelkcontroleAO_Crv.Urea_Concentration AS [Urea (mg/100g)]

FROM ((((TVL_Dier_Datum_Stal LEFT JOIN TVL_Dier_Melkgift_Etmaal_Melkcontrole ON (TVL_Dier_Datum_Stal.Dat = TVL_Dier_Melkgift_Etmaal_Melkcontrole.Dat) AND (TVL_Dier_Datum_Stal.DieNum = TVL_Dier_Melkgift_Etmaal_Melkcontrole.DieNum)) LEFT JOIN TVL_Dier_Gewicht_Etmaal ON (TVL_Dier_Datum_Stal.Dat = TVL_Dier_Gewicht_Etmaal.Dat) AND (TVL_Dier_Datum_Stal.DieNum = TVL_Dier_Gewicht_Etmaal.DieNum)) LEFT JOIN TVL_Dier_Voeropname_KV_Etmaal ON (TVL_Dier_Datum_Stal.Dat = TVL_Dier_Voeropname_KV_Etmaal.Dat) AND (TVL_Dier_Datum_Stal.DieNum = TVL_Dier_Voeropname_KV_Etmaal.DieNum))

LEFT JOIN
    tvl_dier_datum_crv as Q_Milieustallen_MelkcontroleAO_Crv
ON TVL_Dier_Datum_Stal.Jar = year(Q_Milieustallen_MelkcontroleAO_Crv.date)
    AND TVL_Dier_Datum_Stal.Wek = DATEPART(WK, Q_Milieustallen_MelkcontroleAO_Crv.date)
    AND TVL_Dier_Datum_Stal.DieNum = Q_Milieustallen_MelkcontroleAO_Crv.AnimalServerId

)

LEFT JOIN (T_Proef RIGHT JOIN TVL_Dier_Datum_Proef ON T_Proef.PrfCod = TVL_Dier_Datum_Proef.PrfCod) ON (TVL_Dier_Datum_Stal.DieNum = TVL_Dier_Datum_Proef.DieNum) AND (TVL_Dier_Datum_Stal.Dat = TVL_Dier_Datum_Proef.Dat)

WHERE 
    TVL_Dier_Datum_Proef.PrfCod='[prfcod]'
GROUP BY 
    TVL_Dier_Datum_Proef.PrfCod, T_Proef.PrfNam, TVL_Dier_Datum_Stal.Dat, TVL_Dier_Datum_Stal.Jar, TVL_Dier_Datum_Stal.Wek, TVL_Dier_Datum_Stal.WekDag, TVL_Dier_Datum_Stal.Stl, TVL_Dier_Datum_Stal.Hok, TVL_Dier_Datum_Stal.DieNum, TVL_Dier_Datum_Stal.LevNum, TVL_Dier_Datum_Stal.OorNumGet, TVL_Dier_Datum_Stal.BegDat, TVL_Dier_Datum_Stal.EndDat, TVL_Dier_Datum_Stal.GebDat, TVL_Dier_Datum_Stal.LftDgn, TVL_Dier_Datum_Stal.LacNum, TVL_Dier_Datum_Stal.KlfDat, TVL_Dier_Datum_Stal.LacDgn, TVL_Dier_Datum_Stal.InsDat, TVL_Dier_Datum_Stal.DrgZetDat, TVL_Dier_Datum_Stal.VrwKlfDat, TVL_Dier_Datum_Stal.VrwDgn, TVL_Dier_Melkgift_Etmaal_Melkcontrole.AntMlkO, TVL_Dier_Melkgift_Etmaal_Melkcontrole.KgMlkO, TVL_Dier_Melkgift_Etmaal_Melkcontrole.AntMlkA, TVL_Dier_Melkgift_Etmaal_Melkcontrole.KgMlkA, TVL_Dier_Melkgift_Etmaal_Melkcontrole.KgMlkEtm, TVL_Dier_Gewicht_Etmaal.AntGewO, TVL_Dier_Gewicht_Etmaal.GewO, TVL_Dier_Gewicht_Etmaal.AntGewA, TVL_Dier_Gewicht_Etmaal.GewA, ([GewO]+[GewA])/2, TVL_Dier_Voeropname_KV_Etmaal.SumVoeGft, TVL_Dier_Voeropname_KV_Etmaal.SumVoeRst, [SumVoeGft]-[SumVoeRst], TVL_Dier_Melkgift_Etmaal_Melkcontrole.DatCon, TVL_Dier_Melkgift_Etmaal_Melkcontrole.DatGldTot, TVL_Dier_Melkgift_Etmaal_Melkcontrole.MlkCon, TVL_Dier_Melkgift_Etmaal_Melkcontrole.Vet, TVL_Dier_Melkgift_Etmaal_Melkcontrole.Eiw, TVL_Dier_Melkgift_Etmaal_Melkcontrole.Lac, TVL_Dier_Melkgift_Etmaal_Melkcontrole.Ket, TVL_Dier_Melkgift_Etmaal_Melkcontrole.Ure, Q_Milieustallen_MelkcontroleAO_Crv.a, Q_Milieustallen_MelkcontroleAO_Crv.o, Q_Milieustallen_MelkcontroleAO_Crv.Milk_Yield_CRV, Q_Milieustallen_MelkcontroleAO_Crv.Milk_Yield, Q_Milieustallen_MelkcontroleAO_Crv.dates, Q_Milieustallen_MelkcontroleAO_Crv.Fat_Concentration, Q_Milieustallen_MelkcontroleAO_Crv.Protein_Concentration, Q_Milieustallen_MelkcontroleAO_Crv.Lactose_Concentration, Q_Milieustallen_MelkcontroleAO_Crv.SCC, Q_Milieustallen_MelkcontroleAO_Crv.Urea_Concentration
HAVING 
    (((TVL_Dier_Datum_Stal.Hok) In ('13','14','15','16','60','61','70','71','72','73') Or (TVL_Dier_Datum_Stal.Hok) In ('60','61','62','70','71','72','73')))



