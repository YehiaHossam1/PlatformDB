use platformdb1;

create table Promotions(
ID INT AUTO_INCREMENT PRIMARY KEY,
rawdata_id INT,
Status Bool,

FOREIGN KEY (rawdata_id) REFERENCES RawData(ID)
);

