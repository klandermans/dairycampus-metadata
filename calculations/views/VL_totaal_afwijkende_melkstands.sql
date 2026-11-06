create view VL_totaal_afwijkende_melkstands as 

select * from (

select  
    milkingdate, 
    stand
    -- pak een rollend gemiddelde per stand per dag
    ,    avg(dev) OVER(
            PARTITION BY stand
            ORDER BY milkingdate
            ROWS BETWEEN 7 PRECEDING AND CURRENT ROW )
        as dev2


 from (
select 
    milkingdate, 
    milkingplace as stand,
    -- avg(dev) as afwijking_tov_weekgem_koe,
   -- window functie om rollend weekgemiddelde te krijgen van de afwijkingen
    avg(dev) as dev
from  (
    select milkingplace, animalno, milkingdate, milkquantitymass / 
    -- window functie voor rollend gemiddelde per koe
    avg(milkquantitymass) OVER(
            PARTITION BY animalno
            ORDER BY milkingdate
            ROWS BETWEEN 15 PRECEDING AND CURRENT ROW )
        as dev
    
    from 
        tb_animal_milkings
    where milkingplace>0 and milkingplace<41 and milkquantitymass >0
) as ss



group by milkingplace, milkingdate

) as asfd 
) as fin where
 abs(1-dev2) > 0.05
 and 
milkingdate>'2018-01-01'

-- order by milkingdate, stand