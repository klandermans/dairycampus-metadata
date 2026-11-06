
CREATE procedure [dbo].[DC_Build_TVL_Tables]( @view NVARCHAR(MAX)='construct') as
/**
 * BUILD TVL TABLES MODEL
 * OLD LEGACY COMMENTS BELOW
 **/
-- =============================================
-- Author:		Hans van den Heuvel
-- Create date: 1-dec-2016
-- 
-- Procedure kopieert i.v.m. performnace de DierDatum-views naar tabellen
-- 
-- 16-2-2017: Te vaak kan een sleutel niet worden gezet i.v.m. dubbelen
--				Daarom kolom RowID toegevoegd.

-- 7-1-2019: Drop table eigen Try - Catch gegeven. Als de tabel er niet is, is dat geen foutsituatie meer.
--
begin
    --awesome constructor
    if @view='construct' BEGIN

 



        
        select getdate() as dat, * into #tvlmlk from VL_ControleMelkgift_CT
        drop table if exists TVL_ControleMelkgift_CT
        select * into TVL_ControleMelkgift_CT from #tvlmlk 

        select getdate() as dat, * into #tvlkv from VL_ControleKrachtvoer_CT
        drop table if exists TVL_ControleKrachtvoer_CT
        select * into TVL_ControleKrachtvoer_CT from #tvlkv 

        select getdate() as dat, * into #tvlrv from VL_ControleRuwvoer_CT
        drop table if exists TVL_ControleRuwvoer_CT
        select * into TVL_ControleRuwvoer_CT from #tvlrv 



    end
    -- process function
    -- EXECUTE DC_Log 'SP_Construct SP_Construct', ' '

    if @view='vl_totaal_bedrijf' BEGIN
        return 
    end
    if @view<>'construct' BEGIN      
        
            print(@view)
            -- declare @view varchar(30)    
            -- set @view = 'VL_Dier_Aanwezig'
            declare @temp varchar(255)
            set @temp = concat('#T',@view)
            
            declare @dest varchar(255)
            set @dest =  concat('T',@view)
            declare @query VARCHAR(MAX)

            -- dit lijkt onlogisch, maar zonder de query in 1 x uit te voeren is het #tmp bestand soms wel ens oms niet aanwezig
            
            
            set  @query = 'BEGIN Try'
                set @query = @query +CHAR(10)
                -- set @query = @query +'BEGIN tran t1'
                set @query = @query +CHAR(10)
                set @query = @query +'drop table if exists '+ @temp+';'
                set @query = @query +CHAR(10)
                set @query = @query +' SELECT * Into '+ @temp +' From '+ @view
                set @query = @query +CHAR(10)
                -- set @query = @query +'ALTER TABLE ['+@temp+'] add  RowID int identity(1,1);'
                -- set @query = @query +CHAR(10)
                -- set @query = @query +'ALTER TABLE ['+@temp+'] ADD PRIMARY KEY (RowID);'
                -- set @query = @query +CHAR(10)
                set @query = @query +' drop table if exists '+ @dest+'; '
                set @query = @query +CHAR(10)
                set @query = @query +' SELECT * Into '+ @dest +' From '+ @temp
                set @query = @query +CHAR(10)
                -- set @query = @query +'commit tran t1'
                set @query = @query +CHAR(10)
            set @query = @query +'end try '
            set @query = @query +CHAR(10)
            set @query = @query +'begin catch '
                set @query = @query +CHAR(10)
                -- set @query = @query +'rollback tran t1'
                set @query = @query +CHAR(10)
                set @query = @query +'print(''fail'')'
                set @query = @query +CHAR(10)
        set @query = @query +'end  catch'+'; '
        print(@query)            
        exec(@query)
            
        Begin Try EXEC(N'Create clustered Index IDX_@dest_Dienum On '+@dest+' (dienum)')         End Try Begin Catch  End Catch
        Begin Try EXEC(N'Create clustered Index IDX_@dest_Oornum On '+@dest+' (oornum)')         End Try Begin Catch  End Catch
        Begin Try EXEC(N'Create clustered Index IDX_@dest_Dat On '+@dest+' (dat)')               End Try Begin Catch  End Catch
        Begin Try EXEC(N'Create clustered Index IDX_@dest_DatOornum On '+@dest+' (dat, Oornum)') End Try Begin Catch  End Catch
        Begin Try EXEC(N'Create clustered Index IDX_@dest_DatDieNum On '+@dest+' (dat, DieNum)') End Try Begin Catch  End Catch
        Begin Try EXEC(N'Create clustered Index IDX_@dest_prfcod On '+@dest+' (prfcod)')         End Try Begin Catch  End Catch
        Begin Try EXEC(N'Create clustered Index IDX_@dest_hok On '+@dest+' (hok)')               End Try Begin Catch  End Catch
        
    end
end












