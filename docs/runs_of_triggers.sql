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
