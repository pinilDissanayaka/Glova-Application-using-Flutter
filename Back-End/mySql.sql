CREATE DATABASE Glova;


USE Glova;

SHOW TABLES;

CREATE TABLE users(
	userId INT auto_increment primary key,
	userName VARCHAR(100) NOT NULL UNIQUE,
    passWord VARCHAR(20) NOT NULL
    );
    
DROP TABLE users;
    
SHOW TABLES;
    
INSERT INTO users(userName, passWord) VALUE ("root", "root") 

SELECT * FROM users;

