drop database if exists zhbase;
create database zhbase character set utf8 collate utf8_general_ci;
use zhbase;

create table tb_role
(
	roleid bigint auto_increment primary key,
	name varchar(32) not null,
	remark varchar(256)
);
insert into tb_role values (NULL, 'user', 'ordinary user');
insert into tb_role values (NULL, 'super', 'super role');

create table tb_gender
(
	genderid bigint auto_increment primary key,
	name varchar(16) not null
);
insert into tb_gender values (NULL, 'UNKNOWN');
insert into tb_gender values (NULL, 'MALE');
insert into tb_gender values (NULL, 'FEMALE');

create table tb_user
(
	userid bigint auto_increment primary key,
	createtime bigint not null,
	telnum bigint not null,
	passwd varchar(32) not null,
	username varchar(64) not null,
	genderid bigint default 1,
	birthday bigint not null,
	address varchar(256) not null,
	roleid bigint default 1,
	remark varchar(256),
	unique(telnum),
	constraint user_fk1 foreign key(genderid) references tb_gender(genderid),
	constraint user_fk2 foreign key(roleid) references tb_role(roleid)
);
insert into tb_user values (NULL, 0 ,'17779292763', 'zhpasswd123', 'zhadmin',3, 0, 'jiujiang', 2, "only a super user");

create table tb_machine
(
	machineid bigint auto_increment primary key,
	name varchar(128) not null,
	machinetype	varchar(64) not null,
	machinesubtype varchar(128),
	machineimg longblob not null,
	clearperiod bigint
);

create table tb_order
(
	orderid bigint auto_increment primary key,
	userid bigint not null,
	machineid bigint not null,
	setuptime bigint not null,
	lasttime bigint,
	constraint order_fk1 foreign key(userid) references tb_user(userid),
	constraint order_fk2 foreign key(machineid) references tb_machine(machineid)
);

create table tb_articletype
(
	typeid bigint auto_increment primary key,
	name varchar(64) not null
);
insert into tb_articletype values (NULL, 'water heater');
insert into tb_articletype values (NULL, 'water heater sub');
insert into tb_articletype values (NULL, 'central air-conditioning');
insert into tb_articletype values (NULL, 'central air-conditioning sub');
insert into tb_articletype values (NULL, 'wall hanging stove');
insert into tb_articletype values (NULL, 'wall hanging stove sub');
insert into tb_articletype values (NULL, 'video');
insert into tb_articletype values (NULL, 'video sub');
insert into tb_articletype values (NULL, 'problem');
insert into tb_articletype values (NULL, 'problem sub');
insert into tb_articletype values (NULL, 'activity');
insert into tb_articletype values (NULL, 'activity sub');
insert into tb_articletype values (NULL, 'learning');
insert into tb_articletype values (NULL, 'learning sub');
insert into tb_articletype values (NULL, 'lottery');
insert into tb_articletype values (NULL, 'lottery sub');

create table tb_article
(
	articleid bigint auto_increment primary key,
	name varchar(128) not null,
	typeid	bigint not null,
	articleimg longblob,
	author	varchar(64),
	content varchar(4096) not null,
	createtime bigint not null,
	updatetime bigint not null,
	views bigint default 0,
	likes bigint default 0
);

create table tb_report
(
	reportid bigint auto_increment primary key,
	who	varchar(64) not null,
	content varchar(128) not null,
	description varchar(256) not null,
	evidenceimg longblob not null 
);