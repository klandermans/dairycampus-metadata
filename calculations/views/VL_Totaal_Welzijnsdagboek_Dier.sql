CREATE view [dbo].[VL_Totaal_Welzijnsdagboek_Dier] AS

    select  
        dat, 
        datetime, 
        animalserverid, 
        typ, 
        bron, 
        [description] 
    
    from (

            SELECT 
                cast(T_Animal_Diagnosis.DiagnosisDate as date) as dat, 
                cast(T_Animal_Diagnosis.DiagnosisDate as datetime) as [datetime],  
                
                T_Animal_Diagnosis.animalserverid as animalserverid,
                
                concat('Diagnose: ', disorderdesc) as typ,
                'agrovision' as bron,
                concat( disorderdesc, 
                        iif(T_Animal_Diagnosis.DiagnosisLocationLF=1,'-LV ', null),
                        iif(T_Animal_Diagnosis.DiagnosisLocationLR=1,'-LA ', null),
                        iif(T_Animal_Diagnosis.DiagnosisLocationRF=1,'-RV ', null),
                        iif(T_Animal_Diagnosis.DiagnosisLocationRR=1,'-RA ', null), '<br>',
                        'Behandeling: ', T_Animal_TreatmentActions.TreatmentEntityTypeName
                ) as [description]
            from 
                T_Animal_Diagnosis 
            LEFT JOIN 
                T_Animal_TreatmentActions on T_Animal_Diagnosis.AnimalDiagnosisID = T_Animal_TreatmentActions.AnimalDiagnosisID
            
        UNION ALL
            
            SELECT
                cast([TreatmentDate]  as date) as dat
                , cast([TreatmentDate]  as datetime) as  [datetime]
                
                ,[AnimalServerID]
                , concat('Behandeling: ',TreatmentEntityTypeName) as typ
                , 'agrovision' as  bron
                , concat(
                    [MedicineDesc], 
                    ' ', 
                    iif([ApplyTypeName]<>'Undefined',[ApplyTypeName],null),
                    ' ', 
                    iif(DiagnosisLocationLF=1,'-LV ', null),
                    iif(DiagnosisLocationLR=1,'-LA ', null),
                    iif(DiagnosisLocationRF=1,'-RV ', null),
                    iif(DiagnosisLocationRR=1,'-RA ', null)
                )  as [description]
            FROM [dbo].[T_Animal_TreatmentActions]
            
        UNION ALL
            
            SELECT 
                cast([FertilityStateDate]  as date) as dat
                , cast( [FertilityStateDate]  as datetime) as [datetime]
                ,[AnimalServerID]
                ,concat('Fertiliteit: ', [MainEntityTypeName]) as typ
                , 'agrovision' as  bron
                ,concat([FertilityStateTypeName], ' ' ,[EventCommentAbbr])  as [description]
            FROM [T_Animal_FertilityStatus]

        UNION ALL
                select * from (    
                    select 
                         [Behandeld op] as dat, 
                        cast( [Behandeld op]  as datetime) as [datetime],
                        animalserverid as dienum, 
                        'digiklauw' as typ, 
                        'digiklauw' as  bron,
                        concat(aandoening,'LA:', LA,'RA:', RA,'LV:', LV,'RV:',RV)  as [description]
                    from 
                        t_raw_digiklauw 
                    left join 
                        tvl_totaal_bedrijf on oornum=diernr and dat=[behandeld op]
                ) as digi
            
        UNION ALL
            
            SELECT 
                cast([MatingDate] as date) as [dat]
                , cast([MatingDate] as datetime) as [dat]
                
                ,[AnimalServerID]
                , concat('Inseminatie: ', [MatingTypeName]) as typ
                , 'agrovision' as  bron        
                
                , concat('Stier ',[BullName] , ' (' ,[BullRegistrationId],')',                'Conceptie datum: ', cast(conceptiondate as date),                'Laatste zwangerschapsdatum: ', cast(LastPregnantDate as date))  as [description]
            FROM [T_Animal_Matings]

        UNION ALL

            SELECT 
                cast([createdate] as date)  as dat
                ,cast([createdate] as datetime)  as [datetime]
                ,an.[AnimalServerID]
                ,concat('meldingen: ', [title]) as typ
                , concat('app:', username) as  bron
                ,concat(cast([description] as varchar(1024)), iif(photo=1,concat('<img src="/mobile/meldingen/photo/',t_proef_melding.id,'.jpg" >'),''))  as [description]
            FROM [t_proef_melding] 
            left join 
                t_animals as an on t_proef_melding.animalserverid=an.animalserverid
            left join t_proef_users on userid=t_proef_users.id
            where an.animalserverid>0

        UNION ALL
        /* stuk voor de afgetekende taken */
        SELECT 
            cast([datum] as date)  as dat      
            ,cast([datum] as datetime)  as [datetime]
            ,TVL_Totaal_bedrijf.AnimalServerId as DieNum
            ,concat('activiteit: ', [ActiviteitNaam]) as typ
            ,alias as  bron
            ,concat(t_proef_planning.[Status], ' ' ,iif(cast([commentsActivity] as varchar(1024))='','geen bijzonderheden',cast([commentsActivity] as varchar)))  as [description]   
        FROM 
            [t_proef_planning] 
        left join 
            TVL_Totaal_bedrijf  on dat=cast(datum as date) 
            and 
            (t_proef_planning.oornum=TVL_Totaal_bedrijf.oornum or t_proef_planning.AnimalServerId=TVL_Totaal_bedrijf.AnimalServerId )
        left join 
            t_proef_users on voltooiduserid=t_proef_users.id
        where 
            t_proef_planning.[Status]<>'todo'  

        UNION ALL

            select 
                cast(child.birthdate  as date) as dat,
                cast(child.birthdate  as datetime) as [datetime],
                mother.animalserverid  ,
                'afkalven' as typ,         
                'agrovision' as bron        ,
                concat(lactationno,' kalf- ', child.GenderTypeName) as [description]
                
            from 
                t_animals as mother 
            left join 
                t_animals as child on mother.RegistrationId=child.MOTHERRegistrationId 
            LEFT JOIN 
                T_Animal_Calvings ON mother.AnimalServerID=T_Animal_Calvings.ANIMALSERVERID AND CalvingDate=child.birthdate
            
            where cast(child.birthdate  as datetime) is not  null
            
            -- SELECT  
            --     dryoffdate as dat,
                
            --     'dryoff' as [typ], 
                
            --     concat('dryoff of lactation ', lactationno,' ', sum(MilkQuantityMass),' KG Milk  in ', count(*),' separate milkings in ',count(distinct milkingdate) , ' lactationdays') as [message], T_Animal_Calvings.animalserverid  from T_Animal_Calvings left join  (select MilkQuantityMass, AnimalServerID, MilkingDate, milkingplace 
            -- from tb_animal_milkings   
            -- union select MilkQuantityMass, AnimalServerID, MilkingDate, milkingplace from TBA_Animal_Milkings) as milk  on milk.animalserverid = t_animal_calvings.animalserverid 
            -- WHERE  milkingdate between calvingdate and dryoffdate 
            -- GROUP BY T_Animal_Calvings.dryoffdate, T_Animal_Calvings.animalserverid,lactationno
            
        UNION ALL

            SELECT 
                cast(MilkDeliveryDateTime as date) as dat, 
                cast(MilkDeliveryDateTime as datetime) as [datetime], 
                
                animalserverid  ,    
                'afkalven' as typ,
                'agrovision' as bron        ,
                'Eerste melk na afkalven'  as [description]
                
                
            FROM t_animal_calvings 
            WHERE MilkDeliveryDateTime is not null
            
            UNION 
            
            SELECT 
                cast(movementdate as date) as dat, 
                cast(movementdate as datetime) as [datetime], 
                animalserverid  ,            
                'Verhuizing' as [typ],
                'agrovision' as bron        ,
                concat('Verhuizing naar groep ',DairyFarmSiteAbbr)  as [description]
            FROM 
                T_animal_movements 
            where   
                movementtype=233
        
        UNION ALL 
            
            SELECT 
                cast(movementdate  as date) as dat,       
                cast(movementdate  as datetime)  as [datetime],       
                animalserverid  ,    
                'verhuizing' as [typ], 
                'agrovision' as bron        ,
                (movementtypename)  as [description]
                
            from 
                T_animal_movements  
            where movementtype not in (111,117,233)




        UNION ALL 
            
            SELECT 
                cast(movementdate  as date) as dat,       
                cast(movementdate  as datetime)  as [datetime],     
                animalserverid  ,    
                'For sale' as [typ], 
                'agrovision' as bron        ,
                (movementreasontypename)  as [description]
                
            from 
                T_animal_movements  
            where movementtype  in (853)





        UNION ALL 
            
            SELECT 
                cast(T_Proef_Dier.begdat  as date) as dat, 
                cast(T_Proef_Dier.begdat  as datetime) as [datetime], 
                dienum as animalserverid,
                'onderzoek' as [typ],
                'coordinator' as bron        ,        
                concat('Start: ', cast(t_proef.PrfNam as varchar) collate Latin1_General_CI_AS,  ' proef ' )   as [description]
            FROM T_Proef_Dier left join t_proef on t_proef.prfcod=t_proef_dier.prfcod
            
        UNION ALL 
            
            SELECT 
                cast(T_Proef_Dier.enddat as date) as dat, 
                cast(T_Proef_Dier.enddat as datetime) as dat, 
                cast(dienum as int) as animalserverid,
                'onderzoek' as [typ], 
                'coordinator' as bron        ,        

                concat('Einde: ', cast(t_proef.PrfNam as varchar) collate Latin1_General_CI_AS, ' proef')   as [description]
                
            FROM T_Proef_Dier    
            LEFT JOIN 
                t_proef on t_proef.prfcod=t_proef_dier.prfcod
            where T_Proef_Dier.enddat  is not null
        UNION ALL
            
            SELECT 
                cast(T_Proef_Dier.enddat as date) as dat, 
                cast(T_Proef_Dier.enddat as datetime) as dat, 
                cast(dienum as int) as animalserverid,
                'onderzoek' as [typ], 
                'coordinator' as bron        ,        
                concat('Einde: ', cast(t_proef.PrfNam as varchar) collate Latin1_General_CI_AS, ' proef')   as [description]
            FROM 
                T_Proef_Dier    
            LEFT JOIN 
                t_proef on t_proef.prfcod=t_proef_dier.prfcod
            where T_Proef_Dier.enddat  is not null
                


                
    ) as dasfd
