CREATE TABLE student(
student_id INT PRIMARY KEY AUTO_INCREMENT,
student_name VARCHAR(255) NOT NULL,
dod DATE NOT NULL,
email VARCHAR(255) UNIQUE
);

 CREATE TABLE teacher(
 teacher_id INT PRIMARY KEY AUTO_INCREMENT,
 teacher_name VARCHAR(255) NOT NULL,
email VARCHAR(255) UNIQUE
);

CREATE TABLE course(
course_id INT PRIMARY KEY AUTO_INCREMENT,
courrse_name VARCHAR(255) NOT NULL,
teacher_id INT,
FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id),
course_description TEXT ,
course_session INT CHECK (course_session >= 1)
 );

CREATE TABLE enrollment(
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE DEFAULT (CURDATE()),
    UNIQUE (student_id, course_id), 
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);

CREATE TABLE score(
    score_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    mid_score DECIMAL(4,2) CHECK (mid_score BETWEEN 0 AND 10),
    final_score DECIMAL(4,2) CHECK (final_score BETWEEN 0 AND 10),
    UNIQUE (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);

INSERT INTO student(student_name, dod, email) 
VALUES ('Nguyen Van A','2000-01-01','a@gmail.com'),
	   ('Tran Thi B','2001-02-02','b@gmail.com'),
	   ('Le Van C','2000-03-03','c@gmail.com'),
       ('Pham Thi D','2002-04-04','d@gmail.com'),
       ('Hoang Van E','2001-05-05','e@gmail.com');
       
INSERT INTO teacher(teacher_name, email) 
VALUES ('Teacher A','ta@gmail.com'),
       ('Teacher B','tb@gmail.com'),
       ('Teacher C','tc@gmail.com'),
       ('Teacher D','td@gmail.com'),
       ('Teacher E','te@gmail.com');
       
INSERT INTO course(courrse_name, teacher_id, course_description, course_session) 
VALUES ('SQL',1,'Hoc SQL co ban',20),
       ('Java',2,'Lap trinh Java',25),
       ('Web',3,'HTML CSS JS',30),
       ('C++',4,'Lap trinh C++',22),
       ('Python',5,'Python co ban',28);
       
INSERT INTO enrollment(student_id, course_id) 
VALUES (1,1),
       (1,2),
       (2,1),
       (3,3),
       (4,4);

INSERT INTO score(student_id, course_id, mid_score, final_score) 
VALUES (1,1,7.5,8.0),
       (1,2,6.0,7.0),
	   (2,1,8.5,9.0),
       (3,3,5.5,6.5),
       (4,4,9.0,9.5);       
       
-- cnhap mail
UPDATE student
SET email = 'newa@gmail.com'
WHERE student_id = 1;

-- cnhat mo ta khoa hoc 
UPDATE course
SET course_description = 'SQL nang cao'
WHERE course_id = 1;

-- cnhap diem ck
UPDATE score
SET final_score = 9.5
WHERE student_id = 1 AND course_id = 1;

DELETE FROM enrollment
WHERE student_id = 4 AND course_id = 4;

DELETE FROM score
WHERE student_id = 4 AND course_id = 4;

SELECT * FROM student;

SELECT * FROM teacher;

SELECT * FROM course;

SELECT * FROM enrollment;

SELECT * FROM score;