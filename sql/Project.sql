-- droping tables if exist
DROP TABLE IF EXISTS Apply_Job;
DROP TABLE IF EXISTS Prerequisite;
DROP TABLE IF EXISTS Rating;
DROP TABLE IF EXISTS SelectedSkills;
DROP TABLE IF EXISTS Skills;
DROP TABLE IF EXISTS WorkExperience;
DROP TABLE IF EXISTS JobSeekerEducation;
DROP TABLE IF EXISTS JobSeeker;
DROP TABLE IF EXISTS Employer;
DROP TABLE IF EXISTS Jobs;

DROP VIEW IF EXISTS JobSeekerInfo;
DROP VIEW IF EXISTS EmployerInfo;
DROP VIEW IF EXISTS JobInfo;

DROP PROCEDURE IF EXISTS GetJobSeekerInfo;
DROP FUNCTION IF EXISTS GetPrerequisite;
-- create tables
CREATE TABLE Apply_Job (
  job_id int DEFAULT NULL,
  job_seeker_national_id int DEFAULT NULL,
  status varchar(50) DEFAULT NULL,
  
  CONSTRAINT PK_Apply_Job PRIMARY KEY (job_id, job_seeker_national_id),
);

CREATE TABLE Employer (
  id int NOT NULL,
  full_name varchar(100) DEFAULT NULL,
  email varchar(100) DEFAULT NULL,
  phone_number varchar(20) DEFAULT NULL,
  type varchar(50) DEFAULT NULL,
  address varchar(200) DEFAULT NULL,

  CONSTRAINT PK_Employer PRIMARY KEY (id)
);

CREATE TABLE JobSeeker (
  national_id int NOT NULL,
  level varchar(50) DEFAULT NULL,
  full_name varchar(100) DEFAULT NULL,
  email_address varchar(100) DEFAULT NULL,
  phone_number varchar(20) DEFAULT NULL,
  address varchar(200) DEFAULT NULL,
  employment_status varchar(50) DEFAULT NULL,
  marital_status varchar(20) DEFAULT NULL,
  number_of_children int DEFAULT NULL,
  gender varchar(10) DEFAULT NULL,
  date_of_birth date DEFAULT NULL,
  residence_location varchar(200) DEFAULT NULL
  
  CONSTRAINT PK_JobSeeker PRIMARY KEY (national_id)
);

CREATE TABLE JobSeekerEducation (
  national_id int DEFAULT NULL,
  graduation_date date DEFAULT NULL,
  field_of_study varchar(100) DEFAULT NULL

  CONSTRAINT PK_JobSeekerEducation PRIMARY KEY (national_id)
);

CREATE TABLE Jobs (
  id int NOT NULL,
  required_level varchar(50) DEFAULT NULL,
  title varchar(100) DEFAULT NULL,
  explanation varchar(255) DEFAULT NULL,
  required_gender varchar(10) DEFAULT NULL,
  remote_work_possible bit DEFAULT 0,
  proposed_salary decimal(10,2) DEFAULT NULL,
  work_location_address varchar(200) DEFAULT NULL,
  display_status bit DEFAULT 0,
  required_education varchar(100) DEFAULT NULL,
  registration_date date DEFAULT NULL

  CONSTRAINT PK_Jobs PRIMARY KEY (id)
);


CREATE TABLE Prerequisite (
  job_id int DEFAULT NULL,
  skill_id int DEFAULT NULL

  CONSTRAINT PK_Prerequisite PRIMARY KEY (job_id, skill_id)
);

CREATE TABLE Rating (
  job_seeker_id int DEFAULT NULL,
  employer_id int DEFAULT NULL,
  rating int DEFAULT NULL

  CONSTRAINT PK_Rating PRIMARY KEY (job_seeker_id, employer_id)
);

CREATE TABLE Skills (
  id int NOT NULL,
  skill_type varchar(50) DEFAULT NULL,
  skill_name varchar(100) DEFAULT NULL

  CONSTRAINT PK_Skills PRIMARY KEY (id)
);

CREATE TABLE SelectedSkills (
  job_seeker_national_id int DEFAULT NULL,
  skill_id int DEFAULT NULL

  CONSTRAINT PK_SelectedSkills PRIMARY KEY (job_seeker_national_id, skill_id)
);

CREATE TABLE WorkExperience (
  job_seeker_national_id int DEFAULT NULL,
  id int DEFAULT NULL,
  employer_id int DEFAULT NULL,
  title varchar(100) DEFAULT NULL,
  start_date date DEFAULT NULL,
  end_date date DEFAULT NULL,
  level varchar(50) DEFAULT NULL

  CONSTRAINT PK_WorkExperience PRIMARY KEY (job_seeker_national_id, id)
);

-- UPDATE TABLES
-- ALTER TABLE Apply_Job
  -- ADD CONSTRAINT Apply_Job_ibfk_1 FOREIGN KEY (job_id) REFERENCES Jobs (id);
ALTER TABLE Apply_Job
  ADD CONSTRAINT Apply_Job_ibfk_2 FOREIGN KEY (job_seeker_national_id) REFERENCES JobSeeker (national_id) ON DELETE CASCADE;

ALTER TABLE JobSeekerEducation
  ADD CONSTRAINT JobSeekerEducation_ibfk_1 FOREIGN KEY (national_id) REFERENCES JobSeeker (national_id) ON DELETE CASCADE;

ALTER TABLE Prerequisite
  ADD CONSTRAINT Prerequisite_ibfk_1 FOREIGN KEY (job_id) REFERENCES Jobs (id) ON DELETE CASCADE;
ALTER TABLE Prerequisite
  ADD CONSTRAINT Prerequisite_ibfk_2 FOREIGN KEY (skill_id) REFERENCES Skills (id) ON DELETE CASCADE;

ALTER TABLE Rating
  ADD CONSTRAINT Rating_ibfk_1 FOREIGN KEY (job_seeker_id) REFERENCES JobSeeker (national_id) ON DELETE CASCADE;
ALTER TABLE Rating
  ADD CONSTRAINT Rating_ibfk_2 FOREIGN KEY (employer_id) REFERENCES Employer (id) ON DELETE NO ACTION;

ALTER TABLE SelectedSkills
  ADD CONSTRAINT SelectedSkills_ibfk_1 FOREIGN KEY (job_seeker_national_id) REFERENCES JobSeeker (national_id) ON DELETE CASCADE;
ALTER TABLE SelectedSkills
  ADD CONSTRAINT SelectedSkills_ibfk_2 FOREIGN KEY (skill_id) REFERENCES Skills (id);

ALTER TABLE WorkExperience
  ADD CONSTRAINT WorkExperience_ibfk_1 FOREIGN KEY (job_seeker_national_id) REFERENCES JobSeeker (national_id) ON DELETE CASCADE;
ALTER TABLE WorkExperience
  ADD CONSTRAINT WorkExperience_ibfk_2 FOREIGN KEY (employer_id) REFERENCES Employer (id);




-- insert data

INSERT INTO Employer (id, full_name, email, phone_number, type, address) VALUES
(1, 'ABC Company', 'info@abccompany.com', '(555) 456-7890', 'Technology', '246 Oak St, Anytown USA'),
(2, 'XYZ Corporation', 'info@xyzcorp.com', '(555) 567-8901', 'Manufacturing', '135 Maple Ave, Anytown USA'),
(3, 'LMN Corporation', 'info@lmncorp.com', '(555) 901-2345', 'Retail', '678 Oak St, Anytown USA'),
(4, 'PQR Inc.', 'info@pqrintl.com', '(555) 012-3456', 'Engineering', '910 Maple Ave, Anytown USA');

INSERT INTO Jobs (id, required_level, title, explanation, required_gender, remote_work_possible, proposed_salary, work_location_address, display_status, required_education, registration_date) VALUES
(1, 'Entry', 'Front-End Developer', 'This job requires a strong background in HTML, CSS and JavaScript.', 'Any', 1, 45000.00, '123 Main St, Anytown USA', '1', 'Bachelor of Science in Computer Science', '2022-01-05'),
(2, 'Mid-Level', 'Software Engineer', 'We are looking for someone with experience in Java and Python.', 'Any', 0, 75000.00, '456 Elm St, Anytown USA', 1, 'Bachelor of Science in Computer Engineering', '2022-03-12'),
(3, 'Senior', 'DevOps Engineer', 'The ideal candidate will have experience with cloud infrastructure and containerization technologies.', 'Any', 1, 95000.00, '789 Oak St, Anytown USA', 1, 'Master of Science in Computer Science', '2022-02-28'),
(4, 'Entry', 'Data Entry Clerk', 'This job requires a strong attention to detail and the ability to work with large amounts of data.', 'Any', 1, 35000.00, '789 Main St, Anytown USA', 1, 'High School Diploma or Equivalent', '2022-06-10'),
(5, 'Mid-Level', 'Business Analyst', 'We are looking for someone with experience in data analysis and project management.', 'Any', 0, 85000.00, '345 Elm St, Anytown USA', 1, 'Bachelor of Science in Business Administration', '2022-07-15'),
(6, 'Senior', 'Chief Financial Officer', 'The ideal candidate will have extensive experience in financial management and strategic planning.', 'Any', 1, 150000.00, '567 Oak St, Anytown USA', 1, 'Master of Business Administration', '2022-08-20');

INSERT INTO JobSeeker (national_id, level, full_name, email_address, phone_number, address, employment_status, marital_status, number_of_children, gender, date_of_birth, residence_location) VALUES
(123456789, 'Entry', 'John Smith', 'johnsmith@email.com', '(555) 123-4567', '321 Pine St, Anytown USA', 'Unemployed', 'Single', 0, 'Male', '1999-05-12', '321 Pine St, Anytown USA'),
(234567890, 'Mid-Level', 'Jane Doe', 'janedoe@email.com', '(555) 234-5678', '654 Maple Ave, Anytown USA', 'Employed', 'Married', 2, 'Female', '1995-02-21', '654 Maple Ave, Anytown USA'),
(345678901, 'Senior', 'Bob Johnson', 'bobjohnson@email.com', '(555) 345-6789', '987 Cherry Ln, Anytown USA', 'Employed', 'Married', 3, 'Male', '1985-12-30', '987 Cherry Ln, Anytown USA'),
(456789012, 'Entry', 'Samantha Lee', 'samlee@email.com', '(555) 678-9012', '246 Pine St, Anytown USA', 'Unemployed', 'Single', 0, 'Female', '2001-01-01', '246 Pine St, Anytown USA'),
(567890123, 'Mid-Level', 'David Kim', 'dkim@email.com', '(555) 789-0123', '789 Maple Ave, Anytown USA', 'Employed', 'Married', 1, 'Male', '1990-06-15', '789 Maple Ave, Anytown USA'),
(678901234, 'Senior', 'Emily Nguyen', 'enguyen@email.com', '(555) 890-1234', '123 Cherry Ln, Anytown USA', 'Employed', 'Single', 0, 'Female', '1980-12-25', '123 Cherry Ln, Anytown USA');

INSERT INTO JobSeekerEducation (national_id, graduation_date, field_of_study) VALUES
(123456789, '2021-05-15', 'Bachelor of Science in Computer Science'),
(234567890, '2017-12-20', 'Master of Business Administration'),
(345678901, '2007-08-10', 'Bachelor of Arts in English'),
(456789012, '2020-05-15', 'Associate in Applied Science in Accounting'),
(567890123, '2015-12-20', 'Master of Science in Computer Information Systems'),
(678901234, '2004-08-10', 'Bachelor of Arts in Economics');

INSERT INTO Apply_Job (job_id, job_seeker_national_id, status) VALUES
(1, 123456789, 'Pending'),
(2, 234567890, 'Accepted'),
(3, 345678901, 'Rejected'),
(1, 234567890, 'Pending'),
(4, 456789012, 'Pending'),
(5, 567890123, 'Accepted'),
(6, 678901234, 'Rejected'),
(4, 567890123, 'Pending'),
(5, 678901234, 'Pending'),
(6, 456789012, 'Accepted'),
(4, 678901234, 'Rejected'),
(5, 456789012, 'Pending');




INSERT INTO Rating (job_seeker_id, employer_id, rating) VALUES
(123456789, 1, 4),
(234567890, 2, 3),
(456789012, 3, 4),
(567890123, 4, 3),
(678901234, 3, 5);


INSERT INTO Skills (id, skill_type, skill_name) VALUES
(1, 'Programming Language', 'Java'),
(2, 'Programming Language', 'Python'),
(3, 'Programming Language', 'JavaScript'),
(4, 'Cloud Infrastructure', 'Amazon Web Services'),
(5, 'Containerization Technology', 'Docker'),
(6, 'Programming Language', 'C++'),
(7, 'Programming Language', 'Ruby'),
(8, 'Programming Language', 'PHP'),
(9, 'Cloud Infrastructure', 'Microsoft Azure'),
(10, 'Containerization Technology', 'Kubernetes');

INSERT INTO SelectedSkills (job_seeker_national_id, skill_id) VALUES
(123456789, 3),
(234567890, 1),
(345678901, 5),
(456789012, 1),
(567890123, 5),
(678901234, 9);

INSERT INTO Prerequisite (job_id, skill_id) VALUES
(2, 1),
(2, 2),
(3, 4),
(3, 5),
(4, 1),
(4, 3),
(5, 2),
(5, 5),
(6, 4),
(6, 8);

INSERT INTO WorkExperience (job_seeker_national_id, id, employer_id, title, start_date, end_date, level) VALUES
(123456789, 1, 1, 'Junior Software Developer', '2021-06-01', NULL, 'Entry'),
(234567890, 2, 2, 'Marketing Manager', '2018-03-15', '2022-05-20', 'Mid-Level'),
(345678901, 3, 1, 'Content Writer', '2009-08-01', '2015-12-31', 'Entry'),
(345678901, 4, 2, 'Product Manager', '2016-01-01', '2022-02-28', 'Senior'),
(456789012, 5, 3, 'Sales Associate', '2021-01-01', NULL, 'Entry'),
(567890123, 6, 4, 'Software Engineer', '2018-08-15', '2022-05-20', 'Mid-Level'),
(678901234, 7, 3, 'Store Manager', '2005-06-01', '2015-12-31', 'Entry'),
(678901234, 8, 4, 'VP of Engineering', '2016-01-01', '2022-02-28', 'Senior');




-- UPDATE RECORDS
UPDATE Jobs SET display_status = 0 WHERE id = 4;
UPDATE Jobs SET display_status = 0 WHERE id = 5;
UPDATE Employer SET full_name = 'ABC Company', email = 'new@gmail.com' WHERE id = 1;
UPDATE WorkExperience SET title = 'Senior Software Engineer' WHERE id = 6;


-- DELETE RECORDS
DELETE FROM Jobs WHERE id = 6;
DELETE FROM WorkExperience WHERE id = 8;
DELETE FROM JobSeeker WHERE national_id = 678901234;

GO

-- Trigger
CREATE TRIGGER update_job_status ON Apply_Job
	FOR INSERT AS
	BEGIN

	UPDATE Jobs SET display_status = 0 WHERE id IN (SELECT job_id FROM inserted WHERE status = 'Accepted');
END;
GO


-- View
CREATE VIEW JobSeekerInfo AS SELECT * FROM JobSeeker;
GO
CREATE VIEW EmployerInfo AS SELECT * FROM Employer;
GO
CREATE VIEW JobInfo AS SELECT * FROM Jobs;
GO

-- Procedure
CREATE PROCEDURE GetJobSeekerInfo (@national_id INT) AS
    SELECT * FROM JobSeeker WHERE national_id = @national_id;
GO

-- Function
CREATE FUNCTION GetPrerequisite (@job_id INT) RETURNS TABLE AS RETURN
	SELECT * FROM Prerequisite WHERE job_id = @job_id;
GO
