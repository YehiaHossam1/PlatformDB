Use platformdb1;
DROP TABLE IF EXISTS market;

CREATE TABLE Market (
    id INT AUTO_INCREMENT PRIMARY KEY,
    market_name VARCHAR(255) NOT NULL
);