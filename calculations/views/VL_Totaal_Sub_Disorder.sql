CREATE  VIEW VL_Totaal_Sub_Disorder as 


select tot.dat, 
    tot.animalserverid as dienum,
    STRING_AGG(
    CAST(
        CONCAT(CONVERT(varchar(10), dia.diagnosisdate, 23), ' ', dia.disorderdesc, ' ', MedicineDesc)
        AS varchar(max)
    ),
    ', '
    ) WITHIN GROUP (ORDER BY dia.diagnosisdate) AS disorders
from  
    TVL_Totaal_sub_stal as tot
left join 
    T_Animal_TreatmentActions as treat   on tot.animalserverid=treat.animalserverid and treat.diagnosisdate > dateadd(DD, -7,tot.dat) and treat.diagnosisdate <= tot.dat
left join
    T_Animal_Diagnosis as dia on dia.animalserverid=treat.animalserverid  and treat.diagnosisdate = dia.diagnosisdate 
where 
treat.diagnosisdate is not null  

--  and tot.dat='2025-08-11'
group  by tot.dat, tot.animalserverid


-- order by tot.dat desc


-- select max(diagnosisdate) from T_Animal_TreatmentActions