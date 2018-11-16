/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  Nelson
 * Created: 30/05/2018
 */

create table USERS
(
    ID INT not null primary key GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1), 
    USERNAME VARCHAR(100) not null,
    EMAIL VARCHAR(100) not null,
    PASSWORD VARCHAR(100) not null,
    QUESTION VARCHAR(100) not null,
    ANSWER VARCHAR(100) not null,
    PROFILE BLOB(2147483647),
    COVER BLOB(2147483647),
    BIRTHDATE VARCHAR(15),
    GENDER VARCHAR(10),
    COUNTRY VARCHAR(50),
    CITY VARCHAR(50)
)

create table VIDEOS
(
    ID INT not null primary key GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    USERID INTEGER not null,
    TITLE VARCHAR(50) not null,
    DESCRIPTION VARCHAR(1337),
    CATEGORY1 VARCHAR(20) not null,
    CATEGORY2 VARCHAR(20),
    CATEGORY3 VARCHAR(20),
    IMAGE BLOB(2147483647) not null,
    RESTRICTED BOOLEAN not null,
    UPLOADED DATE not null,
    REPRODUCTIONS INTEGER default 0 not null,
    LIKES INTEGER default 0 not null,
    FAVORITES INTEGER default 0 not null,
    DIR VARCHAR(256) default 'HUUUUH' not null
)

create table REPORTS
(
    ID INT not null primary key GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    VIDEOID INTEGER not null,
    UPLOADERID INTEGER not null,
    REPORTERID INTEGER not null,
    REASON VARCHAR(40) not null
)

create table LIKES
(
    ID INT not null primary key GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    VIDEOID INTEGER not null,
    USERID INTEGER not null
)

create table FOLLOWS
(
    ID INT not null primary key GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    FOLLOWING INTEGER not null,
    FOLLOWER INTEGER not null
)

create table FAVORITES
(
    ID INT not null primary key GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    VIDEOID INTEGER not null,
    USERID INTEGER not null
)

create table COMMENTS
(
    ID INT not null primary key GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    VIDEOID INTEGER not null,
    USERID INTEGER not null,
    ANAME VARCHAR(100),
    AMAIL VARCHAR(100),
    COMMENT VARCHAR(256) not null,
    WRITTEN VARCHAR(25)
)

create table CATEGORIES
(
    ID INT not null primary key GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    COLOR VARCHAR(10) not null,
    POS INTEGER not null,
    CATNAME VARCHAR(20)
)

create table BANNEDVIDEOS
(
    ID INT not null primary key GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    VIDEOID INTEGER not null,
    REASON VARCHAR(40) not null
)

create table BANNEDUSERS
(
    ID INT not null primary key GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    USERID INTEGER not null,
    PERMANENT BOOLEAN not null,
    EXPIRES DATE,
    REASON VARCHAR(40) not null,
    DETAILS VARCHAR(256)
)