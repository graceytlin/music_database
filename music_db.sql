CREATE DATABASE IF NOT EXISTS Music_Db;

USE Music_Db;

CREATE TABLE IF NOT EXISTS Person
(
  ID VARCHAR(255) NOT NULL UNIQUE,
  Forename VARCHAR(255) NOT NULL,
  Surname VARCHAR(255) NOT NULL,
  DOB DATE NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS Customer
(
  Customer_ID VARCHAR(255) NOT NULL UNIQUE,
  Email TEXT(2083),
  Password CHAR(64),
  PRIMARY KEY (Customer_ID),
  FOREIGN KEY (Customer_ID) REFERENCES Person(ID)
);

CREATE TABLE IF NOT EXISTS Artist
(
  Stage_Name VARCHAR(255) NOT NULL UNIQUE,
  Label VARCHAR(255) NOT NULL,
  Website TEXT(2083),
  Origin VARCHAR(255),
  PRIMARY KEY (Stage_Name),
  FOREIGN KEY (Stage_Name) REFERENCES Person(ID)
);

CREATE TABLE IF NOT EXISTS Artist_Genre
(
  Artist_ID VARCHAR(255) NOT NULL,
  Genre ENUM('Alternative', 'Blues', 'Classical', 'Country', 'Dance', 'Electronic', 'Hip-Hop', 'Indie', 'Jazz', 'K-Pop', 'Latin', 'Lo-fi', 'Metal', 'Pop', 'Punk', 'R&B', 'Reggae', 'Rock', 'Soul'),
  PRIMARY KEY (Artist_ID, Genre),
  FOREIGN KEY (Artist_ID) REFERENCES Artist(Stage_Name)
);

CREATE TABLE IF NOT EXISTS Purchase
(
  Purchase_ID INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
  Quantity MEDIUMINT,
  Customer VARCHAR(255) NOT NULL,
  Item ENUM('Ticket', 'Album') NOT NULL,
  PRIMARY KEY (Purchase_ID),
  FOREIGN KEY (Customer) REFERENCES Customer(Customer_ID)
);

CREATE TABLE IF NOT EXISTS Album
(
  ISMN VARCHAR(255) UNIQUE,
  Name VARCHAR(255) NOT NULL,
  Length TIME NOT NULL,
  Price DECIMAL(4,2) NOT NULL DEFAULT 00.00,
  Release_Date DATE NOT NULL,
  Number_Of_Songs TINYINT NOT NULL,
  PRIMARY KEY (ISMN)
);

CREATE TABLE IF NOT EXISTS Album_Genre
(
  Album_ID VARCHAR(255) NOT NULL,
  Genre ENUM('Alternative', 'Blues', 'Classical', 'Country', 'Dance', 'Electronic', 'Hip-Hop', 'Indie', 'Jazz', 'K-Pop', 'Latin', 'Lo-fi', 'Metal', 'Pop', 'Punk', 'R&B', 'Reggae', 'Rock', 'Soul'),
  PRIMARY KEY (Album_ID, Genre),
  FOREIGN KEY (Album_ID) REFERENCES Album(ISMN)
);

CREATE TABLE IF NOT EXISTS Venue
(
  Name VARCHAR(255) NOT NULL UNIQUE,
  Capacity MEDIUMINT UNSIGNED NOT NULL,
  City VARCHAR(255) NOT NULL,
  Country VARCHAR(255) NOT NULL,
  PRIMARY KEY (Name)
);

CREATE TABLE IF NOT EXISTS Tour
(
  Name VARCHAR(255) NOT NULL UNIQUE,
  Number_Of_Stops TINYINT UNSIGNED NOT NULL,
  Start_Date DATE NOT NULL,
  End_Date DATE NOT NULL,
  PRIMARY KEY (Name)
);

CREATE TABLE IF NOT EXISTS Concert
(
  Name VARCHAR(255) NOT NULL UNIQUE,
  Start_Date DATE NOT NULL,
  End_Date DATE NOT NULL,
  Start_Time TIME NOT NULL,
  Curfew TIME NOT NULL,
  Tickets_Available MEDIUMINT UNSIGNED NOT NULL,
  Ticket_Release DATE NOT NULL,
  Venue VARCHAR(255) NOT NULL,
  PRIMARY KEY (Name),
  FOREIGN KEY (Venue) REFERENCES Venue(Name)
);

CREATE TABLE IF NOT EXISTS Tour_Stop
(
  Stop_Number VARCHAR(255) NOT NULL UNIQUE,
  Tour VARCHAR(255) NOT NULL,
  PRIMARY KEY (Stop_Number),
  FOREIGN KEY (Stop_Number) REFERENCES Concert(Name),
  FOREIGN KEY (Tour) REFERENCES Tour(Name)
);

CREATE TABLE IF NOT EXISTS Festival
(
  Name VARCHAR(255) NOT NULL UNIQUE,
  Number_Of_Acts TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (Name),
  FOREIGN KEY (Name) REFERENCES Concert(Name)
);

CREATE TABLE IF NOT EXISTS Headline_Acts
(
  Festival VARCHAR(255) NOT NULL,
  Headline_Act VARCHAR(255),
  PRIMARY KEY (Festival, Headline_Act),
  FOREIGN KEY (Festival) REFERENCES Festival(Name)
);

CREATE TABLE IF NOT EXISTS Ticket
(
  Ticket_ID INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
  Type ENUM('V.I.P.', 'Standing', 'Seated') NOT NULL,
  Price DECIMAL(8,2) UNSIGNED NOT NULL DEFAULT 00.00,
  Purchase INT UNSIGNED NOT NULL,
  PRIMARY KEY (Ticket_ID),
  FOREIGN KEY (Purchase) REFERENCES Purchase(Purchase_ID)
);

CREATE TABLE IF NOT EXISTS Purchase_Album
(
  Purchase INT UNSIGNED NOT NULL,
  Album VARCHAR(255) NOT NULL,
  PRIMARY KEY (Purchase, Album),
  FOREIGN KEY (Purchase) REFERENCES Purchase(Purchase_ID),
  FOREIGN KEY (Album) REFERENCES Album(ISMN)
);

CREATE TABLE IF NOT EXISTS Tour_Album
(
  Tour VARCHAR(255) NOT NULL,
  Album VARCHAR(255) NOT NULL,
  PRIMARY KEY (Tour, Album),
  FOREIGN KEY (Tour) REFERENCES Tour(Name),
  FOREIGN KEY (Album) REFERENCES Album(ISMN)
);

CREATE TABLE IF NOT EXISTS Artist_Album
(
  Artist VARCHAR(255) NOT NULL,
  Album VARCHAR(255) NOT NULL,
  PRIMARY KEY (Artist, Album),
  FOREIGN KEY (Artist) REFERENCES Artist(Stage_Name),
  FOREIGN KEY (Album) REFERENCES Album(ISMN)
);

CREATE TABLE IF NOT EXISTS Artist_Concert
(
  Artist VARCHAR(255) NOT NULL,
  Concert VARCHAR(255) NOT NULL,
  PRIMARY KEY (Artist, Concert),
  FOREIGN KEY (Artist) REFERENCES Artist(Stage_Name),
  FOREIGN KEY (Concert) REFERENCES Concert(Name)
);

CREATE TABLE IF NOT EXISTS Ticket_Concert
(
  Ticket INT UNSIGNED NOT NULL,
  Concert VARCHAR(255) NOT NULL,
  PRIMARY KEY (Ticket, Concert),
  FOREIGN KEY (Ticket) REFERENCES Ticket(Ticket_ID),
  FOREIGN KEY (Concert) REFERENCES Concert(Name)
);

INSERT INTO Person VALUES('6lack', 'Ricardo Valdez', 'Valentine', '1992-06-24');
INSERT INTO Person VALUES('Ariana Grande', 'Ariana', 'Grande-Butera', '1993-06-26');
INSERT INTO Person VALUES('Joji', 'George', 'Miller', '1992-09-18');
INSERT INTO Person VALUES('Marina and the Diamonds', 'Marina Lambrini', 'Diamandis', '1985-10-10');
INSERT INTO Person VALUES('Sufjan Stevens', 'Sufjan', 'Stevens', '1975-07-01');

INSERT INTO Artist VALUES ('6lack', 'Interscope', 'www.6lack.com', 'Atlanta, Georgia, U.S.');
INSERT INTO Artist VALUES ('Ariana Grande', 'Republic', 'www.arianagrande.com', 'Boca Raton, Florida, U.S.');
INSERT INTO Artist VALUES ('Joji', '88rising', 'www.ballads1.com', 'Osaka, Kansai, Japan');
INSERT INTO Artist VALUES ('Marina and the Diamonds', 'Atlantic Record', 'www.marinaandthediamonds.com', 'Brynmawr, Wales, U.K.');
INSERT INTO Artist VALUES ('Sufjan Stevens', 'Asthmatic Kitty', 'www.sufjan.com', 'Detroit, Michigan, U.S.');

INSERT INTO Artist_Genre VALUES('6lack', 'Hip-hop');
INSERT INTO Artist_Genre VALUES('6lack', 'R&B');
INSERT INTO Artist_Genre VALUES('Ariana Grande', 'R&B');
INSERT INTO Artist_Genre VALUES('Ariana Grande', 'Pop');
INSERT INTO Artist_Genre VALUES('Joji', 'Lo-fi');
INSERT INTO Artist_Genre VALUES('Joji', 'R&B');
INSERT INTO Artist_Genre VALUES('Marina and the Diamonds', 'Pop');
INSERT INTO Artist_Genre VALUES('Marina and the Diamonds', 'Dance');
INSERT INTO Artist_Genre VALUES('Marina and the Diamonds', 'Indie');
INSERT INTO Artist_Genre VALUES('Sufjan Stevens', 'Indie');
INSERT INTO Artist_Genre VALUES('Sufjan Stevens', 'Country');
INSERT INTO Artist_Genre VALUES('Sufjan Stevens', 'Rock');

INSERT INTO Person VALUES ('GL00233', 'Grace', 'Lin', '1999-06-03');
INSERT INTO Customer VALUES ('GL00233', 'gl00233@surrey.ac.uk', 't0tallyS@FE');

INSERT INTO Person VALUES ('MH', 'Megan Eleanor', 'Hughes', '2000-11-09');
INSERT INTO Customer VALUES ('MH', 'mh@surrey.ac.uk', 'Als0S@FE');

INSERT INTO Person VALUES ('DM', 'Daniel Alexander', 'Meerovitsch', '2000-11-08');
INSERT INTO Customer VALUES ('DM', 'dm@surrey.ac.uk', 'Ev3nM0reS@FE');

INSERT INTO Purchase (Quantity, Customer, Item) VALUES (2, 'GL00233', 'Album'); -- Album purchase
INSERT INTO Purchase (Quantity, Customer, Item) VALUES (4, 'DM', 'Ticket'); -- Ticket purchase
INSERT INTO Purchase (Quantity, Customer, Item) VALUES (10, 'MH', 'Album'); -- Album purchase
INSERT INTO Purchase (Quantity, Customer, Item) VALUES (3, 'GL00233', 'Ticket'); -- Ticket purchase

INSERT INTO Album VALUES ('8 25646 59108 4', 'Electra Heart', '00:46:51', '8.99', '2012-04-27', 12);
INSERT INTO Album_Genre VALUES('8 25646 59108 4', 'Pop');
INSERT INTO Album_Genre VALUES('8 25646 59108 4', 'Dance');
INSERT INTO Album_Genre VALUES('8 25646 59108 4', 'Electronic');

INSERT INTO Album VALUES ('6 02577 01692 9', 'East Atlanta Love Letter', '00:47:53', '6.99', '2018-09-14', 14);
INSERT INTO Album_Genre VALUES('6 02577 01692 9', 'Alternative');
INSERT INTO Album_Genre VALUES('6 02577 01692 9', 'Soul');
INSERT INTO Album_Genre VALUES('6 02577 01692 9', 'R&B');

INSERT INTO Album VALUES ('1 90296 93986 0', 'Ballads 1', '00:35:06', '10.99', '2018-10-26', 12);
INSERT INTO Album_Genre VALUES('1 90296 93986 0', 'Pop');
INSERT INTO Album_Genre VALUES('1 90296 93986 0', 'Hip-hop');
INSERT INTO Album_Genre VALUES('1 90296 93986 0', 'R&B');

INSERT INTO Venue VALUES ('Manchester Academy', 2600, 'Manchester', 'United Kingdom');
INSERT INTO Venue VALUES ('Heaven', 1200, 'London', 'United Kingdom');
INSERT INTO Venue VALUES ('Empire Polo Club', 12600, 'Indio, California', 'United States');
INSERT INTO Venue VALUES ('Larmer Tree Gardens', 14000, 'Tollard Royal', 'United Kingdom');

INSERT INTO Tour VALUES ('From East Atlanta With Love', 44, '2018-10-06', '2018-12-23');
INSERT INTO Tour VALUES ('The Lonely Hearts Club Tour', 79, '2012-05-27', '2013-05-29');

INSERT INTO Concert VALUES('East Atlanta Love Letter: 10', '2018-10-26', '2018-10-26', '19:00:00', '22:15:00', 1100, '2018-08-17', 'Heaven');
INSERT INTO Concert VALUES('Lonely Hearts: 32', '2012-10-06', '2012-10-06', '19:30:00', '23:00:00', 2600, '2012-02-17', 'Manchester Academy');

INSERT INTO Tour_Stop VALUES('East Atlanta Love Letter: 10', 'From East Atlanta With Love');
INSERT INTO Tour_Stop VALUES('Lonely Hearts: 32', 'The Lonely Hearts Club Tour');

INSERT INTO Concert VALUES('Coachella 2019', '2019-04-12', '2019-04-21', '11:00:00', '00:01:00', 250000, '2019-01-04', 'Empire Polo Club');
INSERT INTO Concert VALUES('End Of The Road 2015', '2015-09-04', '2015-09-06', '12:00:00', '03:00:00', 14000, '2014-09-02', 'Larmer Tree Gardens');

INSERT INTO Festival VALUES ('Coachella 2019', 167);
INSERT INTO Festival VALUES ('End Of The Road 2015', 38);

INSERT INTO Headline_Acts VALUES ('Coachella 2019', 'Ariana Grande');
INSERT INTO Headline_Acts VALUES ('End Of The Road 2015', 'Sufjan Stevens');

INSERT INTO Ticket (Type, Price, Purchase) VALUES('V.I.P.', '1000.00', (SELECT Purchase_ID FROM Purchase WHERE Quantity=4 AND Item='Ticket' LIMIT 1));
INSERT INTO Ticket (Type, Price, Purchase) VALUES('Standing', '300.00', (SELECT Purchase_ID FROM Purchase WHERE Quantity=4 AND Item='Ticket' LIMIT 1));
INSERT INTO Ticket (Type, Price, Purchase) VALUES('Seated', '100.00', (SELECT Purchase_ID FROM Purchase WHERE Quantity=4 AND Item='Ticket' LIMIT 1));
INSERT INTO Ticket (Type, Price, Purchase) VALUES('Standing', '300.00', (SELECT Purchase_ID FROM Purchase WHERE Quantity=4 AND Item='Ticket' LIMIT 1));

INSERT INTO Ticket (Type, Price, Purchase) VALUES('V.I.P.', '300.00', (SELECT Purchase_ID FROM Purchase WHERE Quantity=3 AND Item='Ticket' LIMIT 1));
INSERT INTO Ticket (Type, Price, Purchase) VALUES('Standing', '80.00', (SELECT Purchase_ID FROM Purchase WHERE Quantity=3 AND Item='Ticket' LIMIT 1));
INSERT INTO Ticket (Type, Price, Purchase) VALUES('Standing', '40.00', (SELECT Purchase_ID FROM Purchase WHERE Quantity=3 AND Item='Ticket' LIMIT 1));

INSERT INTO Purchase_Album VALUES ((SELECT Purchase_ID FROM Purchase WHERE Quantity=2 AND Item='Album'), (SELECT ISMN FROM Album WHERE Name='Electra Heart'));
INSERT INTO Purchase_Album VALUES ((SELECT Purchase_ID FROM Purchase WHERE Quantity=10 AND Item='Album'), (SELECT ISMN FROM Album WHERE Name='Ballads 1'));

INSERT INTO Tour_Album VALUES ('From East Atlanta With Love', (SELECT ISMN FROM Album WHERE Name='East Atlanta Love Letter'));
INSERT INTO Tour_Album VALUES ('The Lonely Hearts Club Tour', (SELECT ISMN FROM Album WHERE Name='Electra Heart'));

INSERT INTO Artist_Album VALUES ('6lack', (SELECT ISMN FROM Album WHERE Name='East Atlanta Love Letter'));
INSERT INTO Artist_Album VALUES ('Marina and the Diamonds', (SELECT ISMN FROM Album WHERE Name='Electra Heart'));
INSERT INTO Artist_Album VALUES ('Joji', (SELECT ISMN FROM Album WHERE Name='Ballads 1'));

INSERT INTO Artist_Concert VALUES ('6lack', 'East Atlanta Love Letter: 10');
INSERT INTO Artist_Concert VALUES ('Marina and the Diamonds', 'Lonely Hearts: 32');

INSERT INTO Ticket_Concert SELECT Ticket_ID, 'Coachella 2019' FROM Ticket WHERE Purchase=4;
INSERT INTO Ticket_Concert SELECT Ticket_ID, 'East Atlanta Love Letter: 10' FROM Ticket WHERE Purchase=2;
