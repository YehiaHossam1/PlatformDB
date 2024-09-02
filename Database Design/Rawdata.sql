use platformdb1;
-- Create Fact Table

CREATE TABLE RawData (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    sku_id INT,
    date INT,
    size_bracket_id INT,
    category_id INT,
    reigon_id INT,
    brand_id INT,
    value_sales DECIMAL(10, 2),
    volume_sales DECIMAL(10, 2),
    WOD DECIMAL(10, 2),
    FOREIGN KEY (sku_id) REFERENCES SKU(sku_id),
    FOREIGN KEY (size_bracket_id) REFERENCES sizebracket(size_bracket_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id),
    FOREIGN KEY (reigon_id) REFERENCES reigon(reigon_id),
    FOREIGN KEY (brand_id) REFERENCES Brand(brand_id)
);


CREATE INDEX RawData
ON RawData(Id);

-- ALTER TABLE rawdata DROP FOREIGN KEY rawdata_ibfk_4;
-- TRUNCATE TABLE Category;
-- ALTER TABLE rawdata ADD CONSTRAINT rawdata_ibfk_4 FOREIGN KEY (category_id) REFERENCES Category(Category_id);

