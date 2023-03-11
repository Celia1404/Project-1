--CREATE 6 TABLES
DROP TABLE IF CASCADE faculties;
DROP TABLE IF CASCADE programs;
DROP TABLE IF CASCADE courses;
DROP TABLE IF CASCADE instructors;
DROP TABLE IF CASCADE offerings;
DROP TABLE IF CASCADE enrollments;


CREATE TABLE faculties(

  faculty_id VARCHAR (4) PRIMARY KEY,
  faculty_name VARCHAR (100) NOT NULL,
  faculty_description TEXT NOT NULL

  );
  
CREATE TABLE programs(

  program_id CHAR(4) PRIMARY KEY,
  faculty_id VARCHAR(4),
  program_name VARCHAR(50) NOT NULL,
  program_location VARCHAR (50),
  program_description TEXT NOT NULL,
  FOREIGN KEY(faculty_id)
  REFERENCES faculties(faculty_id)

);

CREATE TABLE courses(

  course_id INT PRIMARY KEY,
  code CHAR (8) NOT NULL,
  year INT NOT NULL,
  semester INT NOT NULL,
  section VARCHAR (10) NOT NULL,
  title VARCHAR (100) NOT NULL,
  credits INT NOT NULL,
  modality VARCHAR (50) NOT NULL,
  modality_type VARCHAR (20) NOT NULL,
  instructor_id  INT NOT NULL,
  class_venue VARCHAR (100),
  communication_tool VARCHAR (25),
  course_platform VARCHAR (25),
  field_trips VARCHAR (3) check(field_trips in ('Yes','No')),
  resources_required TEXT NOT NULL,
  resources_recommended TEXT NOT NULL,
  resources_other TEXT NOT NULL,
  description TEXT NOT NULL,
  outline_url TEXT NOT NULL,
  UNIQUE (code,year,semester,section),
  FOREIGN KEY (instructor_id)
  REFERENCES instructors (instructor_id)
  
);

CREATE TABLE courses_programs(

  course_id INT NOT NULL,
  program_id CHAR(4) NOT NULL,
  REFERENCES programs(program_id),
   FOREIGN KEY (course_id)
  REFERENCES courses(course_id)
  
);

CREATE TABLE instructors(

  instructor_id INT PRIMARY KEY,
  emial VARCHAR (50),
  instructor_name VARCHAR (50),
  office_location VARCHAR(50),
  telephone CHAR (20),
  degree VARCHAR (8)
  
);

CREATE TABLE pre_requisities(

  course_id INT NOT NULL,
  prereq_id VARCHAR (8) NOT NULL,
  FOREIGN KEY (course_id)
  REFERENCES courses (course_id)

);

COPY faculties
FROM '/home/celia/Downloads/faculties.csv'
DELIMITER ','
CSV HEADER;

COPY programs
FROM '/home/celia/Downloads/programs.csv'
DELIMITER ','
CSV HEADER;

COPY courses
FROM '/home/celia/Downloads/courses.csv'
DELIMITER ','
CSV HEADER;


COPY courses_programs
FROM '/home/celia/Downloads/courses_programs.csv'
DELIMITER ','
CSV HEADER;


COPY instructors
FROM '/home/celia/Downloads/instructors.csv'
DELIMITER ','
CSV HEADER;


COPY pre_requisites
FROM '/home/celia/Downloads/pre_reqs.csv'
DELIMITER ','
CSV HEADER;

-- QUARIES 
-- What faculties id’s at UB end in S?

SELECT faculty_id
FROM faculties
WHERE faculty_id 
LIKE '%S';

--

SELECT program_name FROM programs 
JOIN faculties ON programs.faculty_id = faculties.faculty_id
WHERE programs.program_location= 'Belize City';

--

SELECT instructor_name 
FROM instructors
WHERE instructors.instructor_name = 'Vernelle Sylvester';

--


SELECT instructor_name FROM instructors WHERE degree LIKE '%Masters';

--
SELECT courses.course_name AS course_name, pre_requisites.course_name AS prerequisite 
FROM courses 
LEFT JOIN courses  ON courses.prerequisite_course_id = pre_requisites.course_id
WHERE courses.course_code = 'CSC212';
--

