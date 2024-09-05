use platformdb1;
-- Create Fact Table

CREATE TABLE RawData (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    sku_id INT,
    date INT,
    size_bracket_id INT,
    segment_id INT,
    reigon_id INT,
    brand_id INT,
    value_sales DECIMAL(10, 2),
    volume_sales DECIMAL(10, 2),
    WOD DECIMAL(10, 2),
    FOREIGN KEY (sku_id) REFERENCES SKU(sku_id),
    FOREIGN KEY (size_bracket_id) REFERENCES sizebracket(size_bracket_id),
    FOREIGN KEY (segment_id) REFERENCES segment(segment_id),
    FOREIGN KEY (reigon_id) REFERENCES reigon(reigon_id),
    FOREIGN KEY (brand_id) REFERENCES Brand(brand_id)
);


CREATE INDEX RawData
ON RawData(Id);

ALTER TABLE rawdata DROP FOREIGN KEY rawdata_ibfk_4;
ALTER TABLE rawdata ADD CONSTRAINT rawdata_ibfk_3 FOREIGN KEY (size_bracket_id) REFERENCES sizebracket(size_bracket_id);

