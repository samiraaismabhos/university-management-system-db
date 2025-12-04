
DROP DATABASE IF EXISTS university_management;
CREATE DATABASE university_management;
USE university_management;

CREATE TABLE faculties (
    faculty_id   INT AUTO_INCREMENT PRIMARY KEY,
    faculty_name VARCHAR(100) NOT NULL,
    dean_name    VARCHAR(100),
    phone        VARCHAR(20)
);

CREATE TABLE departments (
    department_id   INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    faculty_id      INT,
    office_room     VARCHAR(50),
    FOREIGN KEY (faculty_id)
        REFERENCES faculties(faculty_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

CREATE TABLE semesters (
    semester_id   INT AUTO_INCREMENT PRIMARY KEY,
    semester_name VARCHAR(30) NOT NULL,
    start_date    DATE,
    end_date      DATE
);

CREATE TABLE classrooms (
    classroom_id INT AUTO_INCREMENT PRIMARY KEY,
    building     VARCHAR(50),
    room_number  VARCHAR(10),
    capacity     INT
);

CREATE TABLE students (
    student_id      INT AUTO_INCREMENT PRIMARY KEY,
    student_no      VARCHAR(20) NOT NULL UNIQUE,
    first_name      VARCHAR(50) NOT NULL,
    last_name       VARCHAR(50) NOT NULL,
    birth_date      DATE,
    gender          ENUM('F','M'),
    department_id   INT,
    enrollment_year INT,
    email           VARCHAR(100),
    phone           VARCHAR(20),
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

CREATE TABLE professors (
    professor_id  INT AUTO_INCREMENT PRIMARY KEY,
    first_name    VARCHAR(50) NOT NULL,
    last_name     VARCHAR(50) NOT NULL,
    title         VARCHAR(50),
    department_id INT,
    email         VARCHAR(100),
    phone         VARCHAR(20),
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

CREATE TABLE courses (
    course_id      INT AUTO_INCREMENT PRIMARY KEY,
    course_code    VARCHAR(20) NOT NULL UNIQUE,
    course_name    VARCHAR(100) NOT NULL,
    credits        INT NOT NULL,
    semester_hours INT,
    department_id  INT,
    professor_id   INT,
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    FOREIGN KEY (professor_id)
        REFERENCES professors(professor_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id    INT NOT NULL,
    course_id     INT NOT NULL,
    semester_id   INT NOT NULL,
    enroll_date   DATE,
    status        ENUM('ENROLLED','WITHDRAWN','COMPLETED') DEFAULT 'ENROLLED',
    UNIQUE(student_id, course_id, semester_id),
    FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (semester_id)
        REFERENCES semesters(semester_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE exams (
    exam_id      INT AUTO_INCREMENT PRIMARY KEY,
    course_id    INT NOT NULL,
    semester_id  INT NOT NULL,
    exam_type    ENUM('MIDTERM','FINAL','QUIZ') NOT NULL,
    exam_date    DATETIME NOT NULL,
    classroom_id INT,
    max_score    INT DEFAULT 100,
    FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (semester_id)
        REFERENCES semesters(semester_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (classroom_id)
        REFERENCES classrooms(classroom_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

CREATE TABLE exam_results (
    result_id        INT AUTO_INCREMENT PRIMARY KEY,
    exam_id          INT NOT NULL,
    student_id       INT NOT NULL,
    score            DECIMAL(5,2),
    grade_letter     CHAR(2),
    grade_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (exam_id)
        REFERENCES exams(exam_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    UNIQUE(exam_id, student_id)
);

CREATE TABLE roles (
    role_id   INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE users (
    user_id       INT AUTO_INCREMENT PRIMARY KEY,
    username      VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    student_id    INT,
    professor_id  INT,
    is_active     BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    FOREIGN KEY (professor_id)
        REFERENCES professors(professor_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

CREATE TABLE user_roles (
    user_id INT NOT NULL,
    role_id INT NOT NULL,
    PRIMARY KEY(user_id, role_id),
    FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (role_id)
        REFERENCES roles(role_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE exam_logs (
    log_id      INT AUTO_INCREMENT PRIMARY KEY,
    result_id   INT,
    exam_id     INT,
    student_id  INT,
    old_score   DECIMAL(5,2),
    new_score   DECIMAL(5,2),
    action_type VARCHAR(20),
    changed_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SHOW TABLES;
USE university_management;

-- Faculties
INSERT INTO faculties (faculty_name, dean_name, phone) VALUES
('Engineering Faculty', 'Dr. Kamran Aliyev', '+994501111111'),
('Computer Science Faculty', 'Dr. Leyla Mammadova', '+994502222222'),
('Business Faculty', 'Dr. Orxan Huseyn', '+994503333333');

-- Departments
INSERT INTO departments (department_name, faculty_id, office_room) VALUES
('Computer Engineering', 2, 'B-201'),
('Information Technology', 2, 'B-202'),
('Electrical Engineering', 1, 'E-101'),
('Mechanical Engineering', 1, 'M-301'),
('Business Administration', 3, 'BA-10'),
('Finance', 3, 'BA-11');

-- Semesters
INSERT INTO semesters (semester_name, start_date, end_date) VALUES
('Fall 2024', '2024-09-01', '2025-01-15'),
('Spring 2025', '2025-02-10', '2025-06-20'),
('Summer 2025', '2025-07-01', '2025-08-31');

-- Classrooms
INSERT INTO classrooms (building, room_number, capacity) VALUES
('Main', '101', 60),
('Main', '102', 40),
('Engineering', 'E201', 35),
('Engineering', 'E305', 45),
('Business', 'B110', 50);

-- Students
INSERT INTO students (student_no, first_name, last_name, birth_date, gender, department_id, enrollment_year, email, phone) VALUES
('CE2021001', 'Samira', 'Ismayilova', '2005-03-15', 'F', 1, 2021, 'samira.ismayilova@university.az', '+994501234001'),
('CE2021002', 'Murad',  'Aliyev',    '2004-06-21', 'M', 1, 2021, 'murad.aliyev@university.az',      '+994501234002'),
('IT2022001', 'Aysel', 'Mammadova',  '2005-09-09', 'F', 2, 2022, 'aysel.mammadova@university.az',    '+994501234003'),
('IT2022002', 'Elvin', 'Huseynov',   '2004-12-01', 'M', 2, 2022, 'elvin.huseynov@university.az',     '+994501234004'),
('EE2021001', 'Nigar', 'Tagiyeva',   '2003-11-30', 'F', 3, 2021, 'nigar.tagiyeva@university.az',     '+994501234005'),
('ME2021001', 'Rauf',  'Mehdiyev',   '2003-05-05', 'M', 4, 2021, 'rauf.mehdiyev@university.az',      '+994501234006'),
('BA2023001', 'Kamala','Aliyeva',    '2006-02-02', 'F', 5, 2023, 'kamala.aliyeva@university.az',     '+994501234007'),
('FN2023001', 'Tural', 'Gasimov',    '2006-08-18', 'M', 6, 2023, 'tural.gasimov@university.az',      '+994501234008');

-- Professors
INSERT INTO professors (first_name, last_name, title, department_id, email, phone) VALUES
('Nicat',  'Alizade',   'Assoc. Prof.', 1, 'nicat.alizade@university.az',     '+994501111001'),
('Sevinj', 'Aliyeva',   'Dr.',          1, 'sevinj.aliyeva@university.az',    '+994501111002'),
('Farid',  'Isayev',    'Prof.',        2, 'farid.isayev@university.az',      '+994501111003'),
('Nazim',  'Novruzov',  'Dr.',          3, 'nazim.novruzov@university.az',    '+994501111004'),
('Arzu',   'Mammadli',  'Lecturer',     5, 'arzu.mammadli@university.az',     '+994501111005'),
('Lale',   'Jafarova',  'Assoc. Prof.', 6, 'lale.jafarova@university.az',     '+994501111006');

-- Courses
INSERT INTO courses (course_code, course_name, credits, semester_hours, department_id, professor_id) VALUES
('CE101', 'Introduction to Programming', 6,  4, 1, 1),
('CE201', 'Data Structures',             6,  4, 1, 1),
('CE301', 'Database Systems',            6,  4, 1, 2),
('IT201', 'Computer Networks',           5,  3, 2, 3),
('EE201', 'Circuit Analysis',            5,  3, 3, 4),
('BA201', 'Principles of Management',    4,  3, 5, 5),
('FN201', 'Corporate Finance',           5,  3, 6, 6),
('CE401', 'Machine Learning',            6,  4, 1, 2);

-- Enrollments
INSERT INTO enrollments (student_id, course_id, semester_id, enroll_date, status) VALUES
(1, 1, 1, '2024-09-05', 'ENROLLED'),
(1, 3, 1, '2024-09-05', 'ENROLLED'),
(2, 1, 1, '2024-09-06', 'ENROLLED'),
(2, 2, 1, '2024-09-06', 'ENROLLED'),
(3, 4, 1, '2024-09-07', 'ENROLLED'),
(4, 4, 1, '2024-09-07', 'ENROLLED'),
(5, 5, 1, '2024-09-08', 'ENROLLED'),
(7, 6, 1, '2024-09-09', 'ENROLLED'),
(8, 7, 1, '2024-09-09', 'ENROLLED'),
(1, 8, 2, '2025-02-15', 'ENROLLED');

-- Exams
INSERT INTO exams (course_id, semester_id, exam_type, exam_date, classroom_id, max_score) VALUES
(1, 1, 'MIDTERM', '2024-11-01 10:00:00', 1, 100),
(1, 1, 'FINAL',   '2025-01-05 14:00:00', 1, 100),
(3, 1, 'MIDTERM', '2024-11-10 09:00:00', 2, 100),
(3, 1, 'FINAL',   '2025-01-10 13:00:00', 2, 100),
(8, 2, 'MIDTERM', '2025-04-05 11:00:00', 3, 100),
(8, 2, 'FINAL',   '2025-06-10 15:00:00', 3, 100);

-- Roles & Users
INSERT INTO roles (role_name) VALUES
('STUDENT'),
('PROFESSOR'),
('ADMIN');

INSERT INTO users (username, password_hash, student_id, professor_id, is_active) VALUES
('samira', 'hashed_password_1', 1, NULL, TRUE),
('murad',  'hashed_password_2', 2, NULL, TRUE),
('nicat',  'hashed_password_3', NULL, 1, TRUE),
('sevinj', 'hashed_password_4', NULL, 2, TRUE);

INSERT INTO user_roles (user_id, role_id) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(3, 3);

SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM enrollments;
USE university_management;
DELIMITER $$

-- FUNCTIONS
CREATE FUNCTION fn_student_age(p_student_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_age INT;
    SELECT TIMESTAMPDIFF(YEAR, birth_date, CURDATE())
    INTO v_age
    FROM students
    WHERE student_id = p_student_id;
    RETURN v_age;
END$$

CREATE FUNCTION fn_course_enrollment_count(p_course_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_cnt INT;
    SELECT COUNT(*)
    INTO v_cnt
    FROM enrollments
    WHERE course_id = p_course_id;
    RETURN v_cnt;
END$$

CREATE FUNCTION fn_student_gpa(p_student_id INT)
RETURNS DECIMAL(4,2)
DETERMINISTIC
BEGIN
    DECLARE v_gpa DECIMAL(4,2);
    SELECT 
        CASE 
            WHEN COUNT(*) = 0 THEN NULL
            ELSE ROUND(AVG(score) / 25, 2)
        END
    INTO v_gpa
    FROM exam_results
    WHERE student_id = p_student_id;
    RETURN v_gpa;
END$$


-- PROCEDURES
CREATE PROCEDURE sp_add_student (
    IN p_student_no      VARCHAR(20),
    IN p_first_name      VARCHAR(50),
    IN p_last_name       VARCHAR(50),
    IN p_birth_date      DATE,
    IN p_gender          CHAR(1),
    IN p_department_id   INT,
    IN p_enrollment_year INT,
    IN p_email           VARCHAR(100),
    IN p_phone           VARCHAR(20)
)
BEGIN
    INSERT INTO students
        (student_no, first_name, last_name, birth_date, gender, department_id, enrollment_year, email, phone)
    VALUES
        (p_student_no, p_first_name, p_last_name, p_birth_date, p_gender, p_department_id, p_enrollment_year, p_email, p_phone);
END$$

CREATE PROCEDURE sp_enroll_student (
    IN p_student_id  INT,
    IN p_course_id   INT,
    IN p_semester_id INT,
    IN p_enroll_date DATE
)
BEGIN
    INSERT IGNORE INTO enrollments (student_id, course_id, semester_id, enroll_date, status)
    VALUES (p_student_id, p_course_id, p_semester_id, p_enroll_date, 'ENROLLED');
END$$

CREATE PROCEDURE sp_update_exam_score (
    IN p_exam_id    INT,
    IN p_student_id INT,
    IN p_new_score  DECIMAL(5,2)
)
BEGIN
    UPDATE exam_results
    SET score = p_new_score
    WHERE exam_id = p_exam_id
      AND student_id = p_student_id;
END$$

CREATE PROCEDURE sp_get_student_transcript (
    IN p_student_id INT
)
BEGIN
    SELECT 
        s.student_no,
        s.first_name,
        s.last_name,
        c.course_code,
        c.course_name,
        e.exam_type,
        er.score,
        er.grade_letter,
        sem.semester_name
    FROM exam_results er
    JOIN exams e       ON er.exam_id = e.exam_id
    JOIN courses c     ON e.course_id = c.course_id
    JOIN students s    ON er.student_id = s.student_id
    JOIN semesters sem ON e.semester_id = sem.semester_id
    WHERE er.student_id = p_student_id
    ORDER BY sem.start_date, c.course_code, e.exam_type;
END$$

CREATE PROCEDURE sp_get_department_courses (
    IN p_department_id INT
)
BEGIN
    SELECT 
        d.department_name,
        c.course_code,
        c.course_name,
        c.credits,
        CONCAT(p.first_name, ' ', p.last_name) AS professor_name
    FROM courses c
    JOIN departments d ON c.department_id = d.department_id
    LEFT JOIN professors p ON c.professor_id = p.professor_id
    WHERE c.department_id = p_department_id;
END$$

DELIMITER ;

SELECT fn_student_age(1);

CALL sp_get_department_courses(1);

USE university_management;
DELIMITER $$

CREATE TRIGGER trg_exam_results_before_insert
BEFORE INSERT ON exam_results
FOR EACH ROW
BEGIN
    IF NEW.score IS NOT NULL THEN
        IF NEW.score >= 90 THEN
            SET NEW.grade_letter = 'A';
        ELSEIF NEW.score >= 80 THEN
            SET NEW.grade_letter = 'B';
        ELSEIF NEW.score >= 70 THEN
            SET NEW.grade_letter = 'C';
        ELSEIF NEW.score >= 60 THEN
            SET NEW.grade_letter = 'D';
        ELSE
            SET NEW.grade_letter = 'F';
        END IF;
    END IF;
END$$

CREATE TRIGGER trg_exam_results_before_update
BEFORE UPDATE ON exam_results
FOR EACH ROW
BEGIN
    IF OLD.score <> NEW.score THEN
        INSERT INTO exam_logs (result_id, exam_id, student_id, old_score, new_score, action_type, changed_at)
        VALUES (OLD.result_id, OLD.exam_id, OLD.student_id, OLD.score, NEW.score, 'UPDATE', NOW());
    END IF;
END$$

CREATE TRIGGER trg_exam_results_after_insert
AFTER INSERT ON exam_results
FOR EACH ROW
BEGIN
    INSERT INTO exam_logs (result_id, exam_id, student_id, old_score, new_score, action_type, changed_at)
    VALUES (NEW.result_id, NEW.exam_id, NEW.student_id, NULL, NEW.score, 'INSERT', NOW());
END$$

DELIMITER ;
USE university_management;

INSERT INTO exam_results (exam_id, student_id, score, grade_letter) VALUES
(1, 1, 95.00, NULL),
(1, 2, 78.50, NULL),
(2, 1, 92.00, NULL),
(3, 1, 88.00, NULL),
(3, 2, 81.00, NULL),
(4, 1, 90.00, NULL),
(5, 1, 85.00, NULL);

SELECT * FROM exam_results;
SELECT * FROM exam_logs;

USE university_management;

-- CTE 1: tələbələrin orta balı
WITH student_avg AS (
    SELECT 
        er.student_id,
        s.first_name,
        s.last_name,
        ROUND(AVG(er.score), 2) AS avg_score
    FROM exam_results er
    JOIN students s ON er.student_id = s.student_id
    GROUP BY er.student_id, s.first_name, s.last_name
)
SELECT * FROM student_avg;

-- CTE 2: fakültə üzrə tələbə sayı
WITH dept_counts AS (
    SELECT 
        f.faculty_id,
        f.faculty_name,
        COUNT(s.student_id) AS student_count
    FROM faculties f
    LEFT JOIN departments d ON f.faculty_id = d.faculty_id
    LEFT JOIN students s    ON d.department_id = s.department_id
    GROUP BY f.faculty_id, f.faculty_name
)
SELECT * FROM dept_counts;

-- CTE 3: kurslar üzrə orta bal
WITH course_avg AS (
    SELECT 
        c.course_id,
        c.course_code,
        c.course_name,
        ROUND(AVG(er.score), 2) AS avg_score
    FROM courses c
    JOIN exams e ON c.course_id = e.course_id
    JOIN exam_results er ON e.exam_id = er.exam_id
    GROUP BY c.course_id, c.course_code, c.course_name
)
SELECT * FROM course_avg;

-- TEMP TABLE: top tələbələr
DROP TEMPORARY TABLE IF EXISTS temp_top_students;

CREATE TEMPORARY TABLE temp_top_students AS
SELECT 
    er.student_id,
    s.first_name,
    s.last_name,
    ROUND(AVG(er.score), 2) AS avg_score
FROM exam_results er
JOIN students s ON er.student_id = s.student_id
GROUP BY er.student_id, s.first_name, s.last_name
ORDER BY avg_score DESC
LIMIT 5;

SELECT * FROM temp_top_students;
-- 1) JOIN: tələbə + kurs + semestr
SELECT 
    s.student_no,
    s.first_name,
    s.last_name,
    c.course_code,
    c.course_name,
    sem.semester_name
FROM enrollments en
JOIN students s  ON en.student_id = s.student_id
JOIN courses c   ON en.course_id = c.course_id
JOIN semesters sem ON en.semester_id = sem.semester_id;

-- 2) GROUP BY + HAVING
SELECT 
    c.course_code,
    c.course_name,
    COUNT(en.student_id) AS student_count
FROM courses c
JOIN enrollments en ON c.course_id = en.course_id
GROUP BY c.course_code, c.course_name
HAVING COUNT(en.student_id) > 1;

-- 3) SUBQUERY: orta balı 85-dən yüksək olan tələbələr
SELECT *
FROM students
WHERE student_id IN (
    SELECT er.student_id
    FROM exam_results er
    GROUP BY er.student_id
    HAVING AVG(er.score) > 85
);

-- 4) Aggregation: fakültə üzrə tələbə sayı
SELECT 
    f.faculty_name,
    COUNT(s.student_id) AS total_students
FROM faculties f
LEFT JOIN departments d ON f.faculty_id = d.faculty_id
LEFT JOIN students s    ON d.department_id = s.department_id
GROUP BY f.faculty_name;

-- 5) Functions istifadə
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    fn_student_age(s.student_id)   AS age,
    fn_student_gpa(s.student_id)   AS gpa
FROM students s;

