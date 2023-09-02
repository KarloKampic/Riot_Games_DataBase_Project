DROP TABLE animacija CASCADE CONSTRAINTS;
DROP TABLE igra CASCADE CONSTRAINTS;
DROP TABLE klijent CASCADE CONSTRAINTS;
DROP TABLE igra_klijent CASCADE CONSTRAINTS;
DROP TABLE projekt CASCADE CONSTRAINTS;
DROP TABLE sjediste CASCADE CONSTRAINTS;
DROP TABLE tim CASCADE CONSTRAINTS;
DROP TABLE tim_projekt CASCADE CONSTRAINTS;
DROP TABLE zaposlenik CASCADE CONSTRAINTS;
DROP TABLE zaposlenik_tim CASCADE CONSTRAINTS;


CREATE TABLE animacija (
    animacija_id       INTEGER NOT NULL,
    naziv             VARCHAR2(25) NOT NULL,
    duljina            INTEGER NOT NULL,
    vrsta              VARCHAR2(20) NOT NULL
);

ALTER TABLE animacija ADD CONSTRAINT animacija_pk PRIMARY KEY ( animacija_id );

CREATE TABLE igra (
    igra_id           INTEGER NOT NULL,
    naziv             VARCHAR2(20) NOT NULL,
    žanr              VARCHAR2(20) NOT NULL,
    godina_izdavanja  DATE NOT NULL,
    platforma         VARCHAR2(10) NOT NULL,
    cijena            INTEGER NOT NULL
);

ALTER TABLE igra ADD CONSTRAINT igra_pk PRIMARY KEY ( igra_id );

CREATE TABLE igra_klijent (
    igra_igra_id        INTEGER NOT NULL,
    klijent_klijent_id  INTEGER NOT NULL
);

ALTER TABLE igra_klijent ADD CONSTRAINT igra_klijent_pk PRIMARY KEY ( igra_igra_id,
                                                                      klijent_klijent_id );

CREATE TABLE klijent (
    klijent_id     INTEGER NOT NULL,
    ime            VARCHAR2(15),
    prezime        VARCHAR2(15),
    "E-mail"       VARCHAR2(30) NOT NULL,
    username       VARCHAR2(30) NOT NULL,
    datum_rođenja  DATE NOT NULL
);

ALTER TABLE klijent ADD CONSTRAINT klijent_pk PRIMARY KEY ( klijent_id );

CREATE TABLE projekt (
    projekt_id              INTEGER NOT NULL,
    ime                     VARCHAR2(40) NOT NULL,
    opis                    VARCHAR2(300) NOT NULL,
    tip                     VARCHAR2(30) NOT NULL,
    status                  VARCHAR2(20) NOT NULL,
    igra_igra_id            INTEGER,
    animacija_animacija_id  INTEGER
);


ALTER TABLE projekt
    ADD CONSTRAINT arc_1 CHECK ( ( ( animacija_animacija_id IS NOT NULL )
                                   AND ( igra_igra_id IS NULL ) )
                                 OR ( ( igra_igra_id IS NOT NULL )
                                      AND ( animacija_animacija_id IS NULL ) )
                                 OR ( ( animacija_animacija_id IS NULL )
                                      AND ( igra_igra_id IS NULL ) ) );

ALTER TABLE projekt ADD CONSTRAINT projekt_pk PRIMARY KEY ( projekt_id );

CREATE TABLE sjediste (
    sjediste_id  INTEGER NOT NULL,
    naziv        VARCHAR2(30) NOT NULL,
    mjesto       VARCHAR2(30) NOT NULL
);


ALTER TABLE sjediste ADD CONSTRAINT sjediste_pk PRIMARY KEY ( sjediste_id );

CREATE TABLE tim (
    tim_id           INTEGER NOT NULL,
    naziv            VARCHAR2(30) NOT NULL,
    vrsta            VARCHAR2(20) NOT NULL,
    datum_osnivanja  DATE NOT NULL,
    broj_članova     INTEGER NOT NULL
);


ALTER TABLE tim ADD CONSTRAINT tim_pk PRIMARY KEY ( tim_id );

CREATE TABLE tim_projekt (
    tim_tim_id          INTEGER NOT NULL,
    projekt_projekt_id  INTEGER NOT NULL
);

ALTER TABLE tim_projekt ADD CONSTRAINT tim_projekt_pk PRIMARY KEY ( tim_tim_id,
                                                                    projekt_projekt_id );

CREATE TABLE zaposlenik (
    zaposlenik_id         INTEGER NOT NULL,
    ime                   VARCHAR2(15) NOT NULL,
    prezime               VARCHAR2(15) NOT NULL,
    pozicija              VARCHAR2(15) NOT NULL,
    datum_zaposlenja      DATE NOT NULL,
    plaća                 INTEGER NOT NULL,
    email                 VARCHAR2(30),
    broj_telefona         VARCHAR2(15),
    sjediste_sjediste_id  INTEGER NOT NULL
);

ALTER TABLE zaposlenik ADD CONSTRAINT zaposlenik_pk PRIMARY KEY ( zaposlenik_id );

CREATE TABLE zaposlenik_tim (
    zaposlenik_zaposlenik_id  INTEGER NOT NULL,
    tim_tim_id                INTEGER NOT NULL
);

ALTER TABLE zaposlenik_tim ADD CONSTRAINT zaposlenik_tim_pk PRIMARY KEY ( zaposlenik_zaposlenik_id,
                                                                          tim_tim_id );

ALTER TABLE projekt
    ADD CONSTRAINT projekt_animacija_fk FOREIGN KEY ( animacija_animacija_id )
        REFERENCES animacija ( animacija_id );

ALTER TABLE projekt
    ADD CONSTRAINT projekt_igra_fk FOREIGN KEY ( igra_igra_id )
        REFERENCES igra ( igra_id );

ALTER TABLE zaposlenik_tim
    ADD CONSTRAINT relation_2_tim_fk FOREIGN KEY ( tim_tim_id )
        REFERENCES tim ( tim_id );

ALTER TABLE zaposlenik_tim
    ADD CONSTRAINT relation_2_zaposlenik_fk FOREIGN KEY ( zaposlenik_zaposlenik_id )
        REFERENCES zaposlenik ( zaposlenik_id );

ALTER TABLE tim_projekt
    ADD CONSTRAINT relation_3_projekt_fk FOREIGN KEY ( projekt_projekt_id )
        REFERENCES projekt ( projekt_id );

ALTER TABLE tim_projekt
    ADD CONSTRAINT relation_3_tim_fk FOREIGN KEY ( tim_tim_id )
        REFERENCES tim ( tim_id );

ALTER TABLE igra_klijent
    ADD CONSTRAINT relation_6_igra_fk FOREIGN KEY ( igra_igra_id )
        REFERENCES igra ( igra_id );

ALTER TABLE igra_klijent
    ADD CONSTRAINT relation_6_klijent_fk FOREIGN KEY ( klijent_klijent_id )
        REFERENCES klijent ( klijent_id );

ALTER TABLE zaposlenik
    ADD CONSTRAINT zaposlenik_sjediste_fk FOREIGN KEY ( sjediste_sjediste_id )
        REFERENCES sjediste ( sjediste_id );

-- inserti za tablicu klijent --
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (1, 'Amelia', 'White', 'amelia.white@gmail.com', 'AmeliaWhite8945', TO_DATE('18.10.1991', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (2, 'Christopher', 'Clark', 'christopher.clark@gmail.com', 'ChristopherClark3238', TO_DATE('01.10.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (3, 'Olivia', 'Lewis', 'olivia.lewis@gmail.com', 'OliviaLewis8392', TO_DATE('08.12.1991', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (4, 'Andrew', 'Brown', 'andrew.brown@gmail.com', 'AndrewBrown5834', TO_DATE('09.01.1990', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (5, 'Harper', 'Davis', 'harper.davis@gmail.com', 'HarperDavis2277', TO_DATE('13.04.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (6, 'Daniel', 'White', 'daniel.white@gmail.com', 'DanielWhite5106', TO_DATE('14.09.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (7, 'James', 'Lee', 'james.lee@gmail.com', 'JamesLee5348', TO_DATE('05.05.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (8, 'Matthew', 'Jones', 'matthew.jones@gmail.com', 'MatthewJones4803', TO_DATE('13.07.1997', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (9, 'Charlotte', 'Lewis', 'charlotte.lewis@gmail.com', 'CharlotteLewis5179', TO_DATE('06.05.2002', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (10, 'Matthew', 'Jackson', 'matthew.jackson@gmail.com', 'MatthewJackson1760', TO_DATE('17.04.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (11, 'Daniel', 'Anderson', 'daniel.anderson@gmail.com', 'DanielAnderson6549', TO_DATE('13.03.1993', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (12, 'Christopher', 'Smith', 'christopher.smith@gmail.com', 'ChristopherSmith5610', TO_DATE('01.12.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (13, 'Isabella', 'Clark', 'isabella.clark@gmail.com', 'IsabellaClark6938', TO_DATE('30.10.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (14, 'Daniel', 'Garcia', 'daniel.garcia@gmail.com', 'DanielGarcia4299', TO_DATE('20.06.1996', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (15, 'William', 'Brown', 'william.brown@gmail.com', 'WilliamBrown9227', TO_DATE('07.03.1995', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (16, 'Sophia', 'Jones', 'sophia.jones@gmail.com', 'SophiaJones5556', TO_DATE('26.11.1997', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (17, 'William', 'Martinez', 'william.martinez@gmail.com', 'WilliamMartinez7128', TO_DATE('20.02.1991', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (18, 'Grace', 'Robinson', 'grace.robinson@gmail.com', 'GraceRobinson3383', TO_DATE('21.02.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (19, 'Robert', 'Taylor', 'robert.taylor@gmail.com', 'RobertTaylor3668', TO_DATE('22.02.2006', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (20, 'Daniel', 'Brown', 'daniel.brown@gmail.com', 'DanielBrown9909', TO_DATE('13.10.2002', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (21, 'Alice', 'Clark', 'alice.clark@gmail.com', 'AliceClark9013', TO_DATE('24.02.2002', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (22, 'David', 'Williams', 'david.williams@gmail.com', 'DavidWilliams4606', TO_DATE('08.10.2002', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (23, 'Christopher', 'Brown', 'christopher.brown@gmail.com', 'ChristopherBrown7073', TO_DATE('18.03.2006', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (24, 'Daniel', 'Martin', 'daniel.martin@gmail.com', 'DanielMartin6380', TO_DATE('06.05.1995', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (25, 'Andrew', 'Jackson', 'andrew.jackson@gmail.com', 'AndrewJackson6742', TO_DATE('10.11.2005', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (26, 'Joseph', 'Lewis', 'joseph.lewis@gmail.com', 'JosephLewis9058', TO_DATE('22.09.1997', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (27, 'Joseph', 'Jackson', 'joseph.jackson@gmail.com', 'JosephJackson4266', TO_DATE('25.05.1997', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (28, 'Matthew', 'Hall', 'matthew.hall@gmail.com', 'MatthewHall7063', TO_DATE('01.09.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (29, 'Harper', 'Jackson', 'harper.jackson@gmail.com', 'HarperJackson9769', TO_DATE('16.03.1997', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (30, 'Olivia', 'Robinson', 'olivia.robinson@gmail.com', 'OliviaRobinson9797', TO_DATE('01.05.1992', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (31, 'Charlotte', 'Walker', 'charlotte.walker@gmail.com', 'CharlotteWalker7888', TO_DATE('07.03.2006', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (32, 'James', 'Williams', 'james.williams@gmail.com', 'JamesWilliams9413', TO_DATE('15.04.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (33, 'David', 'Anderson', 'david.anderson@gmail.com', 'DavidAnderson7463', TO_DATE('27.05.1997', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (34, 'William', 'Moore', 'william.moore@gmail.com', 'WilliamMoore2048', TO_DATE('04.11.1990', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (35, 'James', 'Davis', 'james.davis@gmail.com', 'JamesDavis2889', TO_DATE('15.05.1993', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (36, 'Emma', 'Davis', 'emma.davis@gmail.com', 'EmmaDavis7021', TO_DATE('18.02.1994', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (37, 'Emma', 'Wilson', 'emma.wilson@gmail.com', 'EmmaWilson8032', TO_DATE('12.06.1991', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (38, 'Mia', 'Wilson', 'mia.wilson@gmail.com', 'MiaWilson8398', TO_DATE('18.02.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (39, 'Robert', 'Clark', 'robert.clark@gmail.com', 'RobertClark5030', TO_DATE('10.08.2007', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (40, 'Joseph', 'Allen', 'joseph.allen@gmail.com', 'JosephAllen5327', TO_DATE('24.03.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (41, 'William', 'Garcia', 'william.garcia@gmail.com', 'WilliamGarcia1028', TO_DATE('01.03.2006', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (42, 'Charlotte', 'Martinez', 'charlotte.martinez@gmail.com', 'CharlotteMartinez2442', TO_DATE('09.10.1993', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (43, 'Richard', 'Harris', 'richard.harris@gmail.com', 'RichardHarris7118', TO_DATE('22.03.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (44, 'Alice', 'Lewis', 'alice.lewis@gmail.com', 'AliceLewis7700', TO_DATE('09.08.1993', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (45, 'Daniel', 'Brown', 'daniel.brown@gmail.com', 'DanielBrown7756', TO_DATE('07.07.1992', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (46, 'James', 'Smith', 'james.smith@gmail.com', 'JamesSmith4499', TO_DATE('01.11.1990', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (47, 'Amelia', 'Williams', 'amelia.williams@gmail.com', 'AmeliaWilliams6963', TO_DATE('08.07.1991', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (48, 'Emily', 'Walker', 'emily.walker@gmail.com', 'EmilyWalker5340', TO_DATE('14.08.2001', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (49, 'William', 'Jones', 'william.jones@gmail.com', 'WilliamJones6368', TO_DATE('04.10.1995', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (50, 'Ella', 'Lewis', 'ella.lewis@gmail.com', 'EllaLewis8692', TO_DATE('09.04.2005', 'DD.MM.YYYY'));

INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (51, 'Oliver', 'Hoffmann', 'oliver.hoffmann@gmail.com', 'OliverHoffmann6357', TO_DATE('08.11.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (52, 'Alexander', 'Hoffmann', 'alexander.hoffmann@gmail.com', 'AlexanderHoffmann4605', TO_DATE('12.03.1999', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (53, 'Daniel', 'Lange', 'daniel.lange@gmail.com', 'DanielLange1283', TO_DATE('01.11.2001', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (54, 'Emma', 'Braun', 'emma.braun@gmail.com', 'EmmaBraun8975', TO_DATE('24.01.1994', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (55, 'Anna', 'Braun', 'anna.braun@gmail.com', 'AnnaBraun2410', TO_DATE('22.06.1997', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (56, 'Aiden', 'Schulz', 'aiden.schulz@gmail.com', 'AidenSchulz6082', TO_DATE('12.03.1999', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (57, 'Charlotte', 'Schneider', 'charlotte.schneider@gmail.com', 'CharlotteSchneider2764', TO_DATE('27.10.1996', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (58, 'Liam', 'Lange', 'liam.lange@gmail.com', 'LiamLange5715', TO_DATE('08.07.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (59, 'Liam', 'Koch', 'liam.koch@gmail.com', 'LiamKoch9677', TO_DATE('07.10.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (60, 'Olivia', 'Krüger', 'olivia.krüger@gmail.com', 'OliviaKrüger8678', TO_DATE('01.05.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (61, 'Daniel', 'Meyer', 'daniel.meyer@gmail.com', 'DanielMeyer7051', TO_DATE('11.07.2001', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (62, 'Ethan', 'Bauer', 'ethan.bauer@gmail.com', 'EthanBauer3240', TO_DATE('13.07.1993', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (63, 'Anna', 'Zimmermann', 'anna.zimmermann@gmail.com', 'AnnaZimmermann8169', TO_DATE('21.12.2007', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (64, 'James', 'Braun', 'james.braun@gmail.com', 'JamesBraun2107', TO_DATE('15.07.1999', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (65, 'Henry', 'Weber', 'henry.weber@gmail.com', 'HenryWeber1345', TO_DATE('12.01.1992', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (66, 'Benjamin', 'Klein', 'benjamin.klein@gmail.com', 'BenjaminKlein6747', TO_DATE('20.09.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (67, 'Ethan', 'Becker', 'ethan.becker@gmail.com', 'EthanBecker1758', TO_DATE('16.12.1991', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (68, 'Charlotte', 'Krüger', 'charlotte.krüger@gmail.com', 'CharlotteKrüger2027', TO_DATE('09.12.1995', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (69, 'Benjamin', 'Schmidt', 'benjamin.schmidt@gmail.com', 'BenjaminSchmidt3227', TO_DATE('02.06.1995', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (70, 'Emma', 'Schwarz', 'emma.schwarz@gmail.com', 'EmmaSchwarz9197', TO_DATE('23.10.1993', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (71, 'Isabella', 'Koch', 'isabella.koch@gmail.com', 'IsabellaKoch7463', TO_DATE('07.09.1994', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (72, 'Grace', 'Klein', 'grace.klein@gmail.com', 'GraceKlein4394', TO_DATE('15.03.1994', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (73, 'Ethan', 'Neumann', 'ethan.neumann@gmail.com', 'EthanNeumann8120', TO_DATE('22.09.1992', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (74, 'Alexander', 'Neumann', 'alexander.neumann@gmail.com', 'AlexanderNeumann5273', TO_DATE('13.02.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (75, 'Ethan', 'Schmidt', 'ethan.schmidt@gmail.com', 'EthanSchmidt5746', TO_DATE('16.11.1997', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (76, 'Charlotte', 'Werner', 'charlotte.werner@gmail.com', 'CharlotteWerner1167', TO_DATE('03.07.1996', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (77, 'Ava', 'Hoffmann', 'ava.hoffmann@gmail.com', 'AvaHoffmann7706', TO_DATE('10.09.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (78, 'Alexander', 'Müller', 'alexander.müller@gmail.com', 'AlexanderMüller5684', TO_DATE('23.02.1990', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (79, 'William', 'Schulz', 'william.schulz@gmail.com', 'WilliamSchulz8005', TO_DATE('23.06.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (80, 'Charlotte', 'Braun', 'charlotte.braun@gmail.com', 'CharlotteBraun8413', TO_DATE('13.09.2001', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (81, 'Noah', 'Weber', 'noah.weber@gmail.com', 'NoahWeber8250', TO_DATE('12.07.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (82, 'Mia', 'Hoffmann', 'mia.hoffmann@gmail.com', 'MiaHoffmann8081', TO_DATE('21.12.1999', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (83, 'Liam', 'Richter', 'liam.richter@gmail.com', 'LiamRichter3939', TO_DATE('28.08.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (84, 'Ava', 'Krüger', 'ava.krüger@gmail.com', 'AvaKrüger4064', TO_DATE('25.10.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (85, 'Sophie', 'Braun', 'sophie.braun@gmail.com', 'SophieBraun8165', TO_DATE('22.02.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (86, 'Sophia', 'Schulz', 'sophia.schulz@gmail.com', 'SophiaSchulz1747', TO_DATE('20.01.2001', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (87, 'Amelia', 'Neumann', 'amelia.neumann@gmail.com', 'AmeliaNeumann2820', TO_DATE('19.10.1999', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (88, 'Emma', 'Bauer', 'emma.bauer@gmail.com', 'EmmaBauer3700', TO_DATE('03.05.1997', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (89, 'Ella', 'Braun', 'ella.braun@gmail.com', 'EllaBraun5365', TO_DATE('30.09.1991', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (90, 'Noah', 'Krüger', 'noah.krüger@gmail.com', 'NoahKrüger8901', TO_DATE('27.11.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (91, 'Aiden', 'Schmidt', 'aiden.schmidt@gmail.com', 'AidenSchmidt7430', TO_DATE('19.06.2007', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (92, 'Olivia', 'Hoffmann', 'olivia.hoffmann@gmail.com', 'OliviaHoffmann6386', TO_DATE('10.02.2002', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (93, 'Aiden', 'Müller', 'aiden.müller@gmail.com', 'AidenMüller6810', TO_DATE('11.12.1996', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (94, 'Amelia', 'Hofmann', 'amelia.hofmann@gmail.com', 'AmeliaHofmann6985', TO_DATE('10.03.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (95, 'Henry', 'Zimmermann', 'henry.zimmermann@gmail.com', 'HenryZimmermann6493', TO_DATE('01.05.1999', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (96, 'Anna', 'Schäfer', 'anna.schäfer@gmail.com', 'AnnaSchäfer2418', TO_DATE('06.02.2005', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (97, 'Amelia', 'Hofmann', 'amelia.hofmann@gmail.com', 'AmeliaHofmann7188', TO_DATE('31.10.1992', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (98, 'Olivia', 'Schwarz', 'olivia.schwarz@gmail.com', 'OliviaSchwarz1004', TO_DATE('21.04.1993', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (99, 'Grace', 'Schulz', 'grace.schulz@gmail.com', 'GraceSchulz1886', TO_DATE('08.09.2001', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (100, 'Ella', 'Schäfer', 'ella.schäfer@gmail.com', 'EllaSchäfer1000', TO_DATE('01.05.1997', 'DD.MM.YYYY'));

INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (101, 'Fernando', 'Natália', 'fernando.natália@gmail.com', 'FernandoNatália9002', TO_DATE('25.05.1996', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (102, 'Fernando', 'João', 'fernando.joão@gmail.com', 'FernandoJoão8963', TO_DATE('24.03.2007', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (103, 'Gustavo', 'Caroline', 'gustavo.caroline@gmail.com', 'GustavoCaroline6054', TO_DATE('01.05.1995', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (104, 'Natália', 'Pedro', 'natália.pedro@gmail.com', 'NatáliaPedro8801', TO_DATE('08.12.1992', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (105, 'Maria', 'Lívia', 'maria.lívia@gmail.com', 'MariaLívia8724', TO_DATE('25.08.1994', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (106, 'Gustavo', 'Guilherme', 'gustavo.guilherme@gmail.com', 'GustavoGuilherme8476', TO_DATE('20.06.2001', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (107, 'João', 'Gustavo', 'joão.gustavo@gmail.com', 'JoãoGustavo8212', TO_DATE('25.03.1992', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (108, 'Maria', 'Ana', 'maria.ana@gmail.com', 'MariaAna2293', TO_DATE('08.06.2002', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (109, 'Diego', 'Bruna', 'diego.bruna@gmail.com', 'DiegoBruna3380', TO_DATE('19.02.2006', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (110, 'Thiago', 'Carla', 'thiago.carla@gmail.com', 'ThiagoCarla5046', TO_DATE('19.09.2005', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (111, 'Amanda', 'Maria', 'amanda.maria@gmail.com', 'AmandaMaria8543', TO_DATE('01.04.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (112, 'Gustavo', 'Amanda', 'gustavo.amanda@gmail.com', 'GustavoAmanda2962', TO_DATE('17.07.2001', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (113, 'Amanda', 'Amanda', 'amanda.amanda@gmail.com', 'AmandaAmanda9469', TO_DATE('04.02.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (114, 'Camila', 'Guilherme', 'camila.guilherme@gmail.com', 'CamilaGuilherme6264', TO_DATE('30.07.2006', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (115, 'Fernando', 'Bruna', 'fernando.bruna@gmail.com', 'FernandoBruna4919', TO_DATE('12.09.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (116, 'João', 'Pedro', 'joão.pedro@gmail.com', 'JoãoPedro9712', TO_DATE('27.03.2001', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (117, 'Fernando', 'Bruna', 'fernando.bruna@gmail.com', 'FernandoBruna3174', TO_DATE('25.10.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (118, 'Carla', 'Lucas', 'carla.lucas@gmail.com', 'CarlaLucas8748', TO_DATE('03.01.2006', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (119, 'João', 'Ana', 'joão.ana@gmail.com', 'JoãoAna2216', TO_DATE('22.03.2001', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (120, 'Bruna', 'Larissa', 'bruna.larissa@gmail.com', 'BrunaLarissa1266', TO_DATE('01.03.1997', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (121, 'Camila', 'Juliana', 'camila.juliana@gmail.com', 'CamilaJuliana7953', TO_DATE('24.11.1990', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (122, 'Thiago', 'Larissa', 'thiago.larissa@gmail.com', 'ThiagoLarissa1723', TO_DATE('23.12.1991', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (123, 'Caroline', 'Thiago', 'caroline.thiago@gmail.com', 'CarolineThiago5248', TO_DATE('24.04.1993', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (124, 'Gustavo', 'Amanda', 'gustavo.amanda@gmail.com', 'GustavoAmanda5416', TO_DATE('18.10.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (125, 'Carla', 'Gustavo', 'carla.gustavo@gmail.com', 'CarlaGustavo6841', TO_DATE('04.05.1990', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (126, 'Mariana', 'Amanda', 'mariana.amanda@gmail.com', 'MarianaAmanda1940', TO_DATE('26.04.2002', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (127, 'Guilherme', 'Thiago', 'guilherme.thiago@gmail.com', 'GuilhermeThiago7485', TO_DATE('17.01.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (128, 'Larissa', 'Fernando', 'larissa.fernando@gmail.com', 'LarissaFernando6819', TO_DATE('25.11.1994', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (129, 'Amanda', 'Caroline', 'amanda.caroline@gmail.com', 'AmandaCaroline7235', TO_DATE('07.08.2006', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (130, 'Lívia', 'Gustavo', 'lívia.gustavo@gmail.com', 'LíviaGustavo5736', TO_DATE('23.09.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (131, 'Rodrigo', 'Diego', 'rodrigo.diego@gmail.com', 'RodrigoDiego4585', TO_DATE('24.07.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (132, 'Juliana', 'Rafael', 'juliana.rafael@gmail.com', 'JulianaRafael1830', TO_DATE('28.04.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (133, 'Eduardo', 'Juliana', 'eduardo.juliana@gmail.com', 'EduardoJuliana7442', TO_DATE('22.02.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (134, 'Guilherme', 'Larissa', 'guilherme.larissa@gmail.com', 'GuilhermeLarissa7639', TO_DATE('28.09.1990', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (135, 'João', 'Lucas', 'joão.lucas@gmail.com', 'JoãoLucas4566', TO_DATE('07.12.2006', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (136, 'Caroline', 'Carla', 'caroline.carla@gmail.com', 'CarolineCarla9306', TO_DATE('27.05.2006', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (137, 'Lucas', 'Diego', 'lucas.diego@gmail.com', 'LucasDiego8230', TO_DATE('31.08.2006', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (138, 'Larissa', 'Bruna', 'larissa.bruna@gmail.com', 'LarissaBruna6608', TO_DATE('08.06.1994', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (139, 'Isabela', 'Camila', 'isabela.camila@gmail.com', 'IsabelaCamila3639', TO_DATE('10.12.2002', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (140, 'Thiago', 'João', 'thiago.joão@gmail.com', 'ThiagoJoão6556', TO_DATE('26.06.1993', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (141, 'Ana', 'Gustavo', 'ana.gustavo@gmail.com', 'AnaGustavo6238', TO_DATE('14.03.1999', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (142, 'Eduardo', 'Eduardo', 'eduardo.eduardo@gmail.com', 'EduardoEduardo1346', TO_DATE('14.12.1994', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (143, 'Larissa', 'Camila', 'larissa.camila@gmail.com', 'LarissaCamila1768', TO_DATE('29.01.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (144, 'Eduardo', 'Eduardo', 'eduardo.eduardo@gmail.com', 'EduardoEduardo4761', TO_DATE('02.08.1994', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (145, 'Natália', 'Amanda', 'natália.amanda@gmail.com', 'NatáliaAmanda4892', TO_DATE('20.03.1996', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (146, 'Juliana', 'Diego', 'juliana.diego@gmail.com', 'JulianaDiego9464', TO_DATE('09.02.2002', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (147, 'Rafael', 'Carla', 'rafael.carla@gmail.com', 'RafaelCarla9334', TO_DATE('12.05.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (148, 'João', 'Natália', 'joão.natália@gmail.com', 'JoãoNatália6149', TO_DATE('11.11.1992', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (149, 'Ana', 'Lívia', 'ana.lívia@gmail.com', 'AnaLívia4553', TO_DATE('13.04.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (150, 'Rodrigo', 'Bruna', 'rodrigo.bruna@gmail.com', 'RodrigoBruna1062', TO_DATE('04.02.2001', 'DD.MM.YYYY'));

INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (151, 'Mustafa', 'Doğan', 'mustafa.doğan@gmail.com', 'MustafaDoğan5770', TO_DATE('09.10.1993', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (152, 'Hasan', 'Bulut', 'hasan.bulut@gmail.com', 'HasanBulut7257', TO_DATE('07.07.1999', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (153, 'Erdogan', 'Korkmaz', 'erdogan.korkmaz@gmail.com', 'ErdoganKorkmaz7781', TO_DATE('01.07.1997', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (154, 'Ferhat', 'Çelik', 'ferhat.çelik@gmail.com', 'FerhatÇelik1386', TO_DATE('05.02.2006', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (155, 'Hüseyin', 'Yıldız', 'hüseyin.yıldız@gmail.com', 'HüseyinYıldız3880', TO_DATE('16.04.2001', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (156, 'Hasan', 'Taş', 'hasan.taş@gmail.com', 'HasanTaş7695', TO_DATE('01.02.1993', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (157, 'Ayşe', 'Taş', 'ayşe.taş@gmail.com', 'AyşeTaş6754', TO_DATE('14.06.1991', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (158, 'Meryem', 'Doğan', 'meryem.doğan@gmail.com', 'MeryemDoğan2974', TO_DATE('03.04.1999', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (159, 'Kadir', 'Güneş', 'kadir.güneş@gmail.com', 'KadirGüneş8831', TO_DATE('03.04.1994', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (160, 'Zeynep', 'Akbaba', 'zeynep.akbaba@gmail.com', 'ZeynepAkbaba5418', TO_DATE('20.05.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (161, 'Ferhat', 'Güneş', 'ferhat.güneş@gmail.com', 'FerhatGüneş8714', TO_DATE('18.05.1994', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (162, 'Mustafa', 'Yıldız', 'mustafa.yıldız@gmail.com', 'MustafaYıldız7442', TO_DATE('18.03.1990', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (163, 'Erdogan', 'Akbaba', 'erdogan.akbaba@gmail.com', 'ErdoganAkbaba3645', TO_DATE('26.07.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (164, 'Ahmet', 'Akbaba', 'ahmet.akbaba@gmail.com', 'AhmetAkbaba9803', TO_DATE('13.12.2005', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (165, 'Gülay', 'Çelik', 'gülay.çelik@gmail.com', 'GülayÇelik9618', TO_DATE('07.08.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (166, 'Emine', 'Çetin', 'emine.çetin@gmail.com', 'EmineÇetin6159', TO_DATE('03.07.1993', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (167, 'Ferhat', 'Yılmaz', 'ferhat.yılmaz@gmail.com', 'FerhatYılmaz6578', TO_DATE('16.09.2007', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (168, 'Kadir', 'Kurt', 'kadir.kurt@gmail.com', 'KadirKurt2105', TO_DATE('19.03.1995', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (169, 'Sibel', 'Yıldız', 'sibel.yıldız@gmail.com', 'SibelYıldız2616', TO_DATE('26.07.1993', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (170, 'Hatice', 'Yıldız', 'hatice.yıldız@gmail.com', 'HaticeYıldız5176', TO_DATE('15.11.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (171, 'Fatma', 'Yılmaz', 'fatma.yılmaz@gmail.com', 'FatmaYılmaz9534', TO_DATE('15.07.1994', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (172, 'Hatice', 'Çelik', 'hatice.çelik@gmail.com', 'HaticeÇelik2773', TO_DATE('17.10.1999', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (173, 'Mustafa', 'Demir', 'mustafa.demir@gmail.com', 'MustafaDemir8792', TO_DATE('17.05.2002', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (174, 'Hüseyin', 'Kara', 'hüseyin.kara@gmail.com', 'HüseyinKara1621', TO_DATE('24.03.2001', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (175, 'Hüseyin', 'Doğan', 'hüseyin.doğan@gmail.com', 'HüseyinDoğan1090', TO_DATE('22.01.2006', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (176, 'Emine', 'Akbaba', 'emine.akbaba@gmail.com', 'EmineAkbaba2743', TO_DATE('26.06.1994', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (177, 'Fatma', 'Kurt', 'fatma.kurt@gmail.com', 'FatmaKurt1974', TO_DATE('01.09.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (178, 'Emine', 'Korkmaz', 'emine.korkmaz@gmail.com', 'EmineKorkmaz7652', TO_DATE('22.06.1996', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (179, 'Mehmet', 'Uçar', 'mehmet.uçar@gmail.com', 'MehmetUçar1700', TO_DATE('02.04.1991', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (180, 'Ferhat', 'Taş', 'ferhat.taş@gmail.com', 'FerhatTaş3816', TO_DATE('31.07.2001', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (181, 'Aslı', 'Demir', 'aslı.demir@gmail.com', 'AslıDemir7058', TO_DATE('31.05.2006', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (182, 'Gülay', 'Kara', 'gülay.kara@gmail.com', 'GülayKara1935', TO_DATE('30.01.1991', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (183, 'Yusuf', 'Doğan', 'yusuf.doğan@gmail.com', 'YusufDoğan3936', TO_DATE('07.10.1990', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (184, 'Gülay', 'Güneş', 'gülay.güneş@gmail.com', 'GülayGüneş1233', TO_DATE('15.02.1992', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (185, 'Mehmet', 'Aslan', 'mehmet.aslan@gmail.com', 'MehmetAslan7996', TO_DATE('17.08.1991', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (186, 'Ferhat', 'Çetin', 'ferhat.çetin@gmail.com', 'FerhatÇetin7355', TO_DATE('20.08.2006', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (187, 'Hüseyin', 'Aydın', 'hüseyin.aydın@gmail.com', 'HüseyinAydın5023', TO_DATE('12.03.1991', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (188, 'Erdogan', 'Koç', 'erdogan.koç@gmail.com', 'ErdoganKoç5229', TO_DATE('11.05.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (189, 'Emine', 'Çetin', 'emine.çetin@gmail.com', 'EmineÇetin7895', TO_DATE('21.06.1991', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (190, 'Ayten', 'Çelik', 'ayten.çelik@gmail.com', 'AytenÇelik6204', TO_DATE('13.11.1995', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (191, 'Gülay', 'Aksoy', 'gülay.aksoy@gmail.com', 'GülayAksoy3313', TO_DATE('01.03.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (192, 'Hüseyin', 'Kaplan', 'hüseyin.kaplan@gmail.com', 'HüseyinKaplan5709', TO_DATE('11.02.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (193, 'Gülay', 'Kaplan', 'gülay.kaplan@gmail.com', 'GülayKaplan6220', TO_DATE('17.03.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (194, 'Yusuf', 'Özdemir', 'yusuf.özdemir@gmail.com', 'YusufÖzdemir9392', TO_DATE('16.02.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (195, 'Aslı', 'Taş', 'aslı.taş@gmail.com', 'AslıTaş6649', TO_DATE('16.10.1990', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (196, 'Emine', 'Güneş', 'emine.güneş@gmail.com', 'EmineGüneş1419', TO_DATE('01.02.2002', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (197, 'Yusuf', 'Öztürk', 'yusuf.öztürk@gmail.com', 'YusufÖztürk2482', TO_DATE('01.05.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (198, 'Ferhat', 'Demir', 'ferhat.demir@gmail.com', 'FerhatDemir4104', TO_DATE('24.06.1996', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (199, 'Meryem', 'Erdoğan', 'meryem.erdoğan@gmail.com', 'MeryemErdoğan2238', TO_DATE('24.05.2002', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (200, 'Erdogan', 'Uçar', 'erdogan.uçar@gmail.com', 'ErdoganUçar3694', TO_DATE('18.03.2004', 'DD.MM.YYYY'));

INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (201, 'Yelena', 'Popov', 'yelena.popov@gmail.com', 'YelenaPopov4992', TO_DATE('20.07.1995', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (202, 'Natalia', 'Morozov', 'natalia.morozov@gmail.com', 'NataliaMorozov9413', TO_DATE('15.11.1999', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (203, 'Elena', 'Fedotov', 'elena.fedotov@gmail.com', 'ElenaFedotov6921', TO_DATE('08.10.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (204, 'Svetlana', 'Ivanov', 'svetlana.ivanov@gmail.com', 'SvetlanaIvanov8660', TO_DATE('08.01.2002', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (205, 'Anton', 'Vorobev', 'anton.vorobev@gmail.com', 'AntonVorobev6349', TO_DATE('20.02.2006', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (206, 'Konstantin', 'Bogdanov', 'konstantin.bogdanov@gmail.com', 'KonstantinBogdanov4148', TO_DATE('16.04.1992', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (207, 'Anastasia', 'Mikhailov', 'anastasia.mikhailov@gmail.com', 'AnastasiaMikhailov1810', TO_DATE('24.08.1995', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (208, 'Vladimir', 'Smirnov', 'vladimir.smirnov@gmail.com', 'VladimirSmirnov8448', TO_DATE('25.01.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (209, 'Olga', 'Belyakov', 'olga.belyakov@gmail.com', 'OlgaBelyakov9201', TO_DATE('04.01.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (210, 'Andrei', 'Belov', 'andrei.belov@gmail.com', 'AndreiBelov7188', TO_DATE('03.03.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (211, 'Alexei', 'Semyonov', 'alexei.semyonov@gmail.com', 'AlexeiSemyonov6807', TO_DATE('08.04.2006', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (212, 'Maria', 'Semyonov', 'maria.semyonov@gmail.com', 'MariaSemyonov1999', TO_DATE('17.09.1990', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (213, 'Irina', 'Sokolov', 'irina.sokolov@gmail.com', 'IrinaSokolov5709', TO_DATE('26.04.2002', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (214, 'Natalia', 'Vinogradov', 'natalia.vinogradov@gmail.com', 'NataliaVinogradov3682', TO_DATE('06.02.1993', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (215, 'Pavel', 'Volkov', 'pavel.volkov@gmail.com', 'PavelVolkov6262', TO_DATE('19.08.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (216, 'Natalia', 'Novikov', 'natalia.novikov@gmail.com', 'NataliaNovikov9720', TO_DATE('27.11.2007', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (217, 'Tatiana', 'Belov', 'tatiana.belov@gmail.com', 'TatianaBelov5920', TO_DATE('22.05.1992', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (218, 'Dmitry', 'Pavlov', 'dmitry.pavlov@gmail.com', 'DmitryPavlov7178', TO_DATE('31.03.2006', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (219, 'Nikolai', 'Pavlov', 'nikolai.pavlov@gmail.com', 'NikolaiPavlov2490', TO_DATE('31.08.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (220, 'Konstantin', 'Lebedev', 'konstantin.lebedev@gmail.com', 'KonstantinLebedev8559', TO_DATE('17.01.1995', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (221, 'Ekaterina', 'Vorobev', 'ekaterina.vorobev@gmail.com', 'EkaterinaVorobev5577', TO_DATE('22.08.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (222, 'Olga', 'Novikov', 'olga.novikov@gmail.com', 'OlgaNovikov8183', TO_DATE('14.02.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (223, 'Ekaterina', 'Ivanov', 'ekaterina.ivanov@gmail.com', 'EkaterinaIvanov3083', TO_DATE('14.02.2002', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (224, 'Natalia', 'Belov', 'natalia.belov@gmail.com', 'NataliaBelov6616', TO_DATE('27.10.1996', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (225, 'Maria', 'Kozlov', 'maria.kozlov@gmail.com', 'MariaKozlov5614', TO_DATE('13.07.2006', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (226, 'Dmitry', 'Semyonov', 'dmitry.semyonov@gmail.com', 'DmitrySemyonov1113', TO_DATE('09.12.2001', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (227, 'Andrei', 'Novikov', 'andrei.novikov@gmail.com', 'AndreiNovikov3993', TO_DATE('08.08.2005', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (228, 'Nikolai', 'Sokolov', 'nikolai.sokolov@gmail.com', 'NikolaiSokolov6557', TO_DATE('08.04.1990', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (229, 'Yuri', 'Ivanov', 'yuri.ivanov@gmail.com', 'YuriIvanov4758', TO_DATE('12.03.1990', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (230, 'Tatiana', 'Tarasov', 'tatiana.tarasov@gmail.com', 'TatianaTarasov3806', TO_DATE('27.09.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (231, 'Maria', 'Volkov', 'maria.volkov@gmail.com', 'MariaVolkov7660', TO_DATE('05.09.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (232, 'Marina', 'Fedotov', 'marina.fedotov@gmail.com', 'MarinaFedotov5138', TO_DATE('18.08.1991', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (233, 'Konstantin', 'Popov', 'konstantin.popov@gmail.com', 'KonstantinPopov3499', TO_DATE('30.11.1994', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (234, 'Svetlana', 'Morozov', 'svetlana.morozov@gmail.com', 'SvetlanaMorozov8737', TO_DATE('18.08.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (235, 'Natalia', 'Kuznetsov', 'natalia.kuznetsov@gmail.com', 'NataliaKuznetsov2188', TO_DATE('31.10.1991', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (236, 'Sergei', 'Fedotov', 'sergei.fedotov@gmail.com', 'SergeiFedotov8741', TO_DATE('20.11.1993', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (237, 'Vladimir', 'Bogdanov', 'vladimir.bogdanov@gmail.com', 'VladimirBogdanov5191', TO_DATE('17.02.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (238, 'Irina', 'Semyonov', 'irina.semyonov@gmail.com', 'IrinaSemyonov2724', TO_DATE('25.10.1997', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (239, 'Natalia', 'Belov', 'natalia.belov@gmail.com', 'NataliaBelov4323', TO_DATE('29.06.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (240, 'Ekaterina', 'Belyakov', 'ekaterina.belyakov@gmail.com', 'EkaterinaBelyakov2900', TO_DATE('31.05.1992', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (241, 'Svetlana', 'Kozlov', 'svetlana.kozlov@gmail.com', 'SvetlanaKozlov3379', TO_DATE('26.06.1995', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (242, 'Natalia', 'Morozov', 'natalia.morozov@gmail.com', 'NataliaMorozov5053', TO_DATE('21.05.2002', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (243, 'Konstantin', 'Vasiliev', 'konstantin.vasiliev@gmail.com', 'KonstantinVasiliev6827', TO_DATE('30.11.1996', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (244, 'Nikolai', 'Vinogradov', 'nikolai.vinogradov@gmail.com', 'NikolaiVinogradov7218', TO_DATE('15.04.1994', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (245, 'Tatiana', 'Kozlov', 'tatiana.kozlov@gmail.com', 'TatianaKozlov5731', TO_DATE('07.11.2005', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (246, 'Vladimir', 'Vasiliev', 'vladimir.vasiliev@gmail.com', 'VladimirVasiliev4359', TO_DATE('23.06.1997', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (247, 'Ivan', 'Morozov', 'ivan.morozov@gmail.com', 'IvanMorozov1885', TO_DATE('22.12.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (248, 'Ivan', 'Belyakov', 'ivan.belyakov@gmail.com', 'IvanBelyakov1166', TO_DATE('09.11.1996', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (249, 'Yuri', 'Vinogradov', 'yuri.vinogradov@gmail.com', 'YuriVinogradov2025', TO_DATE('20.03.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (250, 'Nikolai', 'Bogdanov', 'nikolai.bogdanov@gmail.com', 'NikolaiBogdanov6669', TO_DATE('30.09.1997', 'DD.MM.YYYY'));

INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (251, 'Li Wei', 'Huang', 'li wei.huang@gmail.com', 'Li WeiHuang3265', TO_DATE('30.10.2002', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (252, 'Xie Hong', 'Gao', 'xie hong.gao@gmail.com', 'Xie HongGao5526', TO_DATE('21.06.1990', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (253, 'Sun Wei', 'Yu', 'sun wei.yu@gmail.com', 'Sun WeiYu7725', TO_DATE('18.01.1994', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (254, 'Tang Hong', 'Jiang', 'tang hong.jiang@gmail.com', 'Tang HongJiang6815', TO_DATE('30.07.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (255, 'Chen Jie', 'Yuan', 'chen jie.yuan@gmail.com', 'Chen JieYuan9136', TO_DATE('01.11.1994', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (256, 'Chen Jie', 'Yuan', 'chen jie.yuan@gmail.com', 'Chen JieYuan5953', TO_DATE('02.10.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (257, 'He Yuan', 'Cao', 'he yuan.cao@gmail.com', 'He YuanCao7657', TO_DATE('31.01.1990', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (258, 'Lin Mei', 'Chen', 'lin mei.chen@gmail.com', 'Lin MeiChen5545', TO_DATE('16.01.1992', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (259, 'Xie Hong', 'Ma', 'xie hong.ma@gmail.com', 'Xie HongMa9186', TO_DATE('23.11.1995', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (260, 'Hu Ling', 'Peng', 'hu ling.peng@gmail.com', 'Hu LingPeng6717', TO_DATE('15.02.1997', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (261, 'Tang Hong', 'Zhao', 'tang hong.zhao@gmail.com', 'Tang HongZhao3062', TO_DATE('28.06.2002', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (262, 'Yang Ming', 'Zhou', 'yang ming.zhou@gmail.com', 'Yang MingZhou2633', TO_DATE('29.04.1997', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (263, 'Yu Xia', 'Xie', 'yu xia.xie@gmail.com', 'Yu XiaXie8759', TO_DATE('15.02.2002', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (264, 'Wang Lei', 'Cao', 'wang lei.cao@gmail.com', 'Wang LeiCao7680', TO_DATE('23.09.1995', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (265, 'Xu Chen', 'Gao', 'xu chen.gao@gmail.com', 'Xu ChenGao7395', TO_DATE('11.07.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (266, 'Li Wei', 'Xu', 'li wei.xu@gmail.com', 'Li WeiXu4369', TO_DATE('25.04.1993', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (267, 'Xie Hong', 'Guo', 'xie hong.guo@gmail.com', 'Xie HongGuo8644', TO_DATE('29.11.1993', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (268, 'Zhou Xin', 'Gao', 'zhou xin.gao@gmail.com', 'Zhou XinGao8699', TO_DATE('21.07.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (269, 'Ma Jing', 'Guo', 'ma jing.guo@gmail.com', 'Ma JingGuo3049', TO_DATE('21.08.1990', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (270, 'Yuan Feng', 'Lin', 'yuan feng.lin@gmail.com', 'Yuan FengLin7789', TO_DATE('28.05.2007', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (271, 'Sun Wei', 'Hu', 'sun wei.hu@gmail.com', 'Sun WeiHu9373', TO_DATE('15.03.1999', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (272, 'Liu Xin', 'Liu', 'liu xin.liu@gmail.com', 'Liu XinLiu7465', TO_DATE('23.12.1993', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (273, 'Wang Lei', 'Yuan', 'wang lei.yuan@gmail.com', 'Wang LeiYuan8918', TO_DATE('04.03.2007', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (274, 'He Yuan', 'Xie', 'he yuan.xie@gmail.com', 'He YuanXie7850', TO_DATE('21.11.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (275, 'Jiang Wei', 'He', 'jiang wei.he@gmail.com', 'Jiang WeiHe8346', TO_DATE('28.01.1991', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (276, 'He Yuan', 'Xie', 'he yuan.xie@gmail.com', 'He YuanXie7940', TO_DATE('01.03.1990', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (277, 'Zhou Xin', 'Peng', 'zhou xin.peng@gmail.com', 'Zhou XinPeng5843', TO_DATE('09.08.1996', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (278, 'Sun Wei', 'Huang', 'sun wei.huang@gmail.com', 'Sun WeiHuang5995', TO_DATE('19.05.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (279, 'Zhou Xin', 'Li', 'zhou xin.li@gmail.com', 'Zhou XinLi2948', TO_DATE('29.08.2001', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (280, 'Yu Xia', 'Zhou', 'yu xia.zhou@gmail.com', 'Yu XiaZhou1060', TO_DATE('05.02.2001', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (281, 'Sun Wei', 'Gao', 'sun wei.gao@gmail.com', 'Sun WeiGao9847', TO_DATE('18.09.1994', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (282, 'Huang Ying', 'Tang', 'huang ying.tang@gmail.com', 'Huang YingTang4984', TO_DATE('05.06.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (283, 'Ma Jing', 'Zhao', 'ma jing.zhao@gmail.com', 'Ma JingZhao5801', TO_DATE('25.11.2002', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (284, 'He Yuan', 'He', 'he yuan.he@gmail.com', 'He YuanHe2094', TO_DATE('20.11.2001', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (285, 'Chen Jie', 'Lin', 'chen jie.lin@gmail.com', 'Chen JieLin7085', TO_DATE('06.08.1995', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (286, 'Cao Yan', 'Xie', 'cao yan.xie@gmail.com', 'Cao YanXie1402', TO_DATE('09.09.1995', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (287, 'Sun Wei', 'Xu', 'sun wei.xu@gmail.com', 'Sun WeiXu1977', TO_DATE('17.05.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (288, 'Sun Wei', 'Yu', 'sun wei.yu@gmail.com', 'Sun WeiYu8401', TO_DATE('21.03.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (289, 'Wang Lei', 'Liu', 'wang lei.liu@gmail.com', 'Wang LeiLiu5656', TO_DATE('05.07.1991', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (290, 'He Yuan', 'Hu', 'he yuan.hu@gmail.com', 'He YuanHu6777', TO_DATE('28.05.1999', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (291, 'Zhao Li', 'Li', 'zhao li.li@gmail.com', 'Zhao LiLi6244', TO_DATE('18.12.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (292, 'Hu Ling', 'Xie', 'hu ling.xie@gmail.com', 'Hu LingXie1069', TO_DATE('06.12.1991', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (293, 'Zhang Yifan', 'Liu', 'zhang yifan.liu@gmail.com', 'Zhang YifanLiu3546', TO_DATE('04.09.2006', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (294, 'Chen Jie', 'Liu', 'chen jie.liu@gmail.com', 'Chen JieLiu9365', TO_DATE('07.04.2002', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (295, 'Gao Yu', 'Liu', 'gao yu.liu@gmail.com', 'Gao YuLiu4418', TO_DATE('12.10.2002', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (296, 'Zhou Xin', 'Zhou', 'zhou xin.zhou@gmail.com', 'Zhou XinZhou4996', TO_DATE('27.08.1990', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (297, 'Chen Jie', 'Zhang', 'chen jie.zhang@gmail.com', 'Chen JieZhang3275', TO_DATE('29.12.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (298, 'Gao Yu', 'He', 'gao yu.he@gmail.com', 'Gao YuHe1880', TO_DATE('04.01.1997', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (299, 'Zhao Li', 'Ma', 'zhao li.ma@gmail.com', 'Zhao LiMa1946', TO_DATE('24.04.1996', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (300, 'Yang Ming', 'Cao', 'yang ming.cao@gmail.com', 'Yang MingCao2942', TO_DATE('26.05.2006', 'DD.MM.YYYY'));

INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (301, 'Hoon-joo', 'Im', 'hoon-joo.im@gmail.com', 'Hoon-jooIm4719', TO_DATE('15.01.1991', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (302, 'Ji-hyun', 'Jeong', 'ji-hyun.jeong@gmail.com', 'Ji-hyunJeong6468', TO_DATE('26.08.1997', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (303, 'Hyun-woo', 'Kim', 'hyun-woo.kim@gmail.com', 'Hyun-wooKim2477', TO_DATE('26.06.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (304, 'Eun-ji', 'Lee', 'eun-ji.lee@gmail.com', 'Eun-jiLee3778', TO_DATE('10.08.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (305, 'Sung-hoon', 'Jeong', 'sung-hoon.jeong@gmail.com', 'Sung-hoonJeong3669', TO_DATE('19.07.1999', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (306, 'Ji-seok', 'Jang', 'ji-seok.jang@gmail.com', 'Ji-seokJang7566', TO_DATE('19.09.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (307, 'Min-seok', 'Hong', 'min-seok.hong@gmail.com', 'Min-seokHong2501', TO_DATE('04.03.1993', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (308, 'Seo-yeon', 'Chung', 'seo-yeon.chung@gmail.com', 'Seo-yeonChung6305', TO_DATE('18.12.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (309, 'Ji-hye', 'Im', 'ji-hye.im@gmail.com', 'Ji-hyeIm4130', TO_DATE('11.05.2006', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (310, 'Hye-jin', 'Oh', 'hye-jin.oh@gmail.com', 'Hye-jinOh6635', TO_DATE('07.08.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (311, 'Ji-yeon', 'Shin', 'ji-yeon.shin@gmail.com', 'Ji-yeonShin4179', TO_DATE('18.05.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (312, 'Ji-hye', 'Im', 'ji-hye.im@gmail.com', 'Ji-hyeIm1353', TO_DATE('28.11.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (313, 'Mi-kyung', 'Ko', 'mi-kyung.ko@gmail.com', 'Mi-kyungKo6074', TO_DATE('20.09.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (314, 'Jae-hyun', 'Kim', 'jae-hyun.kim@gmail.com', 'Jae-hyunKim3876', TO_DATE('13.02.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (315, 'Seo-yeon', 'Yang', 'seo-yeon.yang@gmail.com', 'Seo-yeonYang2787', TO_DATE('26.05.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (316, 'Hae-won', 'Son', 'hae-won.son@gmail.com', 'Hae-wonSon4208', TO_DATE('27.01.2001', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (317, 'Min-seok', 'Yoon', 'min-seok.yoon@gmail.com', 'Min-seokYoon9470', TO_DATE('04.11.1997', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (318, 'Hae-jin', 'Ko', 'hae-jin.ko@gmail.com', 'Hae-jinKo6864', TO_DATE('30.01.2007', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (319, 'Hae-jin', 'Kim', 'hae-jin.kim@gmail.com', 'Hae-jinKim4092', TO_DATE('02.02.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (320, 'Seo-yeon', 'Baek', 'seo-yeon.baek@gmail.com', 'Seo-yeonBaek5420', TO_DATE('01.12.1996', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (321, 'Ji-eun', 'Choi', 'ji-eun.choi@gmail.com', 'Ji-eunChoi5135', TO_DATE('16.06.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (322, 'Seung-ho', 'Son', 'seung-ho.son@gmail.com', 'Seung-hoSon3988', TO_DATE('17.06.2007', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (323, 'Hye-jin', 'Im', 'hye-jin.im@gmail.com', 'Hye-jinIm6912', TO_DATE('21.03.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (324, 'Min-ji', 'Kim', 'min-ji.kim@gmail.com', 'Min-jiKim7340', TO_DATE('09.03.1995', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (325, 'Min-seok', 'Kim', 'min-seok.kim@gmail.com', 'Min-seokKim5328', TO_DATE('26.10.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (326, 'Seok-jin', 'Yang', 'seok-jin.yang@gmail.com', 'Seok-jinYang9958', TO_DATE('14.08.1997', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (327, 'Ji-seok', 'Baek', 'ji-seok.baek@gmail.com', 'Ji-seokBaek2401', TO_DATE('04.12.1994', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (328, 'Seo-yeon', 'Hong', 'seo-yeon.hong@gmail.com', 'Seo-yeonHong1563', TO_DATE('06.07.1994', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (329, 'Seok-jin', 'Yoo', 'seok-jin.yoo@gmail.com', 'Seok-jinYoo7130', TO_DATE('15.09.1993', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (330, 'Tae-yeon', 'Kim', 'tae-yeon.kim@gmail.com', 'Tae-yeonKim3517', TO_DATE('29.01.1992', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (331, 'Ji-yong', 'Yoon', 'ji-yong.yoon@gmail.com', 'Ji-yongYoon4072', TO_DATE('06.09.2006', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (332, 'Hye-jin', 'Yoon', 'hye-jin.yoon@gmail.com', 'Hye-jinYoon2613', TO_DATE('06.08.2007', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (333, 'Hye-jin', 'Choi', 'hye-jin.choi@gmail.com', 'Hye-jinChoi2430', TO_DATE('05.07.1992', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (334, 'Yoo-jin', 'Baek', 'yoo-jin.baek@gmail.com', 'Yoo-jinBaek6788', TO_DATE('01.11.2007', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (335, 'Ji-seok', 'Seo', 'ji-seok.seo@gmail.com', 'Ji-seokSeo5382', TO_DATE('19.08.1994', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (336, 'Hae-jin', 'Cho', 'hae-jin.cho@gmail.com', 'Hae-jinCho9062', TO_DATE('10.07.1993', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (337, 'Seo-yeon', 'Kim', 'seo-yeon.kim@gmail.com', 'Seo-yeonKim6268', TO_DATE('23.08.1999', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (338, 'Tae-yeon', 'Hong', 'tae-yeon.hong@gmail.com', 'Tae-yeonHong5917', TO_DATE('16.03.2001', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (339, 'Ji-yong', 'Jeong', 'ji-yong.jeong@gmail.com', 'Ji-yongJeong7743', TO_DATE('09.01.1990', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (340, 'Hyun-woo', 'Shin', 'hyun-woo.shin@gmail.com', 'Hyun-wooShin5668', TO_DATE('22.03.1990', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (341, 'Hye-jin', 'Kwon', 'hye-jin.kwon@gmail.com', 'Hye-jinKwon8038', TO_DATE('13.03.1995', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (342, 'Min-ji', 'Yoon', 'min-ji.yoon@gmail.com', 'Min-jiYoon2880', TO_DATE('10.01.2001', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (343, 'Ji-seok', 'Oh', 'ji-seok.oh@gmail.com', 'Ji-seokOh7584', TO_DATE('27.12.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (344, 'Hae-won', 'Choi', 'hae-won.choi@gmail.com', 'Hae-wonChoi2892', TO_DATE('13.03.1990', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (345, 'Ji-yong', 'Cho', 'ji-yong.cho@gmail.com', 'Ji-yongCho9105', TO_DATE('16.02.1992', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (346, 'Min-ji', 'Yang', 'min-ji.yang@gmail.com', 'Min-jiYang6477', TO_DATE('09.03.1993', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (347, 'Ji-yeon', 'Yang', 'ji-yeon.yang@gmail.com', 'Ji-yeonYang8950', TO_DATE('15.08.1992', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (348, 'So-jin', 'Cho', 'so-jin.cho@gmail.com', 'So-jinCho3582', TO_DATE('14.06.1992', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (349, 'So-jin', 'Yang', 'so-jin.yang@gmail.com', 'So-jinYang2485', TO_DATE('04.10.2005', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (350, 'Jae-hyun', 'Yoon', 'jae-hyun.yoon@gmail.com', 'Jae-hyunYoon9242', TO_DATE('08.03.2003', 'DD.MM.YYYY'));

INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (351, 'Takumi', 'Suzuki', 'takumi.suzuki@gmail.com', 'TakumiSuzuki2846', TO_DATE('24.07.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (352, 'Haruto', 'Kato', 'haruto.kato@gmail.com', 'HarutoKato3610', TO_DATE('14.04.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (353, 'Takumi', 'Matsumoto', 'takumi.matsumoto@gmail.com', 'TakumiMatsumoto4217', TO_DATE('26.03.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (354, 'Yuma', 'Ito', 'yuma.ito@gmail.com', 'YumaIto8168', TO_DATE('21.08.2007', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (355, 'Nao', 'Endo', 'nao.endo@gmail.com', 'NaoEndo8455', TO_DATE('12.09.2007', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (356, 'Miyu', 'Abe', 'miyu.abe@gmail.com', 'MiyuAbe2725', TO_DATE('06.06.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (357, 'Ren', 'Kato', 'ren.kato@gmail.com', 'RenKato9169', TO_DATE('03.05.1991', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (358, 'Akari', 'Yamamoto', 'akari.yamamoto@gmail.com', 'AkariYamamoto7508', TO_DATE('07.01.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (359, 'Ryota', 'Watanabe', 'ryota.watanabe@gmail.com', 'RyotaWatanabe4837', TO_DATE('13.06.2005', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (360, 'Sora', 'Kobayashi', 'sora.kobayashi@gmail.com', 'SoraKobayashi5997', TO_DATE('10.05.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (361, 'Miyu', 'Kobayashi', 'miyu.kobayashi@gmail.com', 'MiyuKobayashi2721', TO_DATE('06.04.1990', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (362, 'Haruto', 'Takahashi', 'haruto.takahashi@gmail.com', 'HarutoTakahashi9137', TO_DATE('08.02.2005', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (363, 'Aoi', 'Abe', 'aoi.abe@gmail.com', 'AoiAbe8848', TO_DATE('19.03.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (364, 'Kazuki', 'Watanabe', 'kazuki.watanabe@gmail.com', 'KazukiWatanabe6844', TO_DATE('20.05.1995', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (365, 'Ren', 'Yoshida', 'ren.yoshida@gmail.com', 'RenYoshida6409', TO_DATE('09.11.1996', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (366, 'Haruto', 'Kato', 'haruto.kato@gmail.com', 'HarutoKato3145', TO_DATE('29.11.2005', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (367, 'Riko', 'Shimizu', 'riko.shimizu@gmail.com', 'RikoShimizu9483', TO_DATE('03.03.2005', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (368, 'Aoi', 'Nishimura', 'aoi.nishimura@gmail.com', 'AoiNishimura9296', TO_DATE('24.11.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (369, 'Haruto', 'Endo', 'haruto.endo@gmail.com', 'HarutoEndo7828', TO_DATE('11.03.1999', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (370, 'Nao', 'Suzuki', 'nao.suzuki@gmail.com', 'NaoSuzuki2586', TO_DATE('05.06.2001', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (371, 'Akari', 'Watanabe', 'akari.watanabe@gmail.com', 'AkariWatanabe4006', TO_DATE('13.09.1999', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (372, 'Yuki', 'Ito', 'yuki.ito@gmail.com', 'YukiIto3197', TO_DATE('17.07.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (373, 'Riku', 'Sakamoto', 'riku.sakamoto@gmail.com', 'RikuSakamoto8638', TO_DATE('13.01.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (374, 'Hana', 'Watanabe', 'hana.watanabe@gmail.com', 'HanaWatanabe5861', TO_DATE('17.04.1997', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (375, 'Yui', 'Abe', 'yui.abe@gmail.com', 'YuiAbe9606', TO_DATE('10.02.1999', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (376, 'Nao', 'Hayashi', 'nao.hayashi@gmail.com', 'NaoHayashi9655', TO_DATE('17.02.2005', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (377, 'Ryota', 'Kono', 'ryota.kono@gmail.com', 'RyotaKono5453', TO_DATE('16.07.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (378, 'Hinata', 'Shimizu', 'hinata.shimizu@gmail.com', 'HinataShimizu9754', TO_DATE('03.04.1990', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (379, 'Ryota', 'Yamada', 'ryota.yamada@gmail.com', 'RyotaYamada3998', TO_DATE('21.09.1997', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (380, 'Hinata', 'Yoshida', 'hinata.yoshida@gmail.com', 'HinataYoshida4058', TO_DATE('19.04.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (381, 'Yuta', 'Suzuki', 'yuta.suzuki@gmail.com', 'YutaSuzuki4331', TO_DATE('12.01.1998', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (382, 'Kaito', 'Endo', 'kaito.endo@gmail.com', 'KaitoEndo5496', TO_DATE('06.05.1994', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (383, 'Mio', 'Matsumoto', 'mio.matsumoto@gmail.com', 'MioMatsumoto8799', TO_DATE('08.08.1992', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (384, 'Kaito', 'Kato', 'kaito.kato@gmail.com', 'KaitoKato4871', TO_DATE('31.08.1991', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (385, 'Yuma', 'Kono', 'yuma.kono@gmail.com', 'YumaKono5412', TO_DATE('14.04.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (386, 'Hinata', 'Sasaki', 'hinata.sasaki@gmail.com', 'HinataSasaki3672', TO_DATE('01.09.2003', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (387, 'Yuma', 'Hayashi', 'yuma.hayashi@gmail.com', 'YumaHayashi2101', TO_DATE('20.09.1999', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (388, 'Miu', 'Ikeda', 'miu.ikeda@gmail.com', 'MiuIkeda8053', TO_DATE('07.05.1995', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (389, 'Ryota', 'Tanaka', 'ryota.tanaka@gmail.com', 'RyotaTanaka4211', TO_DATE('17.05.1991', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (390, 'Sora', 'Abe', 'sora.abe@gmail.com', 'SoraAbe3568', TO_DATE('14.07.1994', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (391, 'Haruto', 'Kobayashi', 'haruto.kobayashi@gmail.com', 'HarutoKobayashi9076', TO_DATE('17.04.2005', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (392, 'Riko', 'Abe', 'riko.abe@gmail.com', 'RikoAbe8673', TO_DATE('03.02.1997', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (393, 'Riko', 'Nakamura', 'riko.nakamura@gmail.com', 'RikoNakamura5470', TO_DATE('24.09.1992', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (394, 'Yui', 'Nakamura', 'yui.nakamura@gmail.com', 'YuiNakamura6832', TO_DATE('30.03.2000', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (395, 'Kaito', 'Nishimura', 'kaito.nishimura@gmail.com', 'KaitoNishimura5451', TO_DATE('16.09.1999', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (396, 'Riko', 'Abe', 'riko.abe@gmail.com', 'RikoAbe4773', TO_DATE('27.04.1995', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (397, 'Aoi', 'Inoue', 'aoi.inoue@gmail.com', 'AoiInoue2329', TO_DATE('17.05.1995', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (398, 'Mio', 'Abe', 'mio.abe@gmail.com', 'MioAbe4040', TO_DATE('09.10.2001', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (399, 'Akari', 'Hayashi', 'akari.hayashi@gmail.com', 'AkariHayashi9822', TO_DATE('27.02.2004', 'DD.MM.YYYY'));
INSERT INTO klijent (klijent_id, ime, prezime, "E-mail", username, datum_rođenja) VALUES (400, 'Sora', 'Abe', 'sora.abe@gmail.com', 'SoraAbe3277', TO_DATE('03.05.2000', 'DD.MM.YYYY'));

-- inserti za tablicu igra --
INSERT INTO igra (igra_id, naziv, žanr, godina_izdavanja, platforma, cijena) VALUES (1, 'League of Legends', 'MOBA', TO_DATE('27.10.2009', 'DD.MM.YYYY'), 'PC', 0);
INSERT INTO igra (igra_id, naziv, žanr, godina_izdavanja, platforma, cijena) VALUES (2, 'Teamfight Tactics', 'Auto battler', TO_DATE('26.06.2019', 'DD.MM.YYYY'), 'PC', 0);
INSERT INTO igra (igra_id, naziv, žanr, godina_izdavanja, platforma, cijena) VALUES (3, 'Valorant', 'FPS', TO_DATE('02.06.2020', 'DD.MM.YYYY'), 'PC', 10);
INSERT INTO igra (igra_id, naziv, žanr, godina_izdavanja, platforma, cijena) VALUES (4, 'Legends of Runeterra', 'Card game', TO_DATE('30.04.2020', 'DD.MM.YYYY'), 'PC', 0);
INSERT INTO igra (igra_id, naziv, žanr, godina_izdavanja, platforma, cijena) VALUES (5, 'Wild Rift', 'MOBA', TO_DATE('27.10.2020', 'DD.MM.YYYY'), 'Mobile', 0);

-- inserti za tablicu animacija --
INSERT INTO animacija (animacija_id, naziv, duljina, vrsta) VALUES (5, 'Arcane', 430, 'TV series');
INSERT INTO animacija (animacija_id, naziv, duljina, vrsta) VALUES (6, 'Champion Spotlight', 3, 'Spotlight');
INSERT INTO animacija (animacija_id, naziv, duljina, vrsta) VALUES (7, 'End of Season Animation', 10, 'Animation');
INSERT INTO animacija (animacija_id, naziv, duljina, vrsta) VALUES (8, 'Worlds Animation', 3, 'Worlds Animation');
INSERT INTO animacija (animacija_id, naziv, duljina, vrsta) VALUES (9, 'K/DA Music Video', 5, 'Music video');
INSERT INTO animacija (animacija_id, naziv, duljina, vrsta) VALUES (10, 'True Damage Music Video', 5, 'Music video');
INSERT INTO animacija (animacija_id, naziv, duljina, vrsta) VALUES (11, 'Teaser', 5, 'Teaser');


-- inserti za tablicu projekt --
-- League of Legends --
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (1, 'New Champion Development', 'Creating unique characters with captivating lore and abilities, expanding the vibrant world of League of Legends.', 'Champion addition', 'In development', 1);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (2, 'Visual Updates', 'Revamping the visual and audio aspects of older champions to match the quality and standards of newer additions.', 'Visual', 'In development', 1);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (3, 'Game Mode Innovations', 'Designing and implementing new game modes, such as rotating game modes or experimental modes, to offer players fresh experiences.', 'Game mode', 'In development', 1);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (4, 'Map Design', 'Creating new maps or redesigning existing ones to provide a variety of battlegrounds for players.', 'Map', 'In development', 1);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (5, 'Champion Reworks', 'Updating older champions to modern standards of gameplay and visuals.', 'Champion rework', 'On hold', 1);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (6, 'Esports and Tournaments', 'Organizing and hosting esports tournaments, leagues, and events for professional players and the community.', 'Esports', 'In development', 1);
INSERT INTo projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (7, 'Balance and Gameplay Updates', 'Iteratively adjusting gameplay mechanics, champion abilities, and items to maintain a balanced and enjoyable experience.', 'Balance', 'In development', 1);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (8, 'Story Expansion', 'Expanding the lore and narrative universe of League of Legends through new champion releases, comic series, short films, and animations.', 'Story', 'In development', 1);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (9, 'Community Engagement', 'Developing community-focused projects like interactive events, fan art contests, and partnerships with content creators.', 'Community', 'In development', 1);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (10, 'Player Experience Enhancements:', 'Improving the overall player experience by implementing quality-of-life changes, optimizations, and user interface updates.', 'Player experience', 'On hold', 1);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (11, 'Accessibility and Localization', 'Ensuring the game is accessible to a global audience by working on localization, translations, and features that accommodate various player needs.', 'Skins', 'On hold', 1);

-- Teamfight Tactics --
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (12, 'New Set Development', 'Designing and balancing new champion sets with unique synergies and mechanics to refresh the meta and keep gameplay engaging.', 'Set', 'In development', 2);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (13, 'Gameplay Features', 'Developing new gameplay mechanics, systems, or items that introduce variety and strategy to matches.', 'Gameplay', 'In development', 2);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (14, 'Ranked Mode Enhancements', 'Improving the ranked experience by implementing new features, systems, and rewards.', 'Ranked', 'In development', 2);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (15, 'Esports Integration', 'Continuously optimizing the mobile version of Teamfight Tactics to ensure smooth performance and user experience.', 'Esports', 'In development', 2);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (16, 'Mobile Version Optimization', 'Optimizing the mobile version of League of Legends: Wild Rift to ensure a smooth and enjoyable experience for players.', 'Mobile', 'On hold', 2);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (17, 'Cosmetics and Customization', 'Creating new Little Legends, arenas, and emotes to allow players to personalize their in-game experience.', 'Skins', 'In development', 2);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (18, 'Interactive Events', 'Designing limited-time events, game modes, and missions that offer unique rewards and encourage player engagement.', 'Events', 'In development', 2);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (19, 'Social and Community Features', 'Developing features that enhance player interactions, such as clubs, social hubs, and improved friend systems.', 'Community', 'In development', 2);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (20, 'Tutorial and New Player Experience', 'Improving tutorials and resources for new players to learn the game mechanics and strategies effectively.' ,'Tutorial', 'In development', 2);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (21, 'Accessibility and Balance', 'Ensuring the game is accessible to a wide audience and maintaining balance through continuous champion and trait adjustments.', 'Accessibility', 'On hold', 2);

-- Valorant --
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (22, 'New Agent Development', 'Designing and creating new agents with unique abilities and playstyles to expand the roster and strategic options.', 'Agent', 'In development', 3);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (23, 'Map Design and Updates', 'Developing new maps and making adjustments to existing ones to keep the competitive environment fresh and balanced.', 'Map', 'In development', 3);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (24, 'Competitive Enhancements', 'Implementing improvements to ranked matchmaking, leaderboard systems, and competitive integrity features.', 'Competitive', 'In development', 3);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (25, 'Esports Integration', 'Building features that support the competitive scene, such as spectator modes, tournament tools, and esports events.', 'Esports', 'In development', 3);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (26, 'Cosmetics and Skins', 'Creating new weapon skins, character cosmetics, and battle passes to provide players with customization options.', 'Skins', 'On hold', 3);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (27, 'Quality-of-Life Improvements', 'Implementing user interface enhancements, gameplay optimizations, and features that enhance the overall player experience.', 'Quality-of-life', 'In development', 3);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (28, 'Community Interaction', 'Developing in-game events, interactive challenges, and community engagement initiatives to foster player involvement.', 'Community', 'In development', 3);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (29, 'Anti-Cheat Measures', 'Continuously improving the anti-cheat system to ensure a fair and secure gameplay environment.', 'Anti-cheat', 'In development', 3);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (30, 'New Game Modes', 'Designing alternative game modes, limited-time events, and experimental modes to diversify gameplay experiences.', 'Game mode', 'In development', 3);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (31, 'Accessibility and Localization', 'Ensuring that the game is accessible to players around the world through localization efforts, translations, and accessibility features.', 'Accessibility', 'On hold', 3);

-- Legends of runeterra --
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (32, 'New Card Development', 'Designing and creating new cards with unique mechanics and synergies to expand the roster and strategic options.', 'Card', 'In development', 4);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (33, 'Gameplay Features', 'Developing new gameplay mechanics, systems, or items that introduce variety and strategy to matches.', 'Gameplay', 'In development', 4);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (34, 'Ranked Mode Enhancements', 'Improving the ranked experience by implementing new features, systems, and rewards.', 'Ranked', 'In development', 4);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (35, 'Esports Integration', 'Building features that support the competitive scene, such as spectator modes, tournament tools, and esports events.', 'Esports', 'In development', 4);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (36, 'Cosmetics and Customization', 'Creating new boards, guardians, and emotes to allow players to personalize their in-game experience.', 'Skins', 'On holdt', 4);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (37, 'Interactive Events', 'Designing limited-time events, game modes, and missions that offer unique rewards and encourage player engagement.', 'Events', 'In development', 4);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (38, 'Social and Community Features', 'Developing features that enhance player interactions, such as clubs, social hubs, and improved friend systems.', 'Community', 'In development', 4);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (39, 'Tutorial and New Player Experience', 'Improving tutorials and resources for new players to learn the game mechanics and strategies effectively.', 'Tutorial', 'In development', 4);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (40, 'Accessibility and Balance', 'Ensuring the game is accessible to a wide audience and maintaining balance through continuous card adjustments.', 'Accessibility', 'In development', 4);

-- Wilf Rift --
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (41, 'New Champion Development', 'Creating unique characters with captivating lore and abilities to enrich Wilf Rift gaming experience', 'Champion addition', 'In development', 5);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (42, 'Visual Updates', 'Revamping the visual and audio aspects of older champions to match the quality and standards of newer additions.', 'Visual', 'In development', 5);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (43, 'Game Mode Innovations', 'Designing and implementing new game modes, such as rotating game modes or experimental modes, to offer players fresh experiences.', 'Game mode', 'In development', 5);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (44, 'Map Design', 'Creating new maps or redesigning existing ones to provide a variety of battlegrounds for players.', 'Map', 'In development', 5);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (45, 'Champion Reworks', 'Updating older champions to modern standards of gameplay and visuals.', 'Champion rework', 'In development', 5);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, igra_igra_ID) VALUES (46, 'Esports and Tournaments', 'Organizing and hosting esports tournaments, leagues, and events for professional players and the community.', 'Esports', 'On hold', 5);

-- Arcane --
INSERT INTO projekt (projekt_id, ime, opis, tip, status, animacija_animacija_ID) VALUES (47, 'Trailer and Teasers', 'Creating captivating trailers and teasers that offer glimpses of the animation style, characters, and key moments to build excitement before the series release.', 'Trailer', 'In development', 5);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, animacija_animacija_ID) VALUES (48, 'Social Media Campaigns', 'Developing engaging social media campaigns that introduce characters, share behind-the-scenes insights, and encourage fan engagement in the lead-up to the premiere.', 'Social media', 'In development', 5);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, animacija_animacija_ID) VALUES (49, 'Artbook Preview', 'Designing a preview of an artbook featuring concept art, character designs, and visual development that can be shared with fans prior to the release.', 'Artbook', 'In development', 5);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, animacija_animacija_ID) VALUES (50, 'Podcast Series', 'Producing a podcast series that discusses the making of "Arcane," featuring interviews with the creators, voice actors, and production team members.', 'Podcast', 'In development', 5);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, animacija_animacija_ID) VALUES (51, 'Interactive Website', 'Creating an interactive website that provides an immersive experience, allowing visitors to explore the world of "Arcane," learn about the characters, and uncover hidden content.', 'Website', 'In development', 5);
INSERT INTO projekt (projekt_id, ime, opis, tip, status, animacija_animacija_ID) VALUES (52, 'Merchandise', 'Designing merchandise, such as clothing, accessories, and collectibles, that can be sold to fans to commemorate the series.', 'Merchandise', 'In development', 5);

-- Champion Spotlight --
INSERT INTO projekt (projekt_id, ime, opis, tip, status, animacija_animacija_ID) VALUES (53, 'Champion Spotlight', 'Creating a champion spotlight video that introduces the champion’s abilities, playstyle, and lore to players.', 'Spotlight', 'On hold', 6);

-- End of Season Animation -- 
INSERT INTO projekt (projekt_id, ime, opis, tip, status, animacija_animacija_ID) VALUES (54, 'End of Season Animation', 'Creating an animation that celebrates the end of the season and highlights the accomplishments of players.', 'Animation', 'In development', 7);

-- Worlds Animation --
INSERT INTO projekt (projekt_id, ime, opis, tip, status, animacija_animacija_ID) VALUES (55, 'Worlds Animation', 'Creating an animation that celebrates the League of Legends World Championship and highlights the accomplishments of players.', 'Animation', 'In development', 8);

-- K/DA Music Video --
INSERT INTO projekt (projekt_id, ime, opis, tip, status, animacija_animacija_ID) VALUES (56, 'K/DA Music Video', 'Creating a music video featuring the K/DA music group to promote the release of new skins.', 'Music video', 'On hold', 9);

-- True Damage Music Video --
INSERT INTO projekt (projekt_id, ime, opis, tip, status, animacija_animacija_ID) VALUES (57, 'True Damage Music Video', 'Creating a music video featuring the True Damage music group to promote the release of new skins.', 'Music video', 'On hold', 10);

-- Teaser --
INSERT INTO projekt (projekt_id, ime, opis, tip, status, animacija_animacija_ID) VALUES (58, 'Teaser', 'Creating a teaser video that offers a glimpse of the animation style, characters, and key moments to build excitement before the series release.', 'Teaser', 'On hold', 11);


-- inserti za tablicu igra_klijent -- 
-- League of Legends --
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 1);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 6);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 11);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 16);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 21);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 26);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 31);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 36);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 41);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 46);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 51);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 56);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 61);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 66);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 71);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 76);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 81);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 86);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 91);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 96);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 101);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 106);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 111);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 116);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 121);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 126);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 131);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 136);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 141);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 146);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 151);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 156);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 161);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 166);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 171);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 176);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 181);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 186);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 191);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 196);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 201);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 206);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 211);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 216);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 221);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 226);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 231);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 236);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 241);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 246);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 251);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 256);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 261);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 266);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 271);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 276);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 281);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 286);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 291);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 296);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 301);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 306);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 311);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 316);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 321);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 326);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 331);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 336);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 341);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 346);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 351);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 356);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 361);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 366);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 371);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 376);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 381);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 386);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 391);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (1, 396);


-- Teamfight Tactics --
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 2);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 7);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 12);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 17);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 22);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 27);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 32);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 37);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 42);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 47);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 52);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 57);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 62);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 67);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 72);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 77);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 82);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 87);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 92);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 97);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 102);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 107);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 112);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 117);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 122);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 127);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 132);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 137);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 142);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 147);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 152);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 157);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 162);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 167);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 172);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 177);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 182);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 187);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 192);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 197);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 202);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 207);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 212);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 217);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 222);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 227);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 232);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 237);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 242);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 247);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 252);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 257);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 262);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 267);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 272);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 277);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 282);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 287);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 292);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 297);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 302);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 307);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 312);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 317);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 322);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 327);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 332);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 337);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 342);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 347);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 352);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 357);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 362);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 367);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 372);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 377);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 382);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 387);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 392);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (2, 397);


-- Valorant --
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 3);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 8);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 13);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 18);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 23);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 28);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 33);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 38);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 43);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 48);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 53);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 58);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 63);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 68);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 73);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 78);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 83);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 88);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 93);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 98);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 103);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 108);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 113);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 118);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 123);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 128);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 133);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 138);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 143);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 148);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 153);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 158);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 163);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 168);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 173);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 178);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 183);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 188);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 193);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 198);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 203);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 208);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 213);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 218);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 223);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 228);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 233);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 238);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 243);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 248);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 253);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 258);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 263);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 268);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 273);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 278);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 283);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 288);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 293);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 298);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 303);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 308);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 313);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 318);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 323);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 328);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 333);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 338);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 343);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 348);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 353);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 358);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 363);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 368);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 373);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 378);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 383);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 388);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 393);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (3, 398);

-- Legends of Runeterra --
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 4);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 9);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 14);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 19);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 24);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 29);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 34);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 39);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 44);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 49);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 54);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 59);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 64);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 69);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 74);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 79);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 84);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 89);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 94);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 99);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 104);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 109);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 114);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 119);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 124);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 129);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 134);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 139);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 144);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 149);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 154);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 159);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 164);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 169);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 174);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 179);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 184);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 189);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 194);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 199);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 204);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 209);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 214);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 219);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 224);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 229);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 234);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 239);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 244);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 249);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 254);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 259);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 264);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 269);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 274);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 279);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 284);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 289);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 294);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 299);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 304);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 309);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 314);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 319);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 324);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 329);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 334);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 339);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 344);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 349);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 354);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 359);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 364);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 369);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 374);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 379);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 384);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 389);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 394);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (4, 399);


-- Wild Rift --
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 5);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 10);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 15);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 20);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 25);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 30);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 35);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 40);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 45);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 50);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 55);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 60);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 65);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 70);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 75);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 80);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 85);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 90);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 95);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 100);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 105);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 110);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 115);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 120);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 125);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 130);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 135);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 140);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 145);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 150);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 155);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 160);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 165);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 170);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 175);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 180);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 185);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 190);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 195);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 200);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 205);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 210);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 215);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 220);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 225);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 230);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 235);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 240);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 245);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 250);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 255);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 260);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 265);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 270);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 275);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 280);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 285);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 290);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 295);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 300);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 305);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 310);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 315);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 320);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 325);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 330);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 335);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 340);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 345);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 350);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 355);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 360);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 365);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 370);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 375);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 380);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 385);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 390);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 395);
INSERT INTO igra_klijent (igra_igra_id, klijent_klijent_id) VALUES (5, 400);


-- inserti za tablicu sjediste --
INSERT INTO sjediste (sjediste_id, naziv, mjesto) VALUES (1, 'Riot North America', 'Los Angeles, California');
INSERT INTO sjediste (sjediste_id, naziv, mjesto) VALUES (2, 'Riot Europe', 'Dublin, Ireland');
INSERT INTO sjediste (sjediste_id, naziv, mjesto) VALUES (3, 'Riot Brazil', 'São Paulo, Brazil');
INSERT INTO sjediste (sjediste_id, naziv, mjesto) VALUES (4, 'Riot Turkey', 'Istanbul, Turkey');
INSERT INTO sjediste (sjediste_id, naziv, mjesto) VALUES (5, 'Riot Russia', 'Moscow, Russia');
INSERT INTO sjediste (sjediste_id, naziv, mjesto) VALUES (6, 'Riot China', 'Shanghai, China');
INSERT INTO sjediste (sjediste_id, naziv, mjesto) VALUES (7, 'Riot Korea', 'Seoul, South Korea');
INSERT INTO sjediste (sjediste_id, naziv, mjesto) VALUES (8, 'Riot Japan', 'Tokyo, Japan');

-- inserti za tablicu zaposlenik -- 
-- Riot North America --
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (1, 'Alex', 'Johnson', 'Lead Developer', TO_DATE('2010-06-15', 'YYYY-MM-DD'), 9000, 'alex.johnson@example.com', '123-456-7890', 1);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (2, 'Emily', 'Smith', 'Artist', TO_DATE('2015-03-22', 'YYYY-MM-DD'), 5500, 'emily.smith@example.com', '987-654-3210', 1);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (3, 'Daniel', 'Williams', 'Writer', TO_DATE('2008-11-10', 'YYYY-MM-DD'), 6700, 'daniel.williams@example.com', '555-123-4567', 1);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (4, 'Sophia', 'Brown', 'Designer', TO_DATE('2012-07-05', 'YYYY-MM-DD'), 8000, 'sophia.brown@example.com', '777-888-9999', 1);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (5, 'Liam', 'Davis', 'Programmer', TO_DATE('2011-09-20', 'YYYY-MM-DD'), 9500, 'liam.davis@example.com', '222-333-4444', 1);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (6, 'Olivia', 'Taylor', 'Animator', TO_DATE('2016-04-12', 'YYYY-MM-DD'), 6000, 'olivia.taylor@example.com', '555-789-1234', 1);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (7, 'Noah', 'Martinez', 'Programmer', TO_DATE('2010-11-30', 'YYYY-MM-DD'), 7000, 'noah.martinez@example.com', '111-222-3333', 1);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (8, 'Emma', 'Anderson', 'Animator', TO_DATE('2013-08-18', 'YYYY-MM-DD'), 8500, 'emma.anderson@example.com', '444-555-6666', 1);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (9, 'Liam', 'Rodriguez', 'Programmer', TO_DATE('2013-03-10', 'YYYY-MM-DD'), 9000, 'liam.rodriguez@example.com', '777-888-5555', 1);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (10, 'Ava', 'Garcia', 'Animator', TO_DATE('2014-06-25', 'YYYY-MM-DD'), 6200, 'ava.garcia@example.com', '222-555-8888', 1);

-- Riot Europe --
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (11, 'Matteo', 'Rossi', 'Lead Developer', TO_DATE('2012-04-01', 'YYYY-MM-DD'), 8200, 'matteo.rossi@example.com', '111-222-3333', 2);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (12, 'Sophia', 'Rossi', 'Artist', TO_DATE('2018-09-15', 'YYYY-MM-DD'), 5700, 'sophia.rossi@example.com', '555-666-7777', 2);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (13, 'Luca', 'Bianchi', 'Writer', TO_DATE('2011-07-20', 'YYYY-MM-DD'), 6900, 'luca.bianchi@example.com', '888-999-0000', 2);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (14, 'Isabella', 'Bianchi', 'Designer', TO_DATE('2015-02-08', 'YYYY-MM-DD'), 7800, 'isabella.bianchi@example.com', '123-456-7890', 2);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (15, 'Leon', 'Müller', 'Programmer', TO_DATE('2011-11-12', 'YYYY-MM-DD'), 8800, 'leon.muller@example.com', '555-555-5555', 2);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (16, 'Emma', 'Müller', 'Animator', TO_DATE('2017-05-03', 'YYYY-MM-DD'), 6200, 'emma.muller@example.com', '666-777-8888', 2);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (17, 'Lukas', 'Kovács', 'Programmer', TO_DATE('2010-08-28', 'YYYY-MM-DD'), 7200, 'lukas.kovacs@example.com', '999-000-1111', 2);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (18, 'Amelie', 'Kovács', 'Animator', TO_DATE('2014-03-17', 'YYYY-MM-DD'), 8300, 'amelie.kovacs@example.com', '444-444-4444', 2);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (19, 'Matteo', 'Novak', 'Programmer', TO_DATE('2011-12-05', 'YYYY-MM-DD'), 9200, 'matteo.novak@example.com', '777-777-7777', 2);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (20, 'Lena', 'Kovács', 'Animator', TO_DATE('2016-02-28', 'YYYY-MM-DD'), 6400, 'lena.kovacs@example.com', '222-222-2222', 2);

-- Riot Brazil --
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (21, 'Lucas', 'Silva', 'Lead Developer', TO_DATE('2013-10-10', 'YYYY-MM-DD'), 8500, 'lucas.silva@example.com', '111-222-3333', 3);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (22, 'Mariana', 'Silva', 'Artist', TO_DATE('2019-02-18', 'YYYY-MM-DD'), 5300, 'mariana.silva@example.com', '555-666-7777', 3);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (23, 'Pedro', 'Souza', 'Writer', TO_DATE('2014-05-22', 'YYYY-MM-DD'), 6800, 'pedro.souza@example.com', '888-999-0000', 3);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (24, 'Gabriela', 'Souza', 'Designer', TO_DATE('2017-08-11', 'YYYY-MM-DD'), 7600, 'gabriela.souza@example.com', '123-456-7890', 3);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (25, 'Rafael', 'Costa', 'Programmer', TO_DATE('2012-03-07', 'YYYY-MM-DD'), 9000, 'rafael.costa@example.com', '555-555-5555', 3);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (26, 'Amanda', 'Costa', 'Animator', TO_DATE('2018-06-29', 'YYYY-MM-DD'), 5900, 'amanda.costa@example.com', '666-777-8888', 3);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (27, 'Vinícius', 'Oliveira', 'Programmer', TO_DATE('2016-09-02', 'YYYY-MM-DD'), 7000, 'vinicius.oliveira@example.com', '999-000-1111', 3);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (28, 'Isabela', 'Oliveira', 'Animator', TO_DATE('2020-12-14', 'YYYY-MM-DD'), 7800, 'isabela.oliveira@example.com', '444-444-4444', 3);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (29, 'João', 'Santos', 'Programmer', TO_DATE('2011-02-25', 'YYYY-MM-DD'), 8700, 'joao.santos@example.com', '777-777-7777', 3);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (30, 'Bianca', 'Santos', 'Animator', TO_DATE('2017-05-14', 'YYYY-MM-DD'), 6000, 'bianca.santos@example.com', '222-222-2222', 3);

-- Riot Turkey --
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (31, 'Emir', 'Yılmaz', 'Lead Developer', TO_DATE('2015-05-20', 'YYYY-MM-DD'), 8500, 'emir.yilmaz@example.com', '555-666-7777', 4);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (32, 'Zeynep', 'Öztürk', 'Artist', TO_DATE('2017-02-10', 'YYYY-MM-DD'), 5200, 'zeynep.ozturk@example.com', '888-999-0000', 4);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (33, 'Burak', 'Kaya', 'Writer', TO_DATE('2018-09-01', 'YYYY-MM-DD'), 6500, 'burak.kaya@example.com', '123-456-7890', 4);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (34, 'Ebru', 'Kaya', 'Designer', TO_DATE('2019-03-15', 'YYYY-MM-DD'), 7600, 'ebru.kaya@example.com', '555-555-5555', 4);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (35, 'Mert', 'Çelik', 'Programmer', TO_DATE('2016-06-12', 'YYYY-MM-DD'), 9200, 'mert.celik@example.com', '666-777-8888', 4);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (36, 'Ayşe', 'Çelik', 'Animator', TO_DATE('2020-01-03', 'YYYY-MM-DD'), 6200, 'ayse.celik@example.com', '999-000-1111', 4);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (37, 'Ozan', 'Demir', 'Programmer', TO_DATE('2013-04-25', 'YYYY-MM-DD'), 7200, 'ozan.demir@example.com', '444-444-4444', 4);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (38, 'Elif', 'Demir', 'Animator', TO_DATE('2017-08-10', 'YYYY-MM-DD'), 8300, 'elif.demir@example.com', '777-777-7777', 4);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (39, 'Kaan', 'Aksoy', 'Programmer', TO_DATE('2012-11-19', 'YYYY-MM-DD'), 8900, 'kaan.aksoy@example.com', '555-555-5555', 4);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (40, 'Selin', 'Aksoy', 'Animator', TO_DATE('2014-07-07', 'YYYY-MM-DD'), 5900, 'selin.aksoy@example.com', '222-222-2222', 4);

-- Riot Russia --
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (41, 'Dmitri', 'Ivanov', 'Lead Developer', TO_DATE('2015-03-15', 'YYYY-MM-DD'), 8000, 'dmitri.ivanov@example.com', '111-222-3333', 5);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (42, 'Sofia', 'Ivanov', 'Lead Artist', TO_DATE('2019-08-25', 'YYYY-MM-DD'), 5400, 'sofia.ivanov@example.com', '555-666-7777', 5);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (43, 'Alexei', 'Petrov', 'Writer', TO_DATE('2016-05-01', 'YYYY-MM-DD'), 6700, 'alexei.petrov@example.com', '888-999-0000', 5);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (44, 'Ekaterina', 'Petrov', 'Animator', TO_DATE('2020-01-10', 'YYYY-MM-DD'), 7500, 'ekaterina.petrov@example.com', '123-456-7890', 5);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (45, 'Andrei', 'Sokolov', 'Programmer', TO_DATE('2014-07-20', 'YYYY-MM-DD'), 8800, 'andrei.sokolov@example.com', '555-555-5555', 5);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (46, 'Olga', 'Sokolov', 'Animator', TO_DATE('2018-09-05', 'YYYY-MM-DD'), 6200, 'olga.sokolov@example.com', '666-777-8888', 5);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (47, 'Igor', 'Smirnov', 'Programmer', TO_DATE('2013-02-12', 'YYYY-MM-DD'), 7100, 'igor.smirnov@example.com', '999-000-1111', 5);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (48, 'Natalia', 'Smirnov', 'Animator', TO_DATE('2017-11-18', 'YYYY-MM-DD'), 8200, 'natalia.smirnov@example.com', '444-444-4444', 5);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (49, 'Mikhail', 'Kuznetsov', 'Programmer', TO_DATE('2012-04-30', 'YYYY-MM-DD'), 9100, 'mikhail.kuznetsov@example.com', '777-777-7777', 5);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (50, 'Elena', 'Kuznetsov', 'Animator', TO_DATE('2016-06-07', 'YYYY-MM-DD'), 6000, 'elena.kuznetsov@example.com', '222-222-2222', 5);

-- Riot China --
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (51, 'Wei', 'Li', 'Lead Developer', TO_DATE('2016-03-21', 'YYYY-MM-DD'), 7900, 'wei.li@example.com', '111-222-3333', 6);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (52, 'Xinyi', 'Wang', 'Artist', TO_DATE('2019-07-12', 'YYYY-MM-DD'), 5100, 'xinyi.wang@example.com', '555-666-7777', 6);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (53, 'Jing', 'Chen', 'Writer', TO_DATE('2017-05-02', 'YYYY-MM-DD'), 6300, 'jing.chen@example.com', '888-999-0000', 6);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (54, 'Yuan', 'Chen', 'Designer', TO_DATE('2020-01-18', 'YYYY-MM-DD'), 7200, 'yuan.chen@example.com', '123-456-7890', 6);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (55, 'Jia', 'Zhang', 'Programmer', TO_DATE('2018-08-05', 'YYYY-MM-DD'), 8600, 'jia.zhang@example.com', '555-555-5555', 6);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (56, 'Xin', 'Zhang', 'Animator', TO_DATE('2020-03-29', 'YYYY-MM-DD'), 5900, 'xin.zhang@example.com', '666-777-8888', 6);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (57, 'Wei', 'Liu', 'Programmer', TO_DATE('2019-01-10', 'YYYY-MM-DD'), 6900, 'wei.liu@example.com', '999-000-1111', 6);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (58, 'Mei', 'Liu', 'Animator', TO_DATE('2021-04-22', 'YYYY-MM-DD'), 7800, 'mei.liu@example.com', '444-444-4444', 6);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (59, 'Ziyi', 'Yang', 'Programmer', TO_DATE('2015-11-15', 'YYYY-MM-DD'), 9200, 'ziyi.yang@example.com', '777-777-7777', 6);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (60, 'Yan', 'Yang', 'Animator', TO_DATE('2020-02-07', 'YYYY-MM-DD'), 6400, 'yan.yang@example.com', '222-222-2222', 6);

-- Riot Korea --
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (61, 'Minho', 'Kim', 'Lead Developer', TO_DATE('2017-09-18', 'YYYY-MM-DD'), 7900, 'minho.kim@example.com', '111-222-3333', 7);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (62, 'Jiwoo', 'Kim', 'Artist', TO_DATE('2019-11-12', 'YYYY-MM-DD'), 5300, 'jiwoo.kim@example.com', '555-666-7777', 7);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (63, 'Seojin', 'Lee', 'Writer', TO_DATE('2018-07-05', 'YYYY-MM-DD'), 6700, 'seojin.lee@example.com', '888-999-0000', 7);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (64, 'Haeun', 'Lee', 'Designer', TO_DATE('2020-04-18', 'YYYY-MM-DD'), 7200, 'haeun.lee@example.com', '123-456-7890', 7);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (65, 'Joon', 'Park', 'Programmer', TO_DATE('2016-02-27', 'YYYY-MM-DD'), 8600, 'joon.park@example.com', '555-555-5555', 7);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (66, 'Hyerin', 'Park', 'Animator', TO_DATE('2021-01-09', 'YYYY-MM-DD'), 5900, 'hyerin.park@example.com', '666-777-8888', 7);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (67, 'Kyung', 'Kim', 'Programmer', TO_DATE('2019-03-27', 'YYYY-MM-DD'), 6900, 'kyung.kim@example.com', '999-000-1111', 7);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (68, 'Haeun', 'Kim', 'Animator', TO_DATE('2022-06-03', 'YYYY-MM-DD'), 7800, 'haeun.kim@example.com', '444-444-4444', 7);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (69, 'Jinwoo', 'Choi', 'Programmer', TO_DATE('2015-08-21', 'YYYY-MM-DD'), 9000, 'jinwoo.choi@example.com', '777-777-7777', 7);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (70, 'Mina', 'Choi', 'Animator', TO_DATE('2020-07-11', 'YYYY-MM-DD'), 6100, 'mina.choi@example.com', '222-222-2222', 7);

-- Riot Japan --
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (71, 'Sei', 'Nayashi', 'Lead Developer', TO_DATE('2018-04-17', 'YYYY-MM-DD'), 8000, 'haruki.sato@example.com', '111-222-3333', 8);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (72, 'Aoi', 'Sato', 'Artist', TO_DATE('2020-09-22', 'YYYY-MM-DD'), 5200, 'aoi.sato@example.com', '555-666-7777', 8);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (73, 'Yuki', 'Takahashi', 'Writer', TO_DATE('2019-03-05', 'YYYY-MM-DD'), 6400, 'yuki.takahashi@example.com', '888-999-0000', 8);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (74, 'Sakura', 'Takahashi', 'Designer', TO_DATE('2021-01-15', 'YYYY-MM-DD'), 7500, 'sakura.takahashi@example.com', '123-456-7890', 8);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (75, 'Hiroshi', 'Tanaka', 'Programmer', TO_DATE('2017-06-25', 'YYYY-MM-DD'), 8800, 'hiroshi.tanaka@example.com', '555-555-5555', 8);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (76, 'Mai', 'Tanaka', 'Animator', TO_DATE('2020-02-28', 'YYYY-MM-DD'), 5900, 'mai.tanaka@example.com', '666-777-8888', 8);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (77, 'Kaito', 'Nakamura', 'Programmer', TO_DATE('2019-09-10', 'YYYY-MM-DD'), 6900, 'kaito.nakamura@example.com', '999-000-1111', 8);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (78, 'Hina', 'Nakamura', 'Animator', TO_DATE('2022-04-05', 'YYYY-MM-DD'), 7900, 'hina.nakamura@example.com', '444-444-4444', 8);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (79, 'Sora', 'Kobayashi', 'Programmer', TO_DATE('2016-08-14', 'YYYY-MM-DD'), 9000, 'sora.kobayashi@example.com', '777-777-7777', 8);
INSERT INTO zaposlenik (zaposlenik_id, ime, prezime, pozicija, datum_zaposlenja, plaća, email, broj_telefona, sjediste_sjediste_id)
VALUES (80, 'Ren', 'Kobayashi', 'Animator', TO_DATE('2021-03-07', 'YYYY-MM-DD'), 6200, 'ren.kobayashi@example.com', '222-222-2222', 8);

-- inserti za tablicu tim --
INSERT INTO tim (tim_id, naziv, vrsta, datum_osnivanja, broj_članova) VALUES (1, 'Riot NA Development', 'Development', TO_DATE('2012-07-05', 'YYYY-MM-DD'), 5);
INSERT INTO tim (tim_id, naziv, vrsta, datum_osnivanja, broj_članova) VALUES (2, 'Riot NA Animation', 'Animation', TO_DATE('2010-06-15', 'YYYY-MM-DD'), 5);
INSERT INTO tim (tim_id, naziv, vrsta, datum_osnivanja, broj_članova) VALUES (3, 'Riot EU Development', 'Development', TO_DATE('2012-04-01', 'YYYY-MM-DD'), 5);
INSERT INTO tim (tim_id, naziv, vrsta, datum_osnivanja, broj_članova) VALUES (4, 'Riot EU Animation', 'Animation', TO_DATE('2015-02-08', 'YYYY-MM-DD'), 5);
INSERT INTO tim (tim_id, naziv, vrsta, datum_osnivanja, broj_članova) VALUES (5, 'Riot Brazil Development', 'Development', TO_DATE('2013-10-10', 'YYYY-MM-DD'), 5);
INSERT INTO tim (tim_id, naziv, vrsta, datum_osnivanja, broj_članova) VALUES (6, 'Riot Brazil Animation', 'Animation', TO_DATE('2017-08-11', 'YYYY-MM-DD'), 5);
INSERT INTO tim (tim_id, naziv, vrsta, datum_osnivanja, broj_članova) VALUES (7, 'Riot Turkey Development', 'Development', TO_DATE('2015-05-20', 'YYYY-MM-DD'), 5);
INSERT INTO tim (tim_id, naziv, vrsta, datum_osnivanja, broj_članova) VALUES (8, 'Riot Turkey Animation', 'Animation', TO_DATE('2019-03-15', 'YYYY-MM-DD'), 5);
INSERT INTO tim (tim_id, naziv, vrsta, datum_osnivanja, broj_članova) VALUES (9, 'Riot Russia Development', 'Development', TO_DATE('2015-03-15', 'YYYY-MM-DD'), 5);
INSERT INTO tim (tim_id, naziv, vrsta, datum_osnivanja, broj_članova) VALUES (10, 'Riot Russia Animation', 'Animation', TO_DATE('2019-08-25', 'YYYY-MM-DD'), 5);
INSERT INTO tim (tim_id, naziv, vrsta, datum_osnivanja, broj_članova) VALUES (11, 'Riot China Development', 'Development', TO_DATE('2016-03-21', 'YYYY-MM-DD'), 5);
INSERT INTO tim (tim_id, naziv, vrsta, datum_osnivanja, broj_članova) VALUES (12, 'Riot China Animation', 'Animation', TO_DATE('2020-01-18', 'YYYY-MM-DD'), 5);
INSERT INTO tim (tim_id, naziv, vrsta, datum_osnivanja, broj_članova) VALUES (13, 'Riot Korea Development', 'Development', TO_DATE('2017-09-18', 'YYYY-MM-DD'), 5);
INSERT INTO tim (tim_id, naziv, vrsta, datum_osnivanja, broj_članova) VALUES (14, 'Riot Korea Animation', 'Animation', TO_DATE('2020-04-18', 'YYYY-MM-DD'), 5);
INSERT INTO tim (tim_id, naziv, vrsta, datum_osnivanja, broj_članova) VALUES (15, 'Riot Japan Development', 'Development', TO_DATE('2018-04-17', 'YYYY-MM-DD'), 5);
INSERT INTO tim (tim_id, naziv, vrsta, datum_osnivanja, broj_članova) VALUES (16, 'Riot Japan Animation', 'Animation', TO_DATE('2021-01-15', 'YYYY-MM-DD'), 5);

-- inserti za tablicu zaposlenik_tim --
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (1, 1);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (3, 1);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (5, 1);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (7, 1);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (9, 1);

INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (2, 2);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (4, 2);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (6, 2);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (8, 2);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (10, 2);

INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (11, 3);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (13, 3);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (15, 3);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (17, 3);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (19, 3);

INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (12, 4);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (14, 4);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (16, 4);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (18, 4);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (20, 4);

INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (21, 5);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (23, 5);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (25, 5);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (27, 5);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (29, 5);

INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (22, 6);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (24, 6);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (26, 6);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (28, 6);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (30, 6);

INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (31, 7);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (33, 7);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (35, 7);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (37, 7);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (39, 7);

INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (32, 8);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (34, 8);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (36, 8);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (38, 8);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (40, 8);

INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (41, 9);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (43, 9);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (45, 9);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (47, 9);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (49, 9);

INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (42, 10);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (44, 10);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (46, 10);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (48, 10);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (50, 10);

INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (51, 11);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (53, 11);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (55, 11);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (57, 11);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (59, 11);

INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (52, 12);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (54, 12);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (56, 12);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (58, 12);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (60, 12);

INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (61, 13);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (63, 13);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (65, 13);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (67, 13);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (69, 13);

INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (62, 14);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (64, 14);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (66, 14);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (68, 14);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (70, 14);

INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (71, 15);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (73, 15);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (75, 15);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (77, 15);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (79, 15);

INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (72, 16);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (74, 16);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (76, 16);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (78, 16);
INSERT INTO zaposlenik_tim (zaposlenik_zaposlenik_id, tim_tim_id) VALUES (80, 16);

--inserti za tablicu tim_projekt --
-- igre --
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (1, 1);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (1, 2);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (1, 3);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (1, 4);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (1, 12);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (1, 41);

INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (3, 1);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (3, 2);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (3, 6);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (3, 7);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (3, 8);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (3, 9);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (3, 42);

INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (5, 1);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (5, 2);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (5, 12);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (5, 13);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (5, 14);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (5, 15);

INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (7, 1);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (7, 2);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (7, 17);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (7, 18);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (7, 19);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (7, 20);

INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (9, 1);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (9, 2);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (9, 32);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (9, 22);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (9, 23);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (9, 24);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (9, 25);

INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (11, 1);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (11, 2);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (11, 22);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (11, 27);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (11, 28);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (11, 29);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (11, 30);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (11, 43);

INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (13, 1);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (13, 2);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (13, 32);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (13, 33);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (13, 34);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (13, 35);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (13, 44);

INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (15, 1);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (15, 2);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (15, 12);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (15, 37);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (15, 38);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (15, 39);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (15, 40);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (15, 45);

-- animacije --
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (2, 47);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (2, 48);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (2, 49);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (2, 50);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (2, 51);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (2, 52);

INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (4, 47);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (4, 48);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (4, 49);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (4, 50);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (4, 51);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (4, 52);

INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (6, 47);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (6, 48);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (6, 49);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (6, 50);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (6, 51);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (6, 52);

INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (8, 47);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (8, 48);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (8, 49);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (8, 50);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (8, 51);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (8, 52);

INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (10, 47);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (10, 48);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (10, 49);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (10, 50);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (10, 51);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (10, 52);

INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (12, 47);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (12, 48);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (12, 49);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (12, 50);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (12, 51);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (12, 52);

INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (14, 47);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (14, 48);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (14, 49);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (14, 50);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (14, 51);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (14, 52);

INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (16, 47);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (16, 48);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (16, 49);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (16, 50);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (16, 51);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (16, 52);

INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (2, 54);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (4, 54);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (6, 54);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (8, 54);

INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (10, 55);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (12, 55);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (14, 55);
INSERT INTO tim_projekt (tim_tim_id, projekt_projekt_id) VALUES (16, 55);


COMMIT;

-- jednostavni selecti --
SELECT ime, prezime, pozicija
FROM zaposlenik;


SELECT ime, status
FROM projekt;

SELECT naziv, vrsta
FROM tim;

-- dohvaćanje imena svih zaposlenika koji su dio Riot NA Development tima --
SELECT z.ime, z.prezime
FROM zaposlenik z
JOIN zaposlenik_tim zt ON z.zaposlenik_id = zt.zaposlenik_zaposlenik_id
JOIN tim t ON zt.tim_tim_id = t.tim_id
WHERE t.naziv = 'Riot NA Development';

SELECT ime, prezime, plaća
FROM zaposlenik
WHERE plaća > 7999;

-- upiti nad više tablica --
-- upit stvara rezultat koji prikazuje ime i prezime zaposlenika te nazive tima i projekta na kojem svaki zaposlenik radi --
SELECT z.ime, z.prezime, t.naziv, pr.ime
FROM zaposlenik z
JOIN zaposlenik_tim zt ON z.zaposlenik_id = zt.zaposlenik_zaposlenik_id
JOIN tim t ON zt.tim_tim_id = t.tim_id
JOIN tim_projekt tp ON t.tim_id = tp.tim_tim_id
JOIN projekt pr ON tp.projekt_projekt_id = pr.projekt_id
FETCH FIRST 10 ROWS ONLY;

-- naziv sjedista i ime i prezime zaposlenika koji rade na tom sjedistu --
SELECT naziv, ime, prezime
FROM zaposlenik
INNER JOIN sjediste ON sjediste.sjediste_id = zaposlenik.sjediste_sjediste_id
ORDER BY naziv
FETCH FIRST 10 ROWS ONLY;

-- nativ time koji radi na projektu s id 1 --
SELECT t.naziv
FROM tim t
INNER JOIN tim_projekt ON t.tim_id = tim_projekt.tim_tim_id
INNER JOIN projekt ON tim_projekt.projekt_projekt_id = projekt.projekt_id
WHERE projekt_id = 1;

-- imena i prezimena klijenata koji igraju igre s cijenom od 10  --
SELECT k.ime, k.prezime 
FROM klijent k
INNER JOIN igra_klijent ON k.klijent_id = igra_klijent.klijent_klijent_id
INNER JOIN igra ON igra_klijent.igra_igra_id = igra.igra_id
WHERE cijena = 10;

-- naziv i duljinu animacije koja je na cekanju --
SELECT naziv, duljina
FROM animacija 
INNER JOIN projekt ON projekt.animacija_animacija_id = animacija.animacija_id
WHERE status = 'On hold';


-- koristeci agregirajuce funkcije --

SELECT COUNT(*)
FROM zaposlenik;

SELECT COUNT(*)
FROM animacija
WHERE duljina > 5;

SELECT AVG(plaća)
FROM zaposlenik

-- ukupna cijena svih igara koje su skuplje od 1 --
SELECT SUM(cijena)
FROM igra
WHERE cijena > 1;

-- naziv tima i broj zaposlenika u timu --
SELECT t.naziv, COUNT(*)
FROM tim t
INNER JOIN zaposlenik_tim ON t.tim_id = zaposlenik_tim.tim_tim_id
GROUP BY t.naziv;



-- Napraviti 5 upita u kojima će se koristiti nešto od sljedećeg: podupiti, ugniježđeni upiti ili skupovne operacije --

-- imena svih zaposlenika koji imaju veću placu od prosjecne place --
-- podupit --
SELECT ime, prezime
FROM zaposlenik
WHERE plaća > (SELECT AVG(plaća) FROM zaposlenik);

-- imena i prezimena zaposlenika koji su povezani s timovima koji rade na projektu "Story Expansion" --
-- ugnijezdeni upit --
SELECT ime, prezime
FROM zaposlenik
WHERE zaposlenik_id IN (
    SELECT zt.zaposlenik_zaposlenik_id
    FROM tim_projekt tp
    JOIN zaposlenik_tim zt ON tp.tim_tim_id = zt.tim_tim_id
    WHERE tp.projekt_projekt_id = (
        SELECT projekt_id
        FROM projekt
        WHERE ime = 'Story Expansion'
    )
);


-- imena svih klijenata koji igraju igru s id 5 --
SELECT ime, prezime
FROM klijent 
WHERE klijent_ID IN (
    SELECT klijent_klijent_id
    FROM igra_klijent
    WHERE igra_igra_id = 5
);


--  imena svih zaposlenika koji su na istim timovima kao i zaposlenik s ID-om 5 --
SELECT ime, prezime
FROM zaposlenik
WHERE zaposlenik_id IN (
    SELECT zaposlenik_zaposlenik_id
    FROM zaposlenik_tim
    WHERE tim_tim_id IN (
        SELECT tim_tim_id
        FROM zaposlenik_tim
        WHERE zaposlenik_zaposlenik_id = 5
    )
);

--  imena prvih 3 animacija koje imaju najvecu duljinu --
SELECT naziv
FROM animacija
ORDER BY duljina DESC
FETCH FIRST 3 ROWS ONLY;


-- Dodajte zadanu vrijednost na nekoliko atributa unutar baze (smisleno odabrati atribute na kojima će se dodati) --
ALTER TABLE Zaposlenik MODIFY datum_zaposlenja DATE DEFAULT SYSDATE;

ALTER TABLE Projekt MODIFY Status VARCHAR(20) DEFAULT 'In progress';

-- Dodajte nekoliko uvjeta (smislenih, na način da pronađete stvari koje ima smisla provjeriti kod unosa) --
-- provjera da li je klijentov user vulgaran, sto ne zelimo -- 
ALTER TABLE klijent ADD CONSTRAINT username_check
CHECK (username NOT IN ('swearword1', 'swearword2', 'swearword3'));

ALTER TABLE zaposlenik ADD CONSTRAINT pozicija_check
CHECK (pozicija IN ('Lead developer', 'Programmer', 'Designer', 'Animator', 'Writer', 'Artist'));


--  Dodajte komentare na tablice unutar modela --

COMMENT ON TABLE zaposlenik IS 'Tablica koja sadrzi podatke o zaposlenicima';
COMMENT ON TABLE klijent IS 'Tablica koja sadrzi podatke o klijentima';
COMMENT ON TABLE projekt IS 'Tablica koja sadrzi podatke o projektima';
COMMENT ON TABLE tim IS 'Tablica koja sadrzi podatke o timovima';
COMMENT ON TABLE animacija IS 'Tablica koja sadrzi podatke o animacijama';
COMMENT ON TABLE igra IS 'Tablica koja sadrzi podatke o igrama';
COMMENT ON TABLE sjediste IS 'Tablica koja sadrzi podatke o sjedistima';

-- Dodajte neke od indeksa koji bi mogli dovesti do ubrzanja upita na Vašoj bazi -- 

CREATE INDEX zaposlenik_ime_idx ON zaposlenik (ime);
CREATE INDEX zaposlenik_prezime_idx ON zaposlenik (prezime);
CREATE INDEX zaposlenik_pozicija_idx ON zaposlenik (pozicija);
CREATE INDEX zaposlenik_placa_idx ON zaposlenik (placa);
CREATE INDEX klijent_ime_idx ON klijent (ime);

-- Napraviti barem dvije različite procedure koje ne koriste iste tablice (sami odlučujete za što i kakve) --

-- Ova procedura omogućuje dodavanje novog zaposlenika u tablicu zaposlenik --
CREATE OR REPLACE PROCEDURE dodaj_zaposlenika (
    p_ime IN zaposlenik.ime%TYPE,
    p_prezime IN zaposlenik.prezime%TYPE,
    p_pozicija IN zaposlenik.pozicija%TYPE,
    p_plaća IN zaposlenik.plaća%TYPE
) AS
BEGIN
    INSERT INTO zaposlenik (ime, prezime, pozicija, plaća)
    VALUES (p_ime, p_prezime, p_pozicija, p_plaća);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Novi zaposlenik dodan: ' || p_ime || ' ' || p_prezime);
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Greška prilikom dodavanja zaposlenika');
END;
/


-- procedura omogućuje ažuriranje place zaposlenika na temelju njihovog ID-a. --
CREATE OR REPLACE PROCEDURE azuriraj_placu (
    p_zaposlenik_id IN zaposlenik.zaposlenik_id%TYPE,
    p_nova_plaća IN zaposlenik.plaća%TYPE
) AS
BEGIN
    UPDATE zaposlenik
    SET plaća = p_nova_plaća
    WHERE zaposlenik_id = p_zaposlenik_id;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Plaća ažurirana za zaposlenika ID ' || p_zaposlenik_id);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Zaposlenik s ID-om ' || p_zaposlenik_id || ' ne postoji');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Greška prilikom ažuriranja plaće');
END;
/


--  Napraviti barem dva okidača (sami odlučujete kakva) --
CREATE OR REPLACE TRIGGER trg_nova_igra_cijena
BEFORE INSERT ON igra
FOR EACH ROW
BEGIN
    :NEW.cijena := :NEW.cijena * 1.1;
END;
/

-- postavlja vrstu animacije na "2D" ako je duljina manja od 5 minuta --
CREATE OR REPLACE TRIGGER trg_automatska_vrsta_animacije
BEFORE INSERT OR UPDATE ON animacija
FOR EACH ROW
BEGIN
    IF :NEW.duljina < 5 THEN
        :NEW.vrsta := '2D';
    END IF;
END;
/






















