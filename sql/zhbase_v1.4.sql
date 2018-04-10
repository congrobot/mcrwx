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
insert into tb_user values (NULL, 0 ,'17779292763', '4798papu02144cbd_eff7516645bf709', 'zhadmin',3, 0, 'jiujiang', 2, "only a super user");

create table tb_machine
(
	machineid bigint auto_increment primary key,
	machinetype	varchar(64) not null,
	machinesubtype varchar(128),
	clearperiod bigint,
	constraint type_sub_uk unique(machinetype,machinesubtype)
);

create table tb_order
(
	orderid bigint auto_increment primary key,
	userid bigint not null,
	machinetype varchar(64) not null,
	machinesubtype varchar(128),
	setuptime bigint not null,
	lasttime bigint,
	constraint order_fk1 foreign key(userid) references tb_user(userid)
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
	articleimg varchar(256),
	author	varchar(64),
	description varchar(16),
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

CREATE TABLE captcha (
    captcha_id bigint(13) unsigned NOT NULL auto_increment,
    captcha_time int(10) unsigned NOT NULL,
    ip_address varchar(45) NOT NULL,
    word varchar(20) NOT NULL,
    PRIMARY KEY `captcha_id` (`captcha_id`),
    KEY `word` (`word`)
);

create table user (
  id int(11) not null auto_increment,
  nick_name varchar(50) not null,
  mobile_phone varchar(20) DEFAULT NULL,
  avatar_url varchar(200) DEFAULT NULL,
  status tinyint(4) not null DEFAULT 1,
  ctime datetime not null,
  utime datetime not null,
  PRIMARY KEY (id)
);

create table social_binder(
  id int(11) not null auto_increment,
  user_id int(11) not null,
  social_id varchar(50) not null,
  union_id varchar(50) DEFAULT null,
  bind_type tinyint(4) not null DEFAULT 1,
  status tinyint(4) not null DEFAULT 1,
  ctime datetime not null,
  utime datetime not null,
  PRIMARY KEY (id)
)