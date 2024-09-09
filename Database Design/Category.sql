Use platformdb1;
DROP TABLE IF EXISTS Category;

CREATE TABLE Category (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL
);