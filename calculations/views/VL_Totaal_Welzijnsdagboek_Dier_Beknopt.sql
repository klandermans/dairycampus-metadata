-- SET ANSI_NULLS ON
-- SET ANSI_NULLS ON;
-- SET QUOTED_IDENTIFIER ON;
-- SET ANSI_PADDING ON;
-- SET ANSI_WARNINGS ON;
-- SET CONCAT_NULL_YIELDS_NULL ON;
-- SET ARITHABORT ON;

-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO

    CREATE view [dbo].[VL_Totaal_Welzijnsdagboek_Dier_Beknopt] 
    

    
    AS

    select  
        dat, 
        animalserverid, 
        typ, 
        bron, 
        [description] 
    
    from (

            SELECT 
                cast([TreatmentDate]  as date) as dat
                
                ,t_animal_diagnosis.AnimalServerID
                , concat('Behandeling: ',T_Animal_TreatmentActions.TreatmentEntityTypeName) as typ
                , 'agrovision' as  bron

                , concat(
                    iif(t_animal_diagnosis.DiagnosisDate <> treatmentdate, concat('Diagnose van: ',cast(t_animal_diagnosis.DiagnosisDate as date) , ' Behandeling: '),''),
                    t_animal_diagnosis.disorderdesc, ' - ',
                    
                    [MedicineDesc], 
                    ' ', 
                    iif([ApplyTypeName]<>'Undefined',[ApplyTypeName],null),
                    ' ', 
                    iif(t_animal_treatmentactions.DiagnosisLocationLF=1,'-LV ', null),
                    iif(t_animal_treatmentactions.DiagnosisLocationLR=1,'-LA ', null),
                    iif(t_animal_treatmentactions.DiagnosisLocationRF=1,'-RV ', null),
                    iif(t_animal_treatmentactions.DiagnosisLocationRR=1,'-RA ', null)
                )  as [description]



            FROM [dbo].[T_Animal_TreatmentActions] 
            left join [dbo].t_animal_diagnosis on t_animal_treatmentactions.animaldiagnosisid=t_animal_diagnosis.animaldiagnosisid

        UNION ALL
            
            SELECT 
                [FertilityStateDate] as dat
                
                ,[AnimalServerID]
                
                ,concat('Fertiliteit: ', [MainEntityTypeName]) as typ
                , 'agrovision' as  bron
                ,concat([FertilityStateTypeName], ' ' ,[EventCommentAbbr])  as [description]
            FROM [dbo].[T_Animal_FertilityStatus]

        UNION ALL
                -- select dat,dienum, typ, bron, [description] from (    
                    select 
                        dat, 
                        animalserverid as dienum, 
                        'digiklauw' as typ, 
                        'digiklauw' as  bron,
                        [description]
                    from 
                        (
                            select Diernr, [behandeld op],concat(aandoening,'LA:', LA,'RA:', RA,'LV:', LV,'RV:',RV)  as [description] from  [dbo].t_raw_digiklauw ) as dk
                    left join 
                        (select dat, oornum, animalserverid from [dbo].tvl_totaal_sub_stal) as sss  on dat=[behandeld op] and  Diernr =oornum
    
        UNION ALL
            
            SELECT 
                cast([MatingDate] as date) as [dat]
                
                ,[AnimalServerID]
                , concat('Inseminatie: ', [MatingTypeName]) as typ
                , 'agrovision' as  bron        
                
                , concat('Stier ',[BullName] , ' (' ,[BullRegistrationId],')',                'Conceptie datum: ', cast(conceptiondate as date),                'Laatste zwangerschapsdatum: ', cast(LastPregnantDate as date))  as [description]
            FROM [dbo].[T_Animal_Matings]

        UNION ALL

            SELECT 
                cast([createdate] as date)  as dat
                
                ,an.[AnimalServerID]
                ,concat('meldingen: ', [title]) as typ
                , concat('app:', username) as  bron
                ,concat(cast([description] as varchar(1024)), iif(photo=1,concat('<img src="/mobile/meldingen/photo/',t_proef_melding.id,'.jpg" >'),''))  as [description]
            FROM [dbo].[t_proef_melding] 
            left join 
                [dbo].t_animals as an on t_proef_melding.animalserverid=an.animalserverid
            left join [dbo].t_proef_users on userid=t_proef_users.id
            where an.animalserverid>0

        UNION ALL


            select 
                child.birthdate as dat,
                mother.animalserverid  ,
                
                'afkalven' as typ,         
                'agrovision' as bron        ,
                concat(lactationno,' kalf- ', child.GenderTypeName) as [description]
                
            from 
                [dbo].t_animals as mother 
            left join 
                [dbo].t_animals as child on mother.Animalid=child.MotherAnimalID
            LEFT JOIN 
               [dbo]. T_Animal_Calvings ON mother.AnimalServerID=T_Animal_Calvings.ANIMALSERVERID AND CalvingDate=child.birthdate
            
            
        UNION ALL

        
            
            SELECT 
                movementdate as dat, 
                animalserverid  ,            
                'Verhuizing' as [typ],
                'agrovision' as bron        ,
                concat('Verhuizing naar groep ',DairyFarmSiteAbbr)  as [description]
            FROM 
                [dbo].T_animal_movements 
            where   
                movementtype=233
        
        UNION ALL 
            
            SELECT 
                movementdate as dat,       
                animalserverid  ,    
                'verhuizing' as [typ], 
                'agrovision' as bron        ,
                (movementtypename)  as [description]
                
            from 
                [dbo].T_animal_movements  
            where 
                movementtype not in (111,117,233)




        UNION ALL 
            
            SELECT 
                movementdate as dat,       
                animalserverid  ,    
                'For sale' as [typ], 
                'agrovision' as bron        ,
                (movementreasontypename)  as [description]
                
            from 
                [dbo].T_animal_movements  
            where 
                movementtype  in (853)




                
    ) as dasfd
