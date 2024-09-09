use platformdb1;

drop table if exists Channel;
create table channel (
	Id int primary key auto_increment,
    channel_name VARCHAR(255) NOT NULL
)

