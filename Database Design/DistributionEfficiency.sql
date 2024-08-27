Create Table DistributionEfficiency(
	id INT AUTO_INCREMENT PRIMARY KEY,
    rawdata_id INT,
    distributionEfficiency decimal(10,2),
    FOREIGN KEY (rawdata_id) REFERENCES rawdata(ID)
    );
    
 
-- Trigger that makes the data calculates automatically the distrubtion effeciency when ingesting the data
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
    


