BEGIN;
DO $$
BEGIN
    BEGIN
        INSERT INTO students(last_name,first_name,birth_date,group_id) VALUES ('Тест','Ошибка','2008-01-01',999);
        RAISE EXCEPTION 'Внешний ключ не работает';
    EXCEPTION WHEN foreign_key_violation THEN
        RAISE NOTICE 'Внешний ключ: ссылка на группу 999 отклонена';
    END;
END;
$$;
UPDATE groups SET group_id=101 WHERE group_id=1;
SELECT student_id,last_name,group_id FROM students WHERE group_id=101;
SELECT lesson_id,group_id FROM lessons WHERE group_id=101;
UPDATE groups SET group_id=1 WHERE group_id=101;
INSERT INTO groups(group_name,specialty,admission_year) VALUES ('ТЕСТ','Проверка удаления',2026);
INSERT INTO students(last_name,first_name,birth_date,group_id)
SELECT 'Удаляемый','Студент','2008-01-01',group_id FROM groups WHERE group_name='ТЕСТ';
DELETE FROM groups WHERE group_name='ТЕСТ';
SELECT COUNT(*) AS remaining_test_students FROM students WHERE last_name='Удаляемый';
ROLLBACK;
