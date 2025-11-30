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
    result_id       INT AUTO_INCREMENT PRIMARY KEY,
    exam_id         INT NOT NULL,
    student_id      INT NOT NULL,
    score           DECIMAL(5,2),
    grade_letter    CHAR(2),
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
