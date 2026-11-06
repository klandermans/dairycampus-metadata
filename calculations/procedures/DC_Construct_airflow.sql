
CREATE PROCEDURE [dbo].[DC_Construct_airflow]
AS
BEGIN
    /*
     * Bert Klandemrans construct all tvl indexes
     */
    DECLARE @RC int

    -- BEGIN TRY
    --     EXECUTE DC_Log 'Construct start fix import', ' '

    --     -- er zitten dubbele beesten in de database deze gooi ik er eerst uit .
    --     delete from t_animals where animalid in (
    --     select min(animalid) from t_animals group by animalserverid having count(*) > 1)
    --     -- er zitten beesten zonder ID in de database, deze gooi ik er uit
    --     delete from T_Animals where animalserverid is null
    --     -- maak een nieuwe primary key aan
    --     drop index if exists T_Animals.Idx_Animals_AnimalServerId;
    --     ALTER TABLE T_Animals Alter COLUMN AnimalServerId int not null;
    --     EXECUTE DC_Log 'Construct end fix import', ' '
    -- END TRY
    -- BEGIN CATCH
    --     EXECUTE DC_Log 'Construct ERROR fix import', ' '
    -- END catch
    

    BEGIN try

insert into t_proef_melding_proef (t_proef_melding_id, prfcod)
select distinct
t_proef_melding.id,    tvl_dier_datum_proef.prfcod 
from t_proef_melding
left join tvl_dier_datum_proef on cast(dat as date)=cast(createdate as date) and dienum=animalserverid
left join t_proef_melding_proef on t_proef_melding_proef.prfcod=tvl_dier_datum_proef.prfcod and t_proef_melding.id=t_proef_melding_id
where tvl_dier_datum_proef.prfcod  is not null
and t_proef_melding_proef.prfcod is  null






        -- stukje code om een snelle tabel aan te maken met history langer dan 4 jaar
        EXECUTE DC_Log 'Construct start tbat', ' '
        drop table if exists TBAT_Animal_Milkings

        select *  into TBAT_Animal_Milkings 
        from (
            select milkquantitymass,milkingdate,animalserverid 
            from tba_animal_milkings 
            union all 
            select milkquantitymass,milkingdate,animalserverid 
            from tb_animal_milkings
        ) as mmm
        CREATE NONCLUSTERED INDEX Idx_nimal_Milkings_AnimalServerId  ON TBAT_Animal_Milkings  (AnimalServerId);   
        CREATE NONCLUSTERED INDEX Idx_nimal_Milkings_MilkingDate ON TBAT_Animal_Milkings  (MilkingDate);   
        EXECUTE DC_Log 'Construct end tbat', ' '
    end TRY
    begin CATCH
        EXECUTE DC_Log 'Construct ERROR tbat', ' '
    end catch
    
    EXECUTE DC_Log 'Construct finished SP_Construct', ' '
    

    drop table if exists  T_RAW_velos_summary_verwijderen
    SELECT 
            0 as [animalserverid]
        , 0 as [cow]
        ,[velos_cow]
        ,[date]
        ,[type]
        ,max([seconds]) as seconds
        ,max([total]) as total
        ,max([average]) as average
        ,0 as [attention]
        ,2 as [home_location_id]
        ,0 as [location_average]
        ,[ob_type]
        ,[ob_version]
        into T_RAW_velos_summary_verwijderen
    FROM [dbo].[T_RAW_velos_summary]
    group by 
    [velos_cow]
        ,[date]
        ,[type]
        ,[ob_type]
        ,[ob_version]






    
END




