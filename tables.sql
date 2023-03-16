--CREATE 6 TABLES
DROP TABLE faculties CASCADE;
DROP TABLE programs CASCADE;
DROP TABLE courses CASCADE;
DROP TABLE instructors CASCADE;
DROP TABLE courses_programs CASCADE;
DROP TABLE pre_requisites CASCADE;


CREATE TABLE faculties (
  faculty_id varchar(10) NOT NULL,
  faculty_name varchar(50) NOT NULL,
  campus VARCHAR(50),
  faculty_description varchar
  
);

CREATE TABLE programs (
  program_id varchar(10) NOT NULL PRIMARY KEY,
  faculty_id varchar(10) NOT NULL,
  program_name varchar(100) NOT NULL,
  program_location varchar(50),
  program_description text
);

CREATE TABLE courses (
  id varchar(10) NOT NULL,
  code varchar(10) NOT NULL,
  year integer NOT NULL,
  semester varchar(10) NOT NULL,
  section varchar(10) NOT NULL,
  title varchar NOT NULL,
  credits integer NOT NULL,
  modality varchar NOT NULL,
  modality_type varchar,
  instructor_id varchar NOT NULL,
  class_venue varchar,
  communication_tool varchar,
  course_platform varchar,
  field_trips varchar,
  resources_required varchar,
  resources_recommended varchar,
  resources_other varchar,
  course_description varchar,
  course_outline_url varchar
);

CREATE TABLE instructors (
  instructor_id varchar(10) NOT NULL,
  instructor_email varchar(100) UNIQUE NOT NULL,
  instructor_name varchar(100) NOT NULL,
  office_location varchar(50),
  telephone varchar(20),
  degree varchar(50)
);

CREATE TABLE courses_programs ( 
  program_id varchar(10) NOT NULL,
  course_id varchar(10) NOT NULL
);


CREATE TABLE pre_requisites (
  course_code varchar,
  pre_requisites varchar
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


SELECT instructor_name 
FROM instructors 
WHERE degree LIKE '%Masters';
--

SELECT courses.course_name AS course_name, pre_requisites.course_name AS prerequisite 
FROM courses 
LEFT JOIN courses  ON courses.prerequisite_course_id = pre_requisites.course_id
WHERE courses.course_code = 'CSC212';
