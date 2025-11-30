-- List all students with departments
SELECT s.student_no, s.first_name, s.last_name, d.department_name
FROM students s
JOIN departments d ON s.department_id = d.department_id;

-- Count students per faculty
SELECT f.faculty_name, COUNT(s.student_id) AS total_students
FROM faculties f
LEFT JOIN departments d ON f.faculty_id = d.faculty_id
LEFT JOIN students s ON s.department_id = d.department_id
GROUP BY f.faculty_name;

-- Courses taken by a specific student
SELECT s.first_name, s.last_name, c.course_name, sem.semester_name
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON c.course_id = e.course_id
JOIN semesters sem ON sem.semester_id = e.semester_id
WHERE s.student_no = '20230001';

