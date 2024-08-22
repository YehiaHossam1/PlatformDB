use platformdb1;

DROP PROCEDURE IF EXISTS rgm_index;

DELIMITER $$

CREATE PROCEDURE rgm_index()
Begin
	drop table if exists TempResults;
	CREATE TEMPORARY TABLE TempResults AS

	SELECT 
		brand_id,
		case 
			when volume_share = 0 then 0
			else (value_share / volume_share) 
		end AS rgm_index
	From 
		DerivedCalculations d;
	
	insert into dashboard(brand_id,rgm_index)
		SELECT brand_id, rgm_index 
		FROM TempResults;
    
	DROP TEMPORARY TABLE IF EXISTS TempResults;
END $$

DELIMITER ;


call rgm_index();

select count(*) from category;
