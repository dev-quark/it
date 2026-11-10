CREATE ROLE college_teacher NOLOGIN;
CREATE ROLE college_student NOLOGIN;
CREATE ROLE teacher_demo LOGIN IN ROLE college_teacher;
CREATE ROLE student_ivanov LOGIN IN ROLE college_student;
GRANT CONNECT ON DATABASE vershinin_bd TO college_teacher, college_student;
GRANT USAGE ON SCHEMA public TO college_teacher, college_student;
GRANT SELECT ON groups,students,teachers,disciplines,lessons TO college_teacher;
GRANT SELECT,INSERT,UPDATE ON grades TO college_teacher;
GRANT USAGE,SELECT ON SEQUENCE grades_grade_id_seq TO college_teacher;
CREATE VIEW my_grades AS
SELECT s.student_id,s.last_name,d.discipline_name,g.grade,g.grade_date
FROM students s JOIN grades g USING(student_id) JOIN disciplines d USING(discipline_id)
WHERE s.student_id=1;
GRANT SELECT ON my_grades TO college_student;
SET ROLE college_teacher;
SELECT COUNT(*) AS visible_students FROM students;
RESET ROLE;
SET ROLE college_student;
SELECT * FROM my_grades;
RESET ROLE;
