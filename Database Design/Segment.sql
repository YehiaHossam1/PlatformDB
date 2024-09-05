Use platformdb1;
DROP TABLE IF EXISTS Segment;

CREATE TABLE Segment (
    Segment_id INT AUTO_INCREMENT PRIMARY KEY,
    Segment_name VARCHAR(255) NOT NULL
);


-- drop the index 
-- ALTER TABLE Segment
-- DROP INDEX Segment;

CREATE INDEX Segment
ON Segment(Segment_id);

-- ALTER TABLE rawdata DROP FOREIGN KEY rawdata_ibfk_4;
-- TRUNCATE TABLE Segment;
-- ALTER TABLE rawdata ADD CONSTRAINT rawdata_ibfk_4 FOREIGN KEY (Segment_id) REFERENCES Segment(Segment_id);
