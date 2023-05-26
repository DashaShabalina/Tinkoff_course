--Назначить ответственного сотрудника за задачу
UPDATE TASKS SET Resp_emp = (SELECT ID FROM USERS ORDER BY RANDOM() LIMIT 1)
WHERE ID = (SELECT ID FROM TASKS ORDER BY ID DESC LIMIT 1);
--Проверка
--SELECT * FROM TASKS WHERE ID = (SELECT ID FROM TASKS ORDER BY ID DESC LIMIT 1);

--Всем задачам от заказчика поставить приоритет 'Срочный'
UPDATE TASKS SET Priority = 'Срочный'
WHERE Source = 'Заказчик';
--Проверка
--SELECT * FROM TASKS WHERE Source = 'Заказчик';

--Удалить задачу из системы
DELETE FROM TASKS
  WHERE ID = (SELECT ID FROM TASKS ORDER BY ID ASC LIMIT 1);