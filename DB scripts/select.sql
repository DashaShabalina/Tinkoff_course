--Запросы для проверки заполнения таблиц
--SELECT * FROM PROJECTS;
--SELECT * FROM DEPARTMENTS;
--SELECT * FROM USERS;
--SELECT * FROM USER_PROJECTS;
--SELECT * FROM TASKS;

--Получение всех задач назначенных на сотрудника
	--Из-за рандомного заполнения тяжело найти сотрудника наугад, поэтому для проверки взяла сотрудника, у которого есть минимум одна задача
SELECT Number, Name FROM USERS JOIN TASKS ON USERS.ID = TASKS.Desig_emp
WHERE USERS.ID = (SELECT Desig_emp FROM TASKS ORDER BY RANDOM() LIMIT 1);

--Задачи, которые пришли от заказчика
SELECT * FROM TASKS
WHERE Source = 'Заказчик';

--Количество задач каждого сотрудника
SELECT USERS.ID, First_name, Last_name, COUNT(TASKS.ID) as count FROM USERS LEFT JOIN TASKS ON USERS.ID = TASKS.Desig_emp
GROUP BY USERS.ID, First_name, Last_name
ORDER BY count DESC

--Сотрудники, у которых нет задач
SELECT USERS.ID, First_name, Last_name FROM USERS LEFT JOIN TASKS ON USERS.ID = TASKS.Desig_emp
WHERE TASKS.ID is NULL;