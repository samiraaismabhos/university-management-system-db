USE university_management;

INSERT IGNORE INTO faculties (faculty_name, dean_name, phone) VALUES
('Engineering Faculty',      'Dr. Rashad Aliyev',   '+994501111111'),
('Information Technology',   'Assoc. Prof. Nigar M', '+994502222222'),
('Business and Management',  'Prof. Elvin Quliyev', '+994503333333');

INSERT IGNORE INTO departments (department_name, faculty_id, office_room) VALUES
('Computer Engineering',     1, 'ENG-201'),
('Electrical Engineering',   1, 'ENG-305'),
('Information Security',     2, 'IT-110'),
('Computer Science',         2, 'IT-210'),
('Business Administration',  3, 'BUS-101');

INSERT IGNORE INTO semesters (semester_name, start_date, end_date) VALUES
('Fall 2025',  '2025-09-15', '2025-12-30'),
('Spring 2026','2026-02-10', '2026-06-10');

INSERT IGNORE INTO classrooms (building, room_number, capacity) VALUES
('ENG',  '101', 40),
('ENG',  '202', 30),
('IT',   '305', 35),
('MAIN', 'A1',  100);

INSERT IGNORE INTO roles (role_name) VALUES
('ADMIN'),
('STUDENT'),
('PROFESSOR');

INSERT IGNORE INTO students 
    (student_no, first_name, last_name, birth_date, gender, department_id, enrollment_year, email, phone)
VALUES
('BHOS2022001', 'Samira', 'Ismayilova', '2005-03-15', 'F', 1, 2022, 'samira.ismayilova@bhos.edu.az', '+994501234001'),
('BHOS2021002', 'Ferid',  'Aliyev',     '2004-11-02', 'M', 1, 2021, 'ferid.aliyev@bhos.edu.az',      '+994501234002'),
('BHOS2022003', 'Aylin',  'Huseynova',  '2005-06-10', 'F', 3, 2022, 'aylin.huseynova@bhos.edu.az',   '+994501234003'),
('BHOS2020004', 'Murad',  'Qurbanov',   '2003-09-25', 'M', 4, 2020, 'murad.qurbanov@bhos.edu.az',    '+994501234004'),
('BHOS2023005', 'Nermin', 'Mahmudova',  '2006-01-20', 'F', 5, 2023, 'nermin.mahmudova@bhos.edu.az',  '+994501234005');

INSERT IGNORE INTO professors 
    (first_name, last_name, title, department_id, email, phone)
VALUES
('Abid',  'Karimli',  'Assoc. Prof.', 1, 'abid.karimli@bhos.edu.az',   '+994501111001'),
('Nigar', 'Aliyeva',  'Dr.',          3, 'nigar.aliyeva@bhos.edu.az',  '+994501111002'),
('Ilqar', 'Mammadov','Prof.',        2, 'ilqar.mammadov@bhos.edu.az', '+994501111003'),
('Leyla', 'Hajiyeva','Dr.',          4, 'leyla.hajiyeva@bhos.edu.az', '+994501111004');

INSERT IGNORE INTO courses 
    (course_code, course_name, credits, semester_hours, department_id, professor_id)
VALUES
('CE101',   'Introduction to Programming', 6, 4, 1, 1),
('CE201',   'Database Systems',            6, 3, 1, 1),
('EE101',   'Circuit Analysis',            5, 3, 2, 3),
('IS101',   'Information Security Basics', 5, 3, 3, 2),
('CS201',   'Data Structures',             6, 3, 4, 4);

INSERT IGNORE INTO users
    (username, password_hash, student_id, professor_id, is_active)
VALUES
('admin1',  'admin_pass_hash',  NULL, NULL, TRUE),
('samira',  'samira_pass_hash', 1,    NULL, TRUE),
('abidk',   'abid_pass_hash',   NULL, 1,    TRUE),
('aylin',   'aylin_pass_hash',  3,    NULL, TRUE);

INSERT IGNORE INTO user_roles (user_id, role_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 2);

INSERT IGNORE INTO enrollments
    (student_id, course_id, semester_id, enroll_date, status)
VALUES
(1, 1, 1, '2025-09-20', 'ENROLLED'),
(1, 2, 1, '2025-09-20', 'ENROLLED'),
(2, 1, 1, '2025-09-18', 'ENROLLED'),
(3, 4, 1, '2025-09-22', 'ENROLLED'),
(4, 3, 1, '2025-09-19', 'ENROLLED'),
(5, 5, 1, '2025-09-21', 'ENROLLED');

INSERT IGNORE INTO exams
    (course_id, semester_id, exam_type, exam_date, classroom_id, max_score)
VALUES
(1, 1, 'MIDTERM', '2025-10-30 10:00:00', 1, 100),
(1, 1, 'FINAL',   '2025-12-20 10:00:00', 1, 100),
(2, 1, 'FINAL',   '2025-12-22 14:00:00', 2, 100),
(3, 1, 'FINAL',   '2025-12-25 09:00:00', 2, 100),
(4, 1, 'FINAL',   '2025-12-26 11:00:00', 3, 100);

INSERT IGNORE INTO exam_results
    (exam_id, student_id, score, grade_letter)
VALUES
(1, 1, 95.0, 'A'),
(2, 1, 90.0, 'A'),
(1, 2, 75.0, 'C'),
(2, 2, 80.0, 'B'),
(3, 1, 88.0, 'B'),
(4, 4, 70.0, 'C'),
(5, 3, 92.0, 'A');
SELECT COUNT(*) AS students_count FROM students;
SELECT COUNT(*) AS courses_count  FROM courses;
SELECT COUNT(*) AS exams_count    FROM exam_results;

SELECT 
    s.student_id,
    s.student_no,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    d.department_name,
    f.faculty_name,
    s.enrollment_year
FROM students s
LEFT JOIN departments d ON s.department_id = d.department_id
LEFT JOIN faculties  f ON d.faculty_id = f.faculty_id;


SELECT 
    c.course_id,
    c.course_code,
    c.course_name,
    c.credits,
    CONCAT(p.first_name, ' ', p.last_name) AS professor_name,
    d.department_name
FROM courses c
LEFT JOIN professors p ON c.professor_id  = p.professor_id
LEFT JOIN departments d ON c.department_id = d.department_id;


SELECT
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    sem.semester_name,
    c.course_code,
    c.course_name,
    e.enroll_date,
    e.status
FROM enrollments e
JOIN students s   ON e.student_id  = s.student_id
JOIN courses c    ON e.course_id   = c.course_id
JOIN semesters sem ON e.semester_id = sem.semester_id
WHERE sem.semester_name = 'Fall 2025';


SELECT 
    c.course_code,
    c.course_name
FROM courses c
WHERE c.course_id IN (
    SELECT e.course_id
    FROM enrollments e
    JOIN students s ON e.student_id = s.student_id
    WHERE s.first_name = 'Samira'
      AND s.last_name  = 'Ismayilova'
);


SELECT 
    c.course_code,
    c.course_name,
    AVG(er.score) AS average_score
FROM exam_results er
JOIN exams ex ON er.exam_id = ex.exam_id
JOIN courses c ON ex.course_id = c.course_id
GROUP BY c.course_id, c.course_code, c.course_name;


SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    AVG(er.score) AS avg_score
FROM exam_results er
JOIN students s ON er.student_id = s.student_id
GROUP BY s.student_id, student_name
ORDER BY avg_score DESC;

WITH student_avg AS (
    SELECT
        s.student_id,
        CONCAT(s.first_name, ' ', s.last_name) AS student_name,
        AVG(er.score) AS avg_score
    FROM exam_results er
    JOIN students s ON er.student_id = s.student_id
    GROUP BY s.student_id, student_name
)
SELECT
    student_id,
    student_name,
    avg_score
FROM student_avg
WHERE avg_score >= 80
ORDER BY avg_score DESC;

WITH samira_course_avg AS (
    SELECT
        c.course_code,
        c.course_name,
        AVG(er.score) AS avg_score
    FROM exam_results er
    JOIN exams ex   ON er.exam_id   = ex.exam_id
    JOIN courses c  ON ex.course_id = c.course_id
    JOIN students s ON er.student_id = s.student_id
    WHERE s.first_name = 'Samira'
      AND s.last_name  = 'Ismayilova'
    GROUP BY c.course_code, c.course_name
)
SELECT
    course_code,
    course_name,
    avg_score
FROM samira_course_avg;

DROP TEMPORARY TABLE IF EXISTS course_exam_stats;

CREATE TEMPORARY TABLE course_exam_stats AS
SELECT 
    c.course_id,
    c.course_code,
    c.course_name,
    COUNT(er.result_id) AS exam_result_count,
    AVG(er.score) AS avg_score
FROM exam_results er
JOIN exams  ex ON er.exam_id  = ex.exam_id
JOIN courses c ON ex.course_id = c.course_id
GROUP BY c.course_id, c.course_code, c.course_name;

SELECT * FROM course_exam_stats ORDER BY avg_score DESC;

USE university_management;

DROP FUNCTION IF EXISTS get_student_fullname;

DELIMITER $$

CREATE FUNCTION get_student_fullname(stu_id INT)
RETURNS VARCHAR(200)
DETERMINISTIC
BEGIN
    DECLARE full_name VARCHAR(200);
    SELECT CONCAT(first_name, ' ', last_name)
    INTO full_name
    FROM students
    WHERE student_id = stu_id;
    RETURN full_name;
END $$

DELIMITER ;
SELECT get_student_fullname(1);

-------
DROP FUNCTION IF EXISTS get_course_average;

DELIMITER $$

CREATE FUNCTION get_course_average(courseId INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE avg_score DECIMAL(5,2);

    SELECT AVG(er.score)
    INTO avg_score
    FROM exam_results er
    JOIN exams ex ON er.exam_id = ex.exam_id
    WHERE ex.course_id = courseId;

    RETURN avg_score;
END $$

DELIMITER ;
SELECT get_course_average(1);


-------
DROP FUNCTION IF EXISTS get_student_average;

DELIMITER $$

CREATE FUNCTION get_student_average(stu_id INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE avg_score DECIMAL(5,2);

    SELECT AVG(score)
    INTO avg_score
    FROM exam_results
    WHERE student_id = stu_id;

    RETURN avg_score;
END $$

DELIMITER ;
SELECT get_student_average(1);

-------------
