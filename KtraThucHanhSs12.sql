CREATE DATABASE StudentDB;
USE StudentDB;

CREATE TABLE Department (
    DeptID VARCHAR(5) PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL
);

CREATE TABLE Student (
    StudentID VARCHAR(6) PRIMARY KEY,
    FullName VARCHAR(50),
    Gender VARCHAR(10),
    BirthDate DATE,
    DeptID VARCHAR(5),
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

CREATE TABLE Course (
    CourseID VARCHAR(6) PRIMARY KEY,
    CourseName VARCHAR(50),
    Credits INT
);

CREATE TABLE Enrollment (
    StudentID VARCHAR(6),
    CourseID VARCHAR(6),
    Score DECIMAL(4,2),
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

INSERT INTO Department VALUES
('IT','Information Technology'),
('BA','Business Administration'),
('ACC','Accounting');

INSERT INTO Student VALUES
('S00001','Nguyen An','Male','2003-05-10','IT'),
('S00002','Tran Binh','Male','2003-06-15','IT'),
('S00003','Le Hoa','Female','2003-08-20','BA'),
('S00004','Pham Minh','Male','2002-12-12','ACC'),
('S00005','Vo Lan','Female','2003-03-01','IT'),
('S00006','Do Hung','Male','2002-11-11','BA'),
('S00007','Nguyen Mai','Female','2003-07-07','ACC'),
('S00008','Tran Phuc','Male','2003-09-09','IT');

INSERT INTO Course VALUES
('C00001','Database Systems',3),
('C00002','Programming',4),
('C00003','Marketing',3);

INSERT INTO Enrollment VALUES
('S00001','C00001',8.5),
('S00002','C00001',9.0),
('S00003','C00001',7.5),
('S00005','C00001',8.0),
('S00008','C00001',9.5),
('S00001','C00002',8.0),
('S00002','C00002',7.0);

CREATE VIEW ViewStudentBasic AS
SELECT 
    Student.StudentID,
    Student.FullName,
    Department.DeptName
FROM Student, Department
WHERE Student.DeptID = Department.DeptID;

SELECT * FROM ViewStudentBasic;

CREATE INDEX idxFullName
ON Student(FullName);

DELIMITER //
CREATE PROCEDURE GetStudentsIT()
BEGIN
    SELECT 
        Student.StudentID,
        Student.FullName,
        Student.Gender,
        Student.BirthDate,
        Department.DeptName
    FROM Student, Department
    WHERE Student.DeptID = Department.DeptID
    AND Department.DeptName = 'Information Technology';
END //
DELIMITER ;
CALL GetStudentsIT();

CREATE VIEW ViewStudentCountByDept AS
SELECT 
    Department.DeptName,
    COUNT(Student.StudentID) AS TotalStudents
FROM Department, Student
WHERE Department.DeptID = Student.DeptID
GROUP BY Department.DeptName;
SELECT * FROM ViewStudentCountByDept;
SELECT *
FROM ViewStudentCountByDept
WHERE TotalStudents = (
    SELECT MAX(TotalStudents)
    FROM ViewStudentCountByDept
);

DELIMITER //
CREATE PROCEDURE GetTopScoreStudent(
    IN varCourseID VARCHAR(6)
)
BEGIN
    SELECT 
        Student.StudentID,
        Student.FullName,
        Enrollment.Score
    FROM Student, Enrollment
    WHERE Student.StudentID = Enrollment.StudentID
    AND Enrollment.CourseID = varCourseID
    AND Enrollment.Score = (
        SELECT MAX(Score)
        FROM Enrollment
        WHERE CourseID = varCourseID
    );
END //
DELIMITER ;

CALL GetTopScoreStudent('C00001');

CREATE VIEW ViewITEnrollmentDB AS
SELECT
    Enrollment.StudentID,
    Enrollment.CourseID,
    Enrollment.Score
FROM Enrollment, Student
WHERE Enrollment.StudentID = Student.StudentID
AND Student.DeptID = 'IT'
AND Enrollment.CourseID = 'C00001'
WITH CHECK OPTION;
SELECT * FROM ViewITEnrollmentDB;

DELIMITER //
CREATE PROCEDURE UpdateScoreITDB(
    IN varStudentID VARCHAR(6),
    INOUT inoutNewScore DECIMAL(4,2)
)
BEGIN

    IF inoutNewScore > 10 THEN
        SET inoutNewScore = 10;
    END IF;

    UPDATE ViewITEnrollmentDB
    SET Score = inoutNewScore
    WHERE StudentID = varStudentID;

END //
DELIMITER ;

SET @newScore = 11;

CALL UpdateScoreITDB('S00001', @newScore);

SELECT @newScore;

SELECT * FROM ViewITEnrollmentDB;