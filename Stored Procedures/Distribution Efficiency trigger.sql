Use platformdb1;

DELIMITER $$

CREATE TRIGGER distribution_efficiency_insertion
AFTER INSERT ON rawdata
FOR EACH ROW
BEGIN
    DECLARE dist_eff DECIMAL(10, 2);
    
    -- Calculate distribution efficiency
    SET dist_eff = NEW.value_sales / NEW.wod;

    -- Insert the calculated value into the distribution_efficiency table
    INSERT INTO distribution_efficiency (rawdata_id, distribution_efficiency)
    VALUES (NEW.ID, dist_eff);
END $$

DELIMITER ;
