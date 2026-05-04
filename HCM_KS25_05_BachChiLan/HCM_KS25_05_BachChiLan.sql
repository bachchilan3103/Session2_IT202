CREATE DATABASE ESportsManagement;
USE ESportsManagement;

CREATE TABLE Team (
    team_id VARCHAR(10) PRIMARY KEY,
    team_name VARCHAR(100) NOT NULL UNIQUE,
    region VARCHAR(50) NOT NULL,
    owner VARCHAR(100),
    founded_year INT CHECK (founded_year >= 1900)
);

CREATE TABLE Player (
    player_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    nick_name VARCHAR(50) NOT NULL UNIQUE,
    position VARCHAR(20) NOT NULL,
    salary DECIMAL(12,2) NOT NULL CHECK (salary >= 0),
    team_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (team_id) REFERENCES Team(team_id)
);

CREATE TABLE Matches (
    match_id VARCHAR(10) PRIMARY KEY,
    start_time DATETIME NOT NULL,
    result VARCHAR(10) NOT NULL
);

CREATE TABLE Match_Statistic (
    match_id VARCHAR(10) NOT NULL,
    player_id VARCHAR(10) NOT NULL,
    kills INT DEFAULT 0 CHECK (kills >= 0),
    deaths INT DEFAULT 0 CHECK (deaths >= 0),
    assists INT DEFAULT 0 CHECK (assists >= 0),
    PRIMARY KEY (match_id, player_id),
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    FOREIGN KEY (player_id) REFERENCES Player(player_id)
);

ALTER TABLE Matches
ADD prize DECIMAL(15,2) DEFAULT 0;

ALTER TABLE Team
CHANGE region area VARCHAR(50);

DROP TABLE Match_Statistic;
DROP TABLE Matches;

INSERT INTO Team 
VALUES ('T01', 'GAM Esports', 'Vietnam', 'GAM Corp', 2014),  
       ('T02', 'T1', 'Korea', 'SK Telecom', 2003),
       ('T03', 'G2 Esports', 'Europe', 'Carlos', 2015),
	   ('T04', 'EDG', 'China', 'EDG Group', 2013),
       ('T05', 'Cloud9', 'USA', NULL, 2012);
       
INSERT INTO Player 
VALUES ('P01', 'Nguyen Van A', 'Levi', 'Jungler', 100000000, 'T01'),
       ('P02', 'Tran Van B', 'Kati', 'Mid', 80000000, 'T01'),
       ('P03', 'Lee Sang Hyeok', 'Faker', 'Mid', 150000000, 'T02'),
	   ('P04', 'Gumayusi', 'Guma', 'ADC', 90000000, 'T02'),
       ('P05', 'Caps', 'Caps', 'Mid', 120000000, 'T03');
       
INSERT INTO Matches 
VALUES ('MS01', '2025-01-01 18:00:00', '2-1', 5000000),
       ('MS02', '2025-01-02 18:00:00', '2-0', 7000000),
       ('MS03', '2025-01-03 18:00:00', '1-2', 6000000),
       ('MS04', '2025-01-04 18:00:00', '2-1', 8000000),
       ('MS07', '2025-01-07 18:00:00', '2-0', 10000000);
       
INSERT INTO Match_Statistic 
VALUES ('MS01', 'P01', 10, 2, 5),
       ('MS01', 'P02', 5, 3, 8),
       ('MS02', 'P03', 12, 1, 6),
       ('MS03', 'P04', 7, 4, 3),
       ('MS07', 'P05', 9, 2, 7);
       
UPDATE Player
SET salary = salary * 1.2
WHERE position = 'Jungler';

DELETE FROM Team
WHERE owner IS NULL;

SELECT *
FROM Player
WHERE salary BETWEEN 50000000 AND 150000000;

SELECT *
FROM Matches
WHERE match_id = 'MS07';

SELECT TeamID
FROM Team
WHERE Region = 'Vietnam';

SELECT Nickname, Position
FROM Player
WHERE TeamID = 'T01';