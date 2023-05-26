--Таблица проектов
-- ID - UUID проекта
-- Name - название 
-- Description - описание
-- Start_date - дата начала
-- End_date - дата завершения

CREATE TABLE PROJECTS (
	ID varchar(200) NOT NULL,
	Name varchar(50) NOT NULL UNIQUE,
	Description varchar(1000),
	Start_date TIMESTAMP,
	End_date TIMESTAMP,
	CONSTRAINT PROJECTS_pk PRIMARY KEY (ID)
);

--Таблица отделов
-- ID - UUID отдела
-- Name - название 
-- Description - описание

CREATE TABLE DEPARTMENTS (
	ID varchar(200) NOT NULL,
	Name varchar(50) NOT NULL,
	Description varchar(1000),
	CONSTRAINT DEPARTMENTS_pk PRIMARY KEY (ID)
);

--Таблица пользователей
-- ID - UUID пользователя
-- First_name  - имя 
-- Last_name - фамилия
-- Reg_date - дата регистрации в системе
-- Last_connection_date - дата последнего подключения в систему
-- Department_id - UUID отдела, в котором работает пользователь
-- Active - маркер работает ли пользователь в компании(true) или уволен(false)

CREATE TABLE USERS (
	ID varchar(200) NOT NULL,
	First_name varchar(50) NOT NULL,
	Last_name varchar(50) NOT NULL,
	Reg_date TIMESTAMP,
	Last_connection_date TIMESTAMP NOT NULL,
	Department_id varchar(255) NOT NULL,
	Active boolean NOT NULL,
	CONSTRAINT USERS_pk PRIMARY KEY (ID)
);

--Таблица для взаимосвязи пользователей с проектами
-- User_id - UUID пользователя
-- Project_id - UUID проекта 

CREATE TABLE USER_PROJECTS (
	User_id varchar(200) NOT NULL,
	Project_id varchar(200) NOT NULL,
	CONSTRAINT USER_PROJECTS_pk PRIMARY KEY (User_id,Project_id)
);

--Таблица задач
-- ID - UUID задачи
-- Project_id  - UUID проекта, к которому относится задача 
-- Number - номер задачи
-- Name - название
-- Description - описание
-- Priority - приоритет (срочный, высокий, низкий и т.д.)
-- Desig_emp - UUID пользователя, на которого назначена задача
-- Resp_emp - UUID пользователя ответственного за задачу
-- Start_date - дата начала
-- End_date - дата завершения
-- Labor_costs - оценка трудозатрат
-- Readness - готовность задачи в процентах
-- Source - источник задачи (тестировщик, заказчик, разработчик и т.д.)
-- Type - тип задачи (баг, фича и т.д.)

CREATE TABLE TASKS (
	ID varchar(200) NOT NULL,
	Project_id varchar(200) NOT NULL,
	Number varchar(200) NOT NULL UNIQUE,
	Name varchar(200) NOT NULL,
	Description varchar(1000) NOT NULL,
	Priority varchar(50) NOT NULL,
	Desig_emp varchar(200) NOT NULL,
	Resp_emp varchar(200),
	Start_date TIMESTAMP NOT NULL,
	End_date TIMESTAMP,
	Labor_costs real,
	Readness real,
	Source varchar(50) NOT NULL,
	Type varchar(50) NOT NULL,
	CONSTRAINT TASKS_pk PRIMARY KEY (ID)
);

ALTER TABLE USERS ADD CONSTRAINT USERS_fk0 FOREIGN KEY (Department_id) REFERENCES DEPARTMENTS(ID);

ALTER TABLE USER_PROJECTS ADD CONSTRAINT USER_PROJECTS_fk0 FOREIGN KEY (User_id) REFERENCES USERS(ID);
ALTER TABLE USER_PROJECTS ADD CONSTRAINT USER_PROJECTS_fk1 FOREIGN KEY (Project_id) REFERENCES PROJECTS(ID);

ALTER TABLE TASKS ADD CONSTRAINT TASKS_fk0 FOREIGN KEY (Project_id) REFERENCES PROJECTS(ID);
ALTER TABLE TASKS ADD CONSTRAINT TASKS_fk1 FOREIGN KEY (Desig_emp) REFERENCES USERS(ID);
ALTER TABLE TASKS ADD CONSTRAINT TASKS_fk2 FOREIGN KEY (Resp_emp) REFERENCES USERS(ID);