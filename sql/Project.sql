CREATE TABLE `Apply_Job` (
  `job_id` int(11) DEFAULT NULL,
  `job_seeker_national_id` int(11) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL
);

CREATE TABLE `Employer` (
  `id` int(11) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL
);

CREATE TABLE `EmployerEmail` (
  `id` int(11) DEFAULT NULL,
  `email_address` varchar(100) DEFAULT NULL
);

CREATE TABLE `EmployerPhoneNumber` (
  `id` int(11) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL
);

CREATE TABLE `JobSeeker` (
  `national_id` int(11) NOT NULL,
  `level` varchar(50) DEFAULT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `employment_status` varchar(50) DEFAULT NULL,
  `marital_status` varchar(20) DEFAULT NULL,
  `number_of_children` int(11) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `residence_location` varchar(200) DEFAULT NULL
);


CREATE TABLE `Jobs` (
  `id` int(11) NOT NULL,
  `required_level` varchar(50) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `explanation` varchar(255) DEFAULT NULL,
  `required_gender` varchar(10) DEFAULT NULL,
  `remote_work_possible` bit(1) DEFAULT NULL,
  `proposed_salary` decimal(10,2) DEFAULT NULL,
  `work_location_address` varchar(200) DEFAULT NULL,
  `display_status` bit(1) DEFAULT NULL,
  `required_education` varchar(100) DEFAULT NULL,
  `registration_date` date DEFAULT NULL
);

CREATE TABLE `JobSeekerEducation` (
  `national_id` int(11) DEFAULT NULL,
  `graduation_date` date DEFAULT NULL,
  `field_of_study` varchar(100) DEFAULT NULL
);

CREATE TABLE `JobSeekerEmail` (
  `national_id` int(11) DEFAULT NULL,
  `email_address` varchar(100) DEFAULT NULL
);

CREATE TABLE `JobSeekerPhoneNumber` (
  `national_id` int(11) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL
);

CREATE TABLE `Prerequisite` (
  `job_id` int(11) DEFAULT NULL,
  `skill_id` int(11) DEFAULT NULL
);

CREATE TABLE `Rating` (
  `job_seeker_id` int(11) DEFAULT NULL,
  `employer_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL
);

CREATE TABLE `Skills` (
  `id` int(11) NOT NULL,
  `skill_type` varchar(50) DEFAULT NULL,
  `skill_name` varchar(100) DEFAULT NULL
);

CREATE TABLE `SelectedSkills` (
  `job_seeker_national_id` int(11) DEFAULT NULL,
  `skill_id` int(11) DEFAULT NULL
);

CREATE TABLE `WorkExperience` (
  `job_seeker_national_id` int(11) DEFAULT NULL,
  `id` int(11) DEFAULT NULL,
  `employer_id` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `level` varchar(50) DEFAULT NULL
);



ALTER TABLE `Apply_Job`
  ADD KEY `job_id` (`job_id`),
  ADD KEY `job_seeker_national_id` (`job_seeker_national_id`);

ALTER TABLE `Employer`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `EmployerEmail`
  ADD KEY `id` (`id`);

ALTER TABLE `EmployerPhoneNumber`
  ADD KEY `id` (`id`);

ALTER TABLE `Jobs`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `JobSeeker`
  ADD PRIMARY KEY (`national_id`);

ALTER TABLE `JobSeekerEducation`
  ADD KEY `national_id` (`national_id`);

ALTER TABLE `JobSeekerEmail`
  ADD KEY `national_id` (`national_id`);

ALTER TABLE `JobSeekerPhoneNumber`
  ADD KEY `national_id` (`national_id`);

ALTER TABLE `Prerequisite`
  ADD KEY `job_id` (`job_id`),
  ADD KEY `skill_id` (`skill_id`);

ALTER TABLE `Rating`
  ADD KEY `job_seeker_id` (`job_seeker_id`),
  ADD KEY `employer_id` (`employer_id`);

ALTER TABLE `SelectedSkills`
  ADD KEY `job_seeker_national_id` (`job_seeker_national_id`),
  ADD KEY `skill_id` (`skill_id`);

ALTER TABLE `Skills`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `WorkExperience`
  ADD KEY `job_seeker_national_id` (`job_seeker_national_id`),
  ADD KEY `employer_id` (`employer_id`);






ALTER TABLE `Apply_Job`
  ADD CONSTRAINT `Apply_Job_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `Jobs` (`id`),
  ADD CONSTRAINT `Apply_Job_ibfk_2` FOREIGN KEY (`job_seeker_national_id`) REFERENCES `JobSeeker` (`national_id`);

ALTER TABLE `EmployerEmail`
  ADD CONSTRAINT `EmployerEmail_ibfk_1` FOREIGN KEY (`id`) REFERENCES `Employer` (`id`);

ALTER TABLE `EmployerPhoneNumber`
  ADD CONSTRAINT `EmployerPhoneNumber_ibfk_1` FOREIGN KEY (`id`) REFERENCES `Employer` (`id`);

ALTER TABLE `JobSeekerEducation`
  ADD CONSTRAINT `JobSeekerEducation_ibfk_1` FOREIGN KEY (`national_id`) REFERENCES `JobSeeker` (`national_id`);

ALTER TABLE `JobSeekerEmail`
  ADD CONSTRAINT `JobSeekerEmail_ibfk_1` FOREIGN KEY (`national_id`) REFERENCES `JobSeeker` (`national_id`);

ALTER TABLE `JobSeekerPhoneNumber`
  ADD CONSTRAINT `JobSeekerPhoneNumber_ibfk_1` FOREIGN KEY (`national_id`) REFERENCES `JobSeeker` (`national_id`);

ALTER TABLE `Prerequisite`
  ADD CONSTRAINT `Prerequisite_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `Jobs` (`id`),
  ADD CONSTRAINT `Prerequisite_ibfk_2` FOREIGN KEY (`skill_id`) REFERENCES `Skills` (`id`);

ALTER TABLE `Rating`
  ADD CONSTRAINT `Rating_ibfk_1` FOREIGN KEY (`job_seeker_id`) REFERENCES `JobSeeker` (`national_id`),
  ADD CONSTRAINT `Rating_ibfk_2` FOREIGN KEY (`employer_id`) REFERENCES `Employer` (`id`);

ALTER TABLE `SelectedSkills`
  ADD CONSTRAINT `SelectedSkills_ibfk_1` FOREIGN KEY (`job_seeker_national_id`) REFERENCES `JobSeeker` (`national_id`),
  ADD CONSTRAINT `SelectedSkills_ibfk_2` FOREIGN KEY (`skill_id`) REFERENCES `Skills` (`id`);

ALTER TABLE `WorkExperience`
  ADD CONSTRAINT `WorkExperience_ibfk_1` FOREIGN KEY (`job_seeker_national_id`) REFERENCES `JobSeeker` (`national_id`),
  ADD CONSTRAINT `WorkExperience_ibfk_2` FOREIGN KEY (`employer_id`) REFERENCES `Employer` (`id`);




INSERT INTO `Apply_Job` (`job_id`, `job_seeker_national_id`, `status`) VALUES
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

INSERT INTO `Employer` (`id`, `full_name`, `email`, `type`, `address`) VALUES
(1, 'ABC Company', 'info@abccompany.com', 'Technology', '246 Oak St, Anytown USA'),
(2, 'XYZ Corporation', 'info@xyzcorp.com', 'Manufacturing', '135 Maple Ave, Anytown USA'),
(3, 'LMN Corporation', 'info@lmncorp.com', 'Retail', '678 Oak St, Anytown USA'),
(4, 'PQR Inc.', 'info@pqrintl.com', 'Engineering', '910 Maple Ave, Anytown USA');

INSERT INTO `EmployerEmail` (`id`, `email_address`) VALUES
(1, 'abcjobs@email.com'),
(2, 'xyzjobs@email.com'),
(3, 'lmnjobs@email.com'),
(4, 'pqrjobs@email.com');

INSERT INTO `EmployerPhoneNumber` (`id`, `phone_number`) VALUES
(1, '(555) 456-7890'),
(2, '(555) 567-8901'),
(3, '(555) 901-2345'),
(4, '(555) 012-3456');

INSERT INTO `Jobs` (`id`, `required_level`, `title`, `explanation`, `required_gender`, `remote_work_possible`, `proposed_salary`, `work_location_address`, `display_status`, `required_education`, `registration_date`) VALUES
(1, 'Entry', 'Front-End Developer', 'This job requires a strong background in HTML, CSS and JavaScript.', 'Any', b'1', 45000.00, '123 Main St, Anytown USA', b'1', 'Bachelor of Science in Computer Science', '2022-01-05'),
(2, 'Mid-Level', 'Software Engineer', 'We are looking for someone with experience in Java and Python.', 'Any', b'0', 75000.00, '456 Elm St, Anytown USA', b'1', 'Bachelor of Science in Computer Engineering', '2022-03-12'),
(3, 'Senior', 'DevOps Engineer', 'The ideal candidate will have experience with cloud infrastructure and containerization technologies.', 'Any', b'1', 95000.00, '789 Oak St, Anytown USA', b'1', 'Master of Science in Computer Science', '2022-02-28'),
(4, 'Entry', 'Data Entry Clerk', 'This job requires a strong attention to detail and the ability to work with large amounts of data.', 'Any', b'1', 35000.00, '789 Main St, Anytown USA', b'1', 'High School Diploma or Equivalent', '2022-06-10'),
(5, 'Mid-Level', 'Business Analyst', 'We are looking for someone with experience in data analysis and project management.', 'Any', b'0', 85000.00, '345 Elm St, Anytown USA', b'1', 'Bachelor of Science in Business Administration', '2022-07-15'),
(6, 'Senior', 'Chief Financial Officer', 'The ideal candidate will have extensive experience in financial management and strategic planning.', 'Any', b'1', 150000.00, '567 Oak St, Anytown USA', b'1', 'Master of Business Administration', '2022-08-20');

INSERT INTO `JobSeeker` (`national_id`, `level`, `full_name`, `address`, `employment_status`, `marital_status`, `number_of_children`, `gender`, `date_of_birth`, `residence_location`) VALUES
(123456789, 'Entry', 'John Smith', '321 Pine St, Anytown USA', 'Unemployed', 'Single', 0, 'Male', '1999-05-12', '321 Pine St, Anytown USA'),
(234567890, 'Mid-Level', 'Jane Doe', '654 Maple Ave, Anytown USA', 'Employed', 'Married', 2, 'Female', '1995-02-21', '654 Maple Ave, Anytown USA'),
(345678901, 'Senior', 'Bob Johnson', '987 Cherry Ln, Anytown USA', 'Employed', 'Married', 3, 'Male', '1985-12-30', '987 Cherry Ln, Anytown USA'),
(456789012, 'Entry', 'Samantha Lee', '246 Pine St, Anytown USA', 'Unemployed', 'Single', 0, 'Female', '2001-01-01', '246 Pine St, Anytown USA'),
(567890123, 'Mid-Level', 'David Kim', '789 Maple Ave, Anytown USA', 'Employed', 'Married', 1, 'Male', '1990-06-15', '789 Maple Ave, Anytown USA'),
(678901234, 'Senior', 'Emily Nguyen', '123 Cherry Ln, Anytown USA', 'Employed', 'Single', 0, 'Female', '1980-12-25', '123 Cherry Ln, Anytown USA');

INSERT INTO `JobSeekerEducation` (`national_id`, `graduation_date`, `field_of_study`) VALUES
(123456789, '2021-05-15', 'Bachelor of Science in Computer Science'),
(234567890, '2017-12-20', 'Master of Business Administration'),
(345678901, '2007-08-10', 'Bachelor of Arts in English'),
(456789012, '2020-05-15', 'Associate in Applied Science in Accounting'),
(567890123, '2015-12-20', 'Master of Science in Computer Information Systems'),
(678901234, '2004-08-10', 'Bachelor of Arts in Economics');

INSERT INTO `JobSeekerEmail` (`national_id`, `email_address`) VALUES
(123456789, 'johnsmith@email.com'),
(234567890, 'janedoe@email.com'),
(345678901, 'bobjohnson@email.com'),
(456789012, 'samlee@email.com'),
(567890123, 'dkim@email.com'),
(678901234, 'enguyen@email.com');

INSERT INTO `JobSeekerPhoneNumber` (`national_id`, `phone_number`) VALUES
(123456789, '(555) 123-4567'),
(234567890, '(555) 234-5678'),
(345678901, '(555) 345-6789'),
(456789012, '(555) 678-9012'),
(567890123, '(555) 789-0123'),
(678901234, '(555) 890-1234');

INSERT INTO `Prerequisite` (`job_id`, `skill_id`) VALUES
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

INSERT INTO `Rating` (`job_seeker_id`, `employer_id`, `rating`) VALUES
(123456789, 1, 4),
(234567890, 2, 3),
(456789012, 3, 4),
(567890123, 4, 3),
(678901234, 3, 5);

INSERT INTO `SelectedSkills` (`job_seeker_national_id`, `skill_id`) VALUES
(123456789, 3),
(234567890, 1),
(345678901, 5),
(456789012, 1),
(567890123, 5),
(678901234, 9);

INSERT INTO `Skills` (`id`, `skill_type`, `skill_name`) VALUES
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

INSERT INTO `WorkExperience` (`job_seeker_national_id`, `id`, `employer_id`, `title`, `start_date`, `end_date`, `level`) VALUES
(123456789, 1, 1, 'Junior Software Developer', '2021-06-01', NULL, 'Entry'),
(234567890, 2, 2, 'Marketing Manager', '2018-03-15', '2022-05-20', 'Mid-Level'),
(345678901, 3, 1, 'Content Writer', '2009-08-01', '2015-12-31', 'Entry'),
(345678901, 4, 2, 'Product Manager', '2016-01-01', '2022-02-28', 'Senior'),
(456789012, 5, 3, 'Sales Associate', '2021-01-01', NULL, 'Entry'),
(567890123, 6, 4, 'Software Engineer', '2018-08-15', '2022-05-20', 'Mid-Level'),
(678901234, 7, 3, 'Store Manager', '2005-06-01', '2015-12-31', 'Entry'),
(678901234, 8, 4, 'VP of Engineering', '2016-01-01', '2022-02-28', 'Senior');


-- UPDATE TABLES
ALTER TABLE `Apply_Job`
  MODIFY `job_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

ALTER TABLE `Employer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;


-- UPDATE RECORDS
UPDATE Jobs SET display_status = 0 WHERE id = 4;
UPDATE Jobs SET display_status = 0 WHERE id = 5;
UPDATE Employer SET full_name = 'ABC Company', email = 'new@gmail.com' WHERE id = 1;
UPDATE WorkExperience SET title = 'Senior Software Engineer' WHERE id = 6;


-- DELETE RECORDS
DELETE FROM Jobs WHERE id = 6;
DELETE FROM WorkExperience WHERE id = 8;
DELETE FROM JobSeeker WHERE national_id = 678901234;

-- Trigger
DELIMITER $$
CREATE TRIGGER `update_job_status` AFTER UPDATE ON `Apply_Job` FOR EACH ROW BEGIN
    IF NEW.status = 'Accepted' THEN
        UPDATE Jobs SET display_status = 0 WHERE id = NEW.job_id;
    END IF;
END$$
DELIMITER ;

-- View
CREATE VIEW `JobSeekerInfo` AS JOBSEEKEr SELECT * FROM JobSeeker;
CREATE VIEW `EmployerInfo` AS EMPLOYER SELECT * FROM Employer;
CREATE VIEW `JobInfo` AS JOBS SELECT * FROM Jobs;

-- Procedure
DELIMITER $$
CREATE PROCEDURE `GetJobSeekerInfo` (IN `national_id` INT)
BEGIN
    SELECT * FROM JobSeeker WHERE national_id = national_id;
END$$
DELIMITER ;

-- Function
DELIMITER $$
CREATE FUNCTION `GetJobSeekerInfo` (national_id INT) RETURNS varchar(100) CHARSET utf8
BEGIN
    DECLARE full_name varchar(100);
    SELECT full_name INTO full_name FROM JobSeeker WHERE national_id = national_id;
    RETURN full_name;
END$$
DELIMITER ;
