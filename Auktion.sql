

create database auktion;
use auktion;

create table if not exists kund(
        personnummer char(12) not null,
        efternamn nvarchar(30) not null,
        förnamn nvarchar(30) not null,
        gatuadress varchar(50) not null,
        postnummer char(5) not null,
        ort varchar(30) not null,
        telefon varchar(30),
        epost varchar(100) not null,
        primary key (personnummer)
);
CREATE INDEX ixkundNamn ON kund(efternamn); 

drop table if exists kategori;
create table kategori(
        kategoriId int AUTO_INCREMENT not null,
        namn varchar(50) not null,
        primary key (kategoriId)
);

drop table if exists leverantör;
create table leverantör(
    leverantörId int auto_increment not null,
    namn varchar(30),
    epost varchar(100),
    telefon varchar(30),
    gatuadress varchar(50),
    postnummer char(5),
    ort varchar(30),
    provisionsnivå float(3),
    primary key (leverantörId)
);

drop table if exists produkt;
create table produkt(
    produktId int not null AUTO_INCREMENT,
    namn varchar(50) not null,
    beskrivning VARCHAR(150),
    inpris int,
    kategoriId int,
    leverantörId int,
    primary key (produktId),
    foreign key (kategoriId) references kategori(kategoriId),
    foreign key (leverantörId) references leverantör(leverantörId) 
);
CREATE INDEX ixproduktNamn ON produkt(namn); 

drop table if exists auktion;
create table if not exists auktion(
    auktionId int not null auto_increment,
    produktId int,
    acceptpris int,
    `start` datetime,
    slut datetime, 
    slutpris int,
    primary key (auktionId),
    foreign key (produktId) references produkt(produktId)
);

drop table if exists bud;
create table if not exists bud(
    budId int not null auto_increment,
    timestamp datetime,
    kundId char(12) not null,
    auktionId int not null,
    belopp int not null,
    primary key (budId),
    foreign key (kundId) references kund(personnummer),
    foreign key (auktionId) references auktion(auktionId)
);

drop table if exists auktionhistorik;
create table auktionhistorik(
    auktionId int not null,
    acceptpris int,
    `start` datetime,
    slut datetime, 
    slutpris int,
    vinnandebudId int,
    primary key (auktionId),
    foreign key (vinnandebudId) references bud(budId)
);  