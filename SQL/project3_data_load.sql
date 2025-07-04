create database Project3;

use Project3;

# Table 1 - Users

create table users (
	user_id int,
    created_at varchar(100),
    company_id int,
    language varchar(50),
    activated_at varchar(100),
    state varchar(50)
);

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.csv"
INTO TABLE users
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select *
from users;

alter table users add column t_created_at datetime;

UPDATE users SET t_created_at = STR_TO_DATE(created_at, '%d-%m-%Y %H:%i');

alter table users drop column created_at;

alter table users change column t_created_at created_at datetime;

alter table users add column t_activated_at datetime;

UPDATE users SET t_activated_at = STR_TO_DATE(activated_at, '%d-%m-%Y %H:%i');

alter table users drop column activated_at;

alter table users change column t_activated_at activated_at datetime;

# Table 2 - Events

create table events (
	user_id int null,
    occured_at varchar(100),
    event_type varchar(50),
    event_name varchar(100),
    location varchar(50),
    device varchar(50),
    user_type int
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.csv"
INTO TABLE events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

desc events;

select *
from events;

alter table events add column t_occured_at datetime;

UPDATE events SET t_occured_at = STR_TO_DATE(occured_at, '%d-%m-%Y %H:%i');

alter table events drop column occured_at;

alter table events change column t_occured_at occured_at datetime;

# Table 3 - Email-Events

create table email_events (
	user_id int,
    occured_at varchar(100),
    action varchar(100),
    user_type int
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/email_events.csv"
INTO TABLE email_events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select *
from email_events;

alter table email_events add column t_occured_at datetime;

UPDATE email_events SET t_occured_at = STR_TO_DATE(occured_at, '%d-%m-%Y %H:%i');

alter table email_events drop column occured_at;

alter table email_events change column t_occured_at occured_at datetime;