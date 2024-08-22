Use platformdb1;
DROP TABLE IF EXISTS SizeBracket;

CREATE TABLE SizeBracket (
    size_bracket_id INT AUTO_INCREMENT PRIMARY KEY,
    size_bracket_name VARCHAR(255) NOT NULL
);

-- Drop the foreign key constraint directly
-- ALTER TABLE RawData
-- DROP FOREIGN KEY category_fk_1;

-- drop the index 
-- ALTER TABLE Category
-- DROP INDEX Category;

CREATE INDEX SizeBracket
ON SizeBracket(size_bracket_id);