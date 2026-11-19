
-- Task 9: Create Tables

-- 1. Students
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    city VARCHAR(30)
);

-- 2. Courses
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    max_seats INT NOT NULL CHECK (max_seats > 0)
);

-- 3. Enrollments
CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    enrolled_on DATE DEFAULT CURRENT_DATE,
    grade INT CHECK (grade BETWEEN 0 AND 100),

    PRIMARY KEY (student_id, course_id),

    FOREIGN KEY (student_id)
        REFERENCES Students(student_id),

    FOREIGN KEY (course_id)
        REFERENCES Courses(course_id)
);
-- Task 10: Insert Data
INSERT INTO students (student_id, full_name, email, city) VALUES
(1, 'Dana Levi', 'dana@mail.com', 'Haifa'),
(2, 'Yossi Cohen', 'yossi@mail.com', 'Tel Aviv'),
(3, 'Noa Ben-David', 'noa@mail.com', 'Haifa'),
(4, 'Omer Katz', 'omer@mail.com', 'Eilat'),
(5, 'Lior Shalom', 'lior@mail.com', 'Tel Aviv'),
(6, 'Tamar Green', 'tamar@mail.com', 'Jerusalem');

INSERT INTO courses (course_id, title, max_seats) VALUES
(1, 'SQL Basics', 20),
(2, 'Python', 15),
(3, 'Data Modeling', 10),
(4, 'JavaScript', 2);

INSERT INTO enrollments (student_id, course_id, enrolled_on, grade) VALUES
(1, 1, '2026-01-10', 88),
(1, 3, '2026-01-12', 95),
(2, 1, '2026-01-11', 72),
(2, 2, '2026-01-15', NULL),
(3, 1, '2026-01-11', 91),
(3, 2, '2026-01-20', 60),
(5, 2, '2026-01-22', 55),
(5, 3, '2026-02-01', NULL);


-- Task 11:
SELECT
    Courses.title,
    COUNT(Enrollments.student_id) AS count_Enrollments
FROM Courses
LEFT JOIN Enrollments
    ON Courses.course_id = Enrollments.course_id
GROUP BY Courses.title
ORDER BY
    count_Enrollments DESC,
    Courses.title ASC;


-- Task 12:
SELECT
    full_name

FROM Students
LEFT JOIN Enrollments
    ON Students.student_id = Enrollments.student_id

WHERE Enrollments.student_id IS NULL

ORDER BY full_name;


-- Task 13:
SELECT
    Courses.title,
    ROUND(AVG(Enrollments.grade), 2) AS avg_grade,
    COUNT(Enrollments.grade) AS grade_count
FROM Courses
INNER JOIN Enrollments
    ON Courses.course_id = Enrollments.course_id
GROUP BY Courses.title
HAVING COUNT(Enrollments.grade) >= 2
ORDER BY avg_grade DESC;

-- Task 14:
SELECT
    Students.full_name,
    Enrollments.grade
FROM Students
INNER JOIN Enrollments
    ON Students.student_id = Enrollments.student_id
INNER JOIN Courses
    ON Enrollments.course_id = Courses.course_id
WHERE Students.city = 'Haifa'
    AND Courses.title = 'SQL Basics'
    AND Enrollments.grade > 80
ORDER BY Students.full_name ASC;


-- Task 15:
SELECT
    Courses.title,
    Courses.max_seats - COUNT(Enrollments.student_id) AS available_seats
FROM Courses
LEFT JOIN Enrollments
    ON Courses.course_id = Enrollments.course_id
GROUP BY
    Courses.course_id,
    Courses.title,
    Courses.max_seats
ORDER BY
    available_seats DESC,
    Courses.title ASC;


-- Task 16: Check Constraints
-- (a) המייל שומש כבר - מפר את ההגדרה של מייל יחודי 
INSERT INTO students (student_id, full_name, email, city)
VALUES (7, 'Test', 'dana@mail.com', 'Haifa');
-- (b) student_id שהוא 99 לא קיים אז הוא מנסה להשתמש במפתח חיצוני שלא קיים
INSERT INTO enrollments (student_id, course_id, grade)
VALUES (99, 1, 80);
-- (c) מפר את ההגדרה שציון צריך להיות בין 0 ל100
INSERT INTO enrollments (student_id, course_id, grade)
VALUES (4, 1, 105);


--Task 17:
-- אם הייתי משתמשת ב־INNER JOIN, הייתי מקבלת רק תלמידים שיש להם התאמה בטבלת ההרשמות. תלמידים שלא רשומים לאף קורס לא היו מופיעים, וזה בדיוק מה שהמשימה ביקשה למצוא


--Task 18:
-- COUNT(*) - סופר את כל הרשומות כולל NULL במקום ציון 
-- לכן הרשומה השלישית הייתה משפיעה - הרשומה שכתוב בה NULL


--Task 19: המפתח הראשי מורכב משתי עמודות כי תלמיד יכול להירשם לכמה קורסים, ובכל קורס יכולים להיות כמה תלמידים. השילוב של student_id ו־course_id מונע מצב שבו אותו תלמיד נרשם פעמיים לאותו קורס.

