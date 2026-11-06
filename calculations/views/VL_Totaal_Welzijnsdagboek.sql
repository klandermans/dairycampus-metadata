
CREATE view  [dbo].[VL_Totaal_Welzijnsdagboek] as
select * from (
SELECT  
    aa.PrfCod, 
    dd.dat, 
    [datetime],
    animalserverid, 
    typ, 
    bron, 
    [description] 
FROM 
    (SELECT  distinct 
        cast(dat as date) as dat, 
        PrfCod, 
        animalserverid as DieNum 
    FROM vl_totaal_bedrijf_proef
   
) as aa
LEFT JOIN 
    tvl_totaal_welzijnsdagboek_dier as dd 
on  
    aa.dienum=animalserverid and aa.dat=dd.dat 

where 
    dd.dat is not null
union all
    select 
        distinct
        prfCod, 
        cast(createDate as date), 
        createdate,
        AnimalServerId,   
        'melding', 
        'melding', 
        concat(cast([description] as varchar(1024)), iif(photo=1,concat('<br><img src="/mobile/meldingen/photo/',a.id,'.jpg" >'),''))  COLLATE SQL_Latin1_General_CP1_CI_AS  as [description] 
    from t_proef_melding as a  left join T_Proef_Melding_Proef as b  on a.id= b.t_proef_melding_id
    where 
        AnimalServerId is null
union all
    select 
        distinct
        prfCod, 
        cast(DateCompleted as date), 
        DateCompleted,
        AnimalServerId,   
        'activiteit', 
        username, 
        concat(ActiviteitNaam , status, commentsActivity  ,iif(len(v1)>0,concat(v1,':',v1_value,'<br>'),'')
        ,iif(len(v2)>0,concat(v2,':',v2_value,'<br>'),'')
        ,iif(len(v3)>0,concat(v3,':',v3_value,'<br>'),'')
        ,iif(len(v4)>0,concat(v4,':',v4_value,'<br>'),'')
        ,iif(len(v5)>0,concat(v5,':',v5_value,'<br>'),'')
        ,iif(len(v6)>0,concat(v6,':',v6_value,'<br>'),'')
        ,iif(len(v7)>0,concat(v7,':',v7_value,'<br>'),'')
        ,iif(len(v8)>0,concat(v8,':',v8_value,'<br>'),'')
        ,iif(len(v9)>0,concat(v9,':',v9_value,'<br>'),'')
        )
    from t_proef_planning
    left join t_proef_users on t_proef_planning.VoltooidUserId=t_proef_users.id
    where 
        AnimalServerId is null



) as asdf 


        
        
