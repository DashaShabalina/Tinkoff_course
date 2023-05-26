--заполнение таблицы проектов
do 
'
begin 
   FOR i in 1..30 LOOP
		INSERT INTO PROJECTS(ID, Name) VALUES (CAST(i AS varchar), 				CONCAT(''project'',i));
   END LOOP;
end;
';

--заполнение таблицы отделов
do 
'
begin 
   FOR i in 1..10 LOOP
		INSERT INTO DEPARTMENTS(ID, Name) VALUES (CAST(i AS varchar), 				CONCAT(''department'',i));
   END LOOP;
end;
';

--заполнение таблицы пользователей
CREATE TEMP TABLE Girls (
  id serial PRIMARY KEY, 
  name VARCHAR(40)
);
CREATE TEMP TABLE Men (
  id serial PRIMARY KEY, 
  name VARCHAR(40)
);
CREATE TEMP TABLE Surnames_Girls (
  id serial PRIMARY KEY, 
  surname VARCHAR(40)
);
CREATE TEMP TABLE Surnames_Men (
  id serial PRIMARY KEY, 
  surname VARCHAR(40)
);

INSERT INTO Girls(name) VALUES
('Дарья'), ('Марья'), ('Александра'), ('Валентина'),('Ксения'),
('София'),('Валерия'),('Виктория'),('Галина'),('Татьяна');
INSERT INTO Men(name) VALUES
('Юрий'),('Иван'),('Олег'),('Тимофей'),('Михаил'),
('Руслан'),('Роман'),('Александр'),('Лев'),('Евгений');
INSERT INTO Surnames_Girls(surname) VALUES
('Бабурина'),('Секрет'),('Петрова'),('Иванова'),('Тимошко');
INSERT INTO Surnames_Men(surname) VALUES
('Комлев'),('Семенов'),('Иванов'),('Петров'),('Данилкин');

do 
'
declare

begin 
   INSERT INTO USERS(ID, First_name, Last_name,Last_connection_date, Department_id, Active)
   SELECT ROW_NUMBER() over() as number, name, surname, now(), department, true FROM
   (
     SELECT Girls.name as name, surname, DEPARTMENTS.ID as department 
		FROM Girls CROSS JOIN Surnames_Girls CROSS JOIN DEPARTMENTS  
        	UNION ALL 
     SELECT Men.name as name, surname, DEPARTMENTS.ID as department 
        FROM Men CROSS JOIN Surnames_Men CROSS JOIN DEPARTMENTS
   )t
   ORDER BY RANDOM();
end;
';

DROP TABLE Girls;
DROP TABLE Men;
DROP TABLE Surnames_Girls;
DROP TABLE Surnames_Men;

--Заполнение таблицы для взаимосвязи пользователей с проектами
INSERT INTO USER_PROJECTS(User_id, Project_id)
Select USERS.ID, PROJECTS.ID FROM USERS CROSS JOIN PROJECTS
ORDER BY RANDOM()
LIMIT 50;

--Заполнение таблицы задач
CREATE TEMP TABLE Priorities (
  id serial PRIMARY KEY, 
  priority VARCHAR(40)
);
INSERT INTO Priorities(priority) VALUES
('Низкий'), ('Нормальный'), ('Высокий'), ('Срочный'),('Немедленный');

CREATE TEMP TABLE Sources (
  id serial PRIMARY KEY, 
  source VARCHAR(40)
);
INSERT INTO Sources(source) VALUES
('Заказчик'), ('Тестировщик'), ('Разработчик'), ('Сервисный отдел');

CREATE TEMP TABLE Types (
  id serial PRIMARY KEY, 
  type VARCHAR(40)
);
INSERT INTO Types(type) VALUES
('Bug'), ('Feature'), ('Документация'), ('Общие вопросы');

INSERT INTO TASKS(ID, Project_id, Number, Name, Description, Priority, Desig_emp, Resp_emp, Start_date, Source, Type)
Select ROW_NUMBER() over() as ID,
	   PROJECTS.ID,
       ROW_NUMBER() over() as Number, 
       CONCAT('task', ROW_NUMBER() over()) as Name,
       '...' as Description,
       priority,
       USERS.ID,
       USERS.ID,
       now(),
       source,
       type FROM USERS CROSS JOIN Priorities CROSS JOIN Sources CROSS JOIN Types CROSS JOIN PROJECTS
ORDER BY RANDOM()
LIMIT 300;

DROP TABLE Priorities;
DROP TABLE Sources;
DROP TABLE Types;