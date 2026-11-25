
CREATE DATABASE college_db;

USE college_db;

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    course_fee INT
);

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    city VARCHAR(50),
    course_id INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE results (
    result_id INT PRIMARY KEY,
    student_id INT,
    subject VARCHAR(50),
    marks INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);


INSERT INTO courses VALUES
(1, 'B.Tech', 100000),
(2, 'BCA', 60000),
(3, 'MCA', 80000),
(4, 'MBA', 90000);

INSERT INTO students VALUES
(101, 'Rahul', 'Lucknow', 1),
(102, 'Aman', 'Delhi', 1),
(103, 'Rohit', 'Kanpur', 2),
(104, 'Priya', 'Lucknow', 3),
(105, 'Neha', 'Noida', 4);

INSERT INTO results VALUES
(1, 101, 'Python', 85),
(2, 101, 'SQL', 90),
(3, 102, 'Python', 75),
(4, 102, 'SQL', 65),
(5, 103, 'Python', 80),
(6, 104, 'Python', 95),
(7, 104, 'SQL', 85);

--question 13
SELECT
    s.student_name,
    s.city,
    c.course_name,
    r.subject,
    r.marks
FROM students s
JOIN courses c
    ON s.course_id = c.course_id
LEFT JOIN results r
    ON s.student_id = r.student_id;


--question14

SELECT
    c.course_name,
    COUNT(DISTINCT s.student_id) AS total_students,
    AVG(r.marks) AS average_marks
FROM courses c
JOIN students s
    ON c.course_id = s.course_id
JOIN results r
    ON s.student_id = r.student_id
GROUP BY c.course_id, c.course_name
HAVING AVG(r.marks) > 70;

--question 15

WITH StudentAverage AS (
    SELECT
        s.student_id,
        s.student_name,
        s.course_id,
        AVG(r.marks) AS average_marks
    FROM students s
    JOIN results r
        ON s.student_id = r.student_id
    GROUP BY
        s.student_id,
        s.student_name,
        s.course_id
)

SELECT
    student_name,
    average_marks,
    RANK() OVER (
        PARTITION BY course_id
        ORDER BY average_marks DESC
    ) AS student_rank
FROM StudentAverage;
