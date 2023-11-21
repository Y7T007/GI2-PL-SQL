/*==============================================================*/
/* Nom de SGBD :  ORACLE Version 11gXE                          */
/* Date de création :  07/11/2023                       		*/
/* OWNER :  M.YASSER                       						*/
/*==============================================================*/

DROP USER ensate CASCADE;
CREATE USER ensate IDENTIFIED BY ensate2020;
GRANT CONNECT, RESOURCE, DBA to ensate;

CONNECT ensate/ensate2020


/*==============================================================*/
/* Table : AVION                                                */
/*==============================================================*/

create table avion (
	Id_av		Number(5),
	Marque		varchar2(30) NOT NULL,
	Modele		varchar2(10) NOT NULL,
	Capacite	Number(3) NOT NULL,
	constraint pk_avion primary key (Id_av));

/*==============================================================*/
/* Table : PILOTE                                               */
/*==============================================================*/


create table pilote (
	Id_pil   number(3),
	Nom	        varchar2(50) NOT NULL,
	Age	        number(3) NOT NULL,
	ville       varchar2(25) NOT NULL,
	Salaire	    number(8,2) NOT NULL,
	Heure_vols	number(6) NULL,
	constraint pk_pilote primary key (Id_pil));


/*==============================================================*/
/* Table : PASSAGER                                             */
/*==============================================================*/

create table passager(
	Id_Pas		number(3),
	Nom		varchar2(25) NOT NULL,
	Age	        number(3) NOT NULL,
	ville       varchar2(25) NOT NULL,
	Heure_vols	number(6) NULL,
	constraint pk_passager primary key (Id_Pas));


/*==============================================================*/
/* Table : VOL                                                  */
/*==============================================================*/

create table vol(
	Id_vol          varchar2(8),
	Date_depart    date NOT NULL,
	Date_arrivee   date NOT NULL,
	ville_depart    varchar2(30) NOT NULL,
	ville_arrivee   varchar2(30) NOT NULL,
	N_Avion			Number(5) NOT NULL,
	N_Pilote 			number(3) NOT NULL,
	constraint pk_vol primary key (Id_vol),
	constraint fk_avion foreign key (N_Avion) references avion(Id_av),
	constraint fk_pilote foreign key (N_Pilote) references pilote(Id_pil));

/*==============================================================*/
/* Table : RESERVATION                                             */
/*==============================================================*/

  
    create table reservation(
	N_Vol		varchar2(8),
	N_Passager		number(3),
	date_res	date NOT NULL,
	constraint pk_reservation primary key (N_Vol, N_Passager),
	constraint fk_passager foreign key (N_Passager) references passager (Id_Pas),
	constraint fk_vol foreign key (N_Vol) references vol (Id_vol));

  
/*==============================================================*/
/* INSERTION DES DONNES                                         */
/*==============================================================*/



delete from avion;
insert into avion values (1, 'Airbus', 'A300', 259);
insert into avion values (2, 'Airbus', 'A310', 240);
insert into avion values (3, 'Airbus', 'A318', 110);
insert into avion values (4, 'Airbus', 'A321', 210);
insert into avion values (5, 'Airbus', 'A340', 250);
insert into avion values (6, 'Boeing', '707', 189);
insert into avion values (7, 'Boeing', '720', 149);
insert into avion values (8, 'Boeing', '737', 400);
insert into avion values (9, 'Boeing', '747', 416);
insert into avion values (10, 'Boeing', '767', 375);


delete from pilote;
insert into pilote values (1, 'TAHIRI YASSER',57,'RABAT', 120000.00, 28004);
insert into pilote values (2, 'MESMOUDI MOHAMED',45,'TANGER', 154000.00, 69020);
insert into pilote values (3, 'BAKALI TAHA',27,'CASABLANCA', 110000.00, 27130);
insert into pilote values (4, 'ALAMI MOUSSA',63,'AGADIR', 650000.00, 146290);
insert into pilote values (5, 'DOUGHMI IBRAHIM',32,'OUJDA', 425000.00, 98140);


delete from passager;
insert into passager values (1, 'MESMOUDI YASSER',48,'TETOUAN',127);
insert into passager values (2, 'DOLMI MOHAMED',27,'TANGER',204);
insert into passager values (3, 'TALI OMAR',32,'FES',366);
insert into passager values (4, 'TALEB MOUNA',18,'CASABLANCA',49);
insert into passager values (5, 'IDRISSI NOUR',26,'AGADIR',653);


delete from vol;

insert into vol values ('V101',TO_DATE('22/04/2008 09:53:00','DD/MM/YYYY HH:MI:SS'),
	TO_DATE('22/04/2008 10:53:00','DD/MM/YYYY HH:MI:SS'),'TANGER','AGADIR',1,2);

insert into vol values ('V102',TO_DATE('31/12/2009 08:00:00','DD/MM/YYYY HH:MI:SS'),
	TO_DATE('01/01/2010 10:53:00','DD/MM/YYYY HH:MI:SS'),'OUJDA','MARRAKECH',3,5);

insert into vol values ('V103',TO_DATE('14/03/2009 11:00:00','DD/MM/YYYY HH:MI:SS'),
	TO_DATE('14/03/2009 11:53:00','DD/MM/YYYY HH:MI:SS'),'RABAT','PARIS',2,1);

insert into vol values ('V104',TO_DATE('17/11/2010 06:15:00','DD/MM/YYYY HH:MI:SS'),
	TO_DATE('18/11/2010 10:53:00','DD/MM/YYYY HH:MI:SS'),'CASABLANCA','LOS ANGELES',10,3);

insert into vol values ('V105',TO_DATE('17/11/2020 01:25:00','DD/MM/YYYY HH:MI:SS'),
	TO_DATE('20/11/2020 02:15:00','DD/MM/YYYY HH:MI:SS'),'CASABLANCA','BEIJING',10,3);

commit;


