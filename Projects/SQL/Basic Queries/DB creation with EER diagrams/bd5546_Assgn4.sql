CREATE DATABASE bd5546_CSUEB_db;

CREATE TABLE STUDENT(
	StudentID int,
    Last_Name varchar(100),
    First_Name varchar(100),
    Street_Address varchar(100),
    City varchar(100),
    State varchar(100),
    zip_code varchar(100),
    DOB DATE,
    Department_number int,
    PRIMARY KEY (StudentID),
    FOREIGN KEY (Department_number) REFERENCES DEPARTMENT(Department_number)
);

CREATE TABLE PROFESSOR(
	ProfessorID int,
    Last_Name varchar(100),
    First_Name varchar(100),
    Office_Hours varchar(100),
    Duration varchar(100),
    Office_room_number int,
    Department_number int,
    PRIMARY KEY(ProfessorID),
    FOREIGN KEY (Department_number) REFERENCES DEPARTMENT(Department_number)
);

CREATE TABLE DEPARTMENT(
	Department_number int,
    Department_name varchar(100),
    PRIMARY KEY(Department_number)
);

CREATE TABLE COURSES(
	course_number int PRIMARY KEY,
    course_name varchar(100)
);
    
CREATE TABLE CLASSES(
		class_number int PRIMARY KEY,
        class_section int,
        semester varchar(50),
        Year int,
        ProfessorID int,
        days varchar(100),
        class_time varchar(100),
        class_duration varchar(100),
        FOREIGN KEY(ProfessorID) REFERENCES PROFESSOR(ProfessorID)
);

CREATE TABLE ENROLLMENT(
		course_number int,
        StudentID int,
        semester varchar(50),
        class_section int,
        FOREIGN KEY(course_number) REFERENCES COURSES(course_number),
        FOREIGN KEY(StudentID) REFERENCES STUDENT(StudentID),
        FOREIGN KEY(semester, class_section) REFERENCES CLASSES(semester, class_section)
);
    
CREATE TABLE GRADES(
		course_number int,
        StudentID int,
        semester varchar(50),
        Year int,
        grade varchar(10),
        class_section int,
        FOREIGN KEY(course_number) REFERENCES COURSES(course_number),
        FOREIGN KEY(StudentID) REFERENCES STUDENT(StudentID),
        FOREIGN KEY(semester, class_section, year) REFERENCES CLASSES(semester, class_section, year)
);