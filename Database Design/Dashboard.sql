use platformdb1;
CREATE TABLE dashboard (
    id INT AUTO_INCREMENT PRIMARY KEY,
    brand_id INT,
    derived_calculations_id INT,
    target_value DECIMAL(10, 4) DEFAULT NULL,
    actual_value DECIMAL(10, 4) DEFAULT NULL,
    last_update DATETIME DEFAULT NULL,
    description TEXT DEFAULT NULL,
    rgm_index DECIMAL(10, 4) NULL,
    trade_vs_brand_idx DECIMAL(10, 4) DEFAULT NULL,
    price_change_idx DECIMAL(10, 4) DEFAULT NULL,
    FOREIGN KEY (brand_id) REFERENCES Brand(brand_id),
    FOREIGN KEY (derived_calculations_id) REFERENCES DerivedCalculations(id)
);

ALTER TABLE dashboard DROP FOREIGN KEY dashboard_ibfk_2;
ALTER TABLE dashboard DROP FOREIGN KEY dashboard_ibfk_1;

alter TABLE dashboard ADD COLUMN brand_id INT;
ALTER TABLE dashboard ADD CONSTRAINT dashboard_ibfk_3 FOREIGN KEY (brand_id) REFERENCES Brand(brand_id);

ALTER TABLE dashboard ADD CONSTRAINT dashboard_ibfk_2 FOREIGN KEY (derived_calculations_id) REFERENCES  DerivedCalculations(id);

alter table dashboard drop derived_calculations_id;
-- Truncate table dashboard 

	

